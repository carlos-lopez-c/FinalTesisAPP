import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:h_c_1/auth/infrastructure/errors/auth_errors.dart';
import 'package:h_c_1/citas_medicTR/domain/datasources/appointment_datasource.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';

class AppointmentDatasourceImpl implements AppointmentDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createAppointment(
      CreateAppointments appointment, String medicID) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('medics').doc(medicID).get();

      if (!docSnapshot.exists) {
        throw Exception('Médico no encontrado');
      }

      // Obtiene el nombre del médico
      String name = ('${docSnapshot['firsname']} ${docSnapshot['lastname']}') ??
          'Nombre no disponible';
      // Convierte el objeto appointment a un mapa
      Map<String, dynamic> appointmentData = appointment.toJson();
      appointmentData['doctor'] = name;
      // Agrega la cita a la colección "appointments" en Firestore
      await _firestore.collection('appointments').add(appointmentData);
      print("Cita creada correctamente en Firestore");
    } catch (e) {
      print("Error al crear la cita: $e");
      throw Exception('Error al crear la cita');
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

      // Consulta Firestore para obtener las citas con el estado "Pendiente"
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments') // Colección de citas
          .where('status', isEqualTo: status) // Filtra por estado
          .get();

      // Mapea los documentos a objetos Appointments
      List<Appointments> appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Appointments.fromJson({
          ...data,
          'id': doc.id, // Asegúrate de incluir el ID del documento
        });
      }).toList();

      print("Citas obtenidas: ${appointments.length}");
      return appointments;
    } catch (e) {
      print("Error al obtener las citas: $e");
      throw CustomError('Error al obtener las citas');
    }
  }

  @override
  Future<List<Appointments>> getAppointmentsByDate(
      DateTime date, String medicID) async {
    try {
      // Formatea la fecha para que coincida con el formato almacenado en Firestore
      String formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      // Consulta las citas que coinciden con la fecha y el medicID proporcionados
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('date', isEqualTo: formattedDate)
          .where('doctorID', isEqualTo: medicID)
          .get();

      // Mapea los documentos obtenidos a objetos Appointments y agrega el ID del documento
      List<Appointments> appointments = querySnapshot.docs.map((doc) {
        // Obtén los datos del documento
        final data = doc.data() as Map<String, dynamic>;
        // Crea un objeto Appointments a partir de los datos
        final appointment = Appointments.fromJson(data);
        // Asigna el ID del documento al objeto Appointments
        return appointment.copyWith(id: doc.id);
      }).toList();

      return appointments;
    } catch (e) {
      print("Error al obtener las citas: $e");
      throw Exception('Error al obtener las citas');
    }
  }

  @override
  Future<void> updateAppointment(
      Appointments appointment, String medicID) async {
    try {
      // Obtener el nombre del médico desde Firestore
      print('Actualizando cita: ${medicID}');
      DocumentSnapshot medicSnapshot = await _firestore
          .collection('medics') // Colección de médicos
          .doc(medicID) // ID del médico
          .get();

      if (!medicSnapshot.exists) {
        throw Exception('Médico no encontrado');
      }

      // Obtener el nombre del médico
      String firstName = medicSnapshot['firsname'] ?? 'Nombre no disponible';
      String lastName = medicSnapshot['lastname'] ?? 'Apellido no disponible';

      // Actualizar la cita en Firestore
      await _firestore
          .collection('appointments') // Colección de citas
          .doc(appointment.id) // ID de la cita
          .update({
        'status': appointment.status, // Actualizar el estado
        'doctor': '$firstName $lastName',
        'doctorID': medicID,
        // Puedes agregar más campos si es necesario
      });

      print("Cita actualizada correctamente en Firestore");
    } catch (e) {
      print("Error al actualizar la cita: $e");
      throw Exception('Error al actualizar la cita');
    }
  }

  @override
  Future<void> updateAppointmentDate(CreateAppointments appointment) async {
    try {
      // Actualizar la cita en Firestore

      await _firestore
          .collection('appointments') // Colección de citas
          .doc(appointment.id) // ID de la cita
          .update(appointment.toJson());

      print("Cita actualizada correctamente en Firestore");
    } catch (e) {
      print("Error al actualizar la cita: $e");
      throw Exception('Error al actualizar la cita');
    }
  }

  @override
  Future<List<Appointments>> getAppointmentsByStatusAndMedicID(
      String status, String medicID) async {
    try {
      print(
          'getAppointmentsByStatusAndMedicID: status=$status, medicID=$medicID');

      // Consulta Firestore para obtener las citas con el estado "Agendado" y el medicID especificado
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments') // Colección de citas
          .where('status', isEqualTo: status) // Filtra por estado "Agendado"
          .where('doctorID', isEqualTo: medicID) // Filtra por medicID
          .get();

      // Mapea los documentos a objetos Appointments
      List<Appointments> appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Appointments.fromJson({
          ...data,
          'id': doc.id, // Asegúrate de incluir el ID del documento
        });
      }).toList();

      print("Citas obtenidas: ${appointments.length}");
      return appointments;
    } catch (e) {
      print("Error al obtener las citas: $e");
      throw CustomError('Error al obtener las citas');
    }
  }
}
