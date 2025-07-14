import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:h_c_1/citas_medicTR/domain/datasources/appointment_datasource.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';
import 'package:h_c_1/shared/infrastructure/errors/handle_error.dart';
import 'package:intl/intl.dart';

class AppointmentDatasourceImpl implements AppointmentDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Método auxiliar para obtener el nombre de la especialidad
  Future<String> _getSpecialtyTherapyName(String specialtyTherapyId) async {
    try {
      final doc = await _firestore
          .collection('specialtyTherapy')
          .doc(specialtyTherapyId)
          .get();
      if (doc.exists) {
        return doc.data()?['name'] ?? 'Especialidad no encontrada';
      }
      return 'Especialidad no encontrada';
    } catch (e) {
      print('Error al obtener nombre de especialidad: $e');
      return 'Error al cargar especialidad';
    }
  }

  /// 🔹 Método auxiliar para enriquecer las citas con el nombre de la especialidad (optimizado)
  Future<List<Appointments>> _enrichAppointmentsWithSpecialtyName(
      List<Appointments> appointments) async {
    if (appointments.isEmpty) return appointments;

    // Obtener IDs únicos de especialidades que necesitan ser enriquecidas
    final specialtyIds = appointments
        .where((appointment) => 
            appointment.specialtyTherapyId != null && 
            appointment.specialtyTherapy.isEmpty)
        .map((appointment) => appointment.specialtyTherapyId!)
        .toSet();

    if (specialtyIds.isEmpty) return appointments;

    // Hacer una sola consulta batch para todas las especialidades
    final specialtyNamesMap = <String, String>{};
    
    try {
      final specialtyDocs = await _firestore
          .collection('specialtyTherapy')
          .where(FieldPath.documentId, whereIn: specialtyIds.toList())
          .get();

      for (final doc in specialtyDocs.docs) {
        specialtyNamesMap[doc.id] = doc.data()['name'] ?? 'Especialidad no encontrada';
      }
    } catch (e) {
      print('Error al obtener especialidades en batch: $e');
      // Fallback al método original si falla el batch
      return _enrichAppointmentsWithSpecialtyNameFallback(appointments);
    }

    // Enriquecer las citas con los nombres obtenidos
    return appointments.map((appointment) {
      if (appointment.specialtyTherapyId != null &&
          appointment.specialtyTherapy.isEmpty) {
        final specialtyName = specialtyNamesMap[appointment.specialtyTherapyId!] ?? 
                              'Especialidad no encontrada';
        return appointment.copyWith(specialtyTherapy: specialtyName);
      }
      return appointment;
    }).toList();
  }

  /// 🔹 Método de fallback para enriquecimiento individual
  Future<List<Appointments>> _enrichAppointmentsWithSpecialtyNameFallback(
      List<Appointments> appointments) async {
    final enrichedAppointments = <Appointments>[];

    for (final appointment in appointments) {
      if (appointment.specialtyTherapyId != null &&
          appointment.specialtyTherapy.isEmpty) {
        final specialtyName =
            await _getSpecialtyTherapyName(appointment.specialtyTherapyId!);
        enrichedAppointments
            .add(appointment.copyWith(specialtyTherapy: specialtyName));
      } else {
        enrichedAppointments.add(appointment);
      }
    }

    return enrichedAppointments;
  }

  /// 🔹 Método auxiliar para enriquecer streams de citas
  Stream<List<Appointments>> _enrichStreamWithSpecialtyName(
      Stream<List<Appointments>> appointmentsStream) {
    return appointmentsStream.asyncMap((appointments) async {
      return await _enrichAppointmentsWithSpecialtyName(appointments);
    });
  }

  @override
  Future<void> createAppointment(
      CreateAppointments appointment, String medicID) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('medic').doc(medicID).get();
      if (!docSnapshot.exists) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'medic-not-found',
            message: 'Médico no encontrado');
      }
      String name = ('${docSnapshot['firstname']} ${docSnapshot['lastname']}');
      print('Creando cita : $name');
      Map<String, dynamic> appointmentData = appointment.toJson();
      appointmentData['doctor'] = name;
      await _firestore.collection('appointments').add(appointmentData);
      print("Cita creada correctamente en Firestore");
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<void> deleteAppointment(Appointments appointment) {
    // TODO: implement deleteAppointment
    throw UnimplementedError();
  }

  @override
  Future<List<Appointments>> getAppointmentsByStatus(
      String status, String specialtyTherapyId) async {
    try {
      final nowAsString = DateFormat('yyyy-MM-dd').format(DateTime.now());
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('status', isEqualTo: status)
          .where('specialtyTherapyId', isEqualTo: specialtyTherapyId)
          .where('date', isGreaterThanOrEqualTo: nowAsString)
          .get();

      final appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Appointments.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();

      // Enriquecer con el nombre de la especialidad
      return await _enrichAppointmentsWithSpecialtyName(appointments);
    } catch (e) {
      throw Exception('Error al obtener citas por status y especialidad');
    }
  }

  @override
  Future<List<Appointments>> getAppointmentsByDate(
      DateTime date, String medicID, String specialtyTherapyId) async {
    try {
      String nowAsString =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      String formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('date', isEqualTo: formattedDate)
          .where('doctorID', isEqualTo: medicID)
          .where('specialtyTherapyId', isEqualTo: specialtyTherapyId)
          .where('date', isGreaterThanOrEqualTo: nowAsString)
          .get();

      final appointments = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final appointment = Appointments.fromJson(data);
        return appointment.copyWith(id: doc.id);
      }).toList();

      // Enriquecer con el nombre de la especialidad
      return await _enrichAppointmentsWithSpecialtyName(appointments);
    } catch (e) {
      throw Exception(
          'Error al obtener citas por fecha, doctor y especialidad');
    }
  }

  @override
  Future<void> updateAppointment(
      Appointments appointment, String medicID) async {
    try {
      print('Actualizando cita: ${medicID}');
      if (appointment.status.toLowerCase() == 'pendiente') {
        // Limpiar doctor y doctorID en Firestore
        await _firestore.collection('appointments').doc(appointment.id).update({
          'status': appointment.status,
          'doctor': '',
          'doctorID': '',
        });
        print("Cita actualizada a pendiente y doctor limpiado en Firestore");
      } else {
        DocumentSnapshot medicSnapshot =
            await _firestore.collection('medic').doc(medicID).get();

        if (!medicSnapshot.exists) {
          throw FirebaseException(
              plugin: 'firestore',
              code: 'medic-not-found',
              message: 'Médico no encontrado');
        }

        String firstName = medicSnapshot['firstname'] ?? 'Nombre no disponible';
        String lastName = medicSnapshot['lastname'] ?? 'Apellido no disponible';
        print('Nombre del médico: $firstName $lastName');

        await _firestore.collection('appointments').doc(appointment.id).update({
          'status': appointment.status,
          'doctor': '$firstName $lastName',
          'doctorID': medicID,
        });
        print("Cita actualizada correctamente en Firestore");
      }
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<void> updateAppointmentDate(CreateAppointments appointment) async {
    try {
      if (appointment.id == null || appointment.id!.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'appointment-id-empty',
            message: 'El ID de la cita es necesario para actualizar');
      }
      DocumentSnapshot medicSnapshot =
          await _firestore.collection('medic').doc(appointment.doctorId).get();

      if (!medicSnapshot.exists) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'medic-not-found',
            message: 'Médico no encontrado');
      }

      String firstName = medicSnapshot['firstname'] ?? 'Nombre no disponible';
      String lastName = medicSnapshot['lastname'] ?? 'Apellido no disponible';

      if (appointment.status == 'Pendiente') {
        appointment.doctorId = ''; // Limpiar doctorId si la cita está pendiente
        appointment.doctor = ''; // Limpiar doctor si la cita está pendiente
      } else if (appointment.status == 'Agendado') {
        appointment.doctor = '$firstName $lastName';
      }

      await _firestore
          .collection('appointments')
          .doc(appointment.id)
          .update(appointment.toJson()
            ..addAll({
              'doctor': appointment.doctor,
              'doctorID': appointment.doctorId,
            }));

      print("Cita actualizada correctamente en Firestore");
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<List<Appointments>> getAppointmentsByStatusAndMedicID(
      String status, String medicID, String specialtyTherapyId) async {
    try {
      String nowAsString =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('status', isEqualTo: status)
          .where('doctorID', isEqualTo: medicID)
          .where('specialtyTherapyId', isEqualTo: specialtyTherapyId)
          .where('date', isGreaterThanOrEqualTo: nowAsString)
          .get();
      print('nowAsString: $nowAsString');
      final appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Appointments.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();

      // Enriquecer con el nombre de la especialidad
      return await _enrichAppointmentsWithSpecialtyName(appointments);
    } catch (e) {
      throw Exception(
          'Error al obtener citas por status, doctor y especialidad');
    }
  }

  @override
  Future<List<Appointments>> getAppointmentsByPatientAndMedicID(
      String patientId, String medicID, String specialtyTherapyId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('patientID', isEqualTo: patientId)
          .where('doctorID', isEqualTo: medicID)
          .where('specialtyTherapyId', isEqualTo: specialtyTherapyId)
          .where('status', isEqualTo: 'Completado')
          .get();

      final appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Appointments.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();

      // Enriquecer con el nombre de la especialidad
      return await _enrichAppointmentsWithSpecialtyName(appointments);
    } catch (e) {
      throw Exception(
          'Error al obtener citas por paciente, doctor y especialidad');
    }
  }

  @override
  Stream<List<Appointments>> watchAppointmentsByStatus(
      String status, String specialtyTherapyId) {
    final nowAsString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final baseStream = _firestore
        .collection('appointments')
        .where('status', isEqualTo: status)
        .where('specialtyTherapyId', isEqualTo: specialtyTherapyId)
        .where('date', isGreaterThanOrEqualTo: nowAsString)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Appointments.fromJson({
                ...data,
                'id': doc.id,
              });
            }).toList());

    return _enrichStreamWithSpecialtyName(baseStream);
  }

  @override
  Stream<List<Appointments>> watchAppointmentsByStatusAndMedicID(
      String status, String medicID, String specialtyTherapyId) {
    final nowAsString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final baseStream = _firestore
        .collection('appointments')
        .where('status', isEqualTo: status)
        .where('doctorID', isEqualTo: medicID)
        .where('specialtyTherapyId', isEqualTo: specialtyTherapyId)
        .where('date', isGreaterThanOrEqualTo: nowAsString)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Appointments.fromJson({
                ...data,
                'id': doc.id,
              });
            }).toList());

    return _enrichStreamWithSpecialtyName(baseStream);
  }

  @override
  Stream<List<Appointments>> watchAppointmentsByPatientAndMedicID(
      String patientId, String medicID, String specialtyTherapyId) {
    final baseStream = _firestore
        .collection('appointments')
        .where('patientID', isEqualTo: patientId)
        .where('doctorID', isEqualTo: medicID)
        .where('specialtyTherapyId', isEqualTo: specialtyTherapyId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Appointments.fromJson({
                ...data,
                'id': doc.id,
              });
            }).toList());

    return _enrichStreamWithSpecialtyName(baseStream);
  }

  @override
  Stream<List<Appointments>> watchAppointmentsByDateAndMedicID(
      String date, String medicID, String specialtyTherapyId) {
    final baseStream = _firestore
        .collection('appointments')
        .where('date', isEqualTo: date)
        .where('doctorID', isEqualTo: medicID)
        .where('status', isEqualTo: 'Agendado')
        .where('specialtyTherapyId', isEqualTo: specialtyTherapyId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Appointments.fromJson({
                ...data,
                'id': doc.id,
              });
            }).toList());

    return _enrichStreamWithSpecialtyName(baseStream);
  }
}
