import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:h_c_1/citas_medicTR/domain/datasources/appointment_datasource.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';
import 'package:h_c_1/shared/infrastructure/errors/handle_error.dart';

class AppointmentDatasourceImpl implements AppointmentDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  Future<List<Appointments>> getAppointmentsByStatus(String status) async {
    try {
      print('getAppointmentsByStatus: $status');

      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('status', isEqualTo: status)
          .get();

      List<Appointments> appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Appointments.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();

      print("Citas obtenidas: ${appointments.length}");
      return appointments;
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<List<Appointments>> getAppointmentsByDate(
      DateTime date, String medicID) async {
    try {
      String formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('date', isEqualTo: formattedDate)
          .where('doctorID', isEqualTo: medicID)
          .get();

      List<Appointments> appointments = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final appointment = Appointments.fromJson(data);
        return appointment.copyWith(id: doc.id);
      }).toList();

      return appointments;
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<void> updateAppointment(
      Appointments appointment, String medicID) async {
    try {
      print('Actualizando cita: ${medicID}');
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
      await _firestore
          .collection('appointments')
          .doc(appointment.id)
          .update(appointment.toJson()
            ..addAll({
              'doctor': '$firstName $lastName',
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
      String status, String medicID) async {
    try {
      print(
          'getAppointmentsByStatusAndMedicID: status=$status, medicID=$medicID');

      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('status', isEqualTo: status)
          .where('doctorID', isEqualTo: medicID)
          .get();

      List<Appointments> appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Appointments.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();

      print("Citas obtenidas: ${appointments.length}");
      return appointments;
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }
}
