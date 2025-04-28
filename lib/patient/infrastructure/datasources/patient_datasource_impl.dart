import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:h_c_1/patient/domain/datasources/patient_datasource.dart';
import 'package:h_c_1/patient/domain/entities/patient_entity.dart';
import 'package:h_c_1/shared/infrastructure/errors/handle_error.dart';

class PatientDatasourceImpl implements PatientDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Patient> getPatientByDni(String dni) async {
    print('🟢 Buscando paciente por DNI: $dni');
    try {
      // Obtiene el documento del paciente por su ID
      QuerySnapshot querySnapshot = await _firestore
          .collection('patients')
          .where('dni', isEqualTo: dni)
          .get();

      // Verificar si hay documentos en el resultado
      if (querySnapshot.docs.isEmpty) {
        print('❌ No se encontró paciente con DNI: $dni');
        throw FirebaseException(
            plugin: 'firestore',
            code: 'not-found',
            message: 'No se encontró paciente con DNI: $dni');
      }

      // Si hay documentos, tomar el primero
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      print('🟢 Paciente encontrado: ${docSnapshot.id}');
      if (docSnapshot.exists) {
        // Convierte los datos del documento a un mapa
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        // Convierte la cadena de fecha a DateTime
        DateTime birthdate;
        if (data['birthdate'] is String) {
          birthdate = DateTime.parse(data['birthdate']);
        } else if (data['birthdate'] is Timestamp) {
          birthdate = (data['birthdate'] as Timestamp).toDate();
        } else {
          throw Exception('Formato de fecha no válido');
        }
        print('Data: $data');

        // Crea una instancia de Patient a partir de los datos
        Patient patient = Patient(
            id: docSnapshot.id,
            firstname: data['firstname'] ?? 'Nombre no disponible',
            lastname: data['lastname'] ?? 'Apellido no disponible',
            legalGuardianId: data['legalGuardianId'] ?? 'ID no disponible',
            birthdate: birthdate,
            legalGuardian:
                data['legalGuardian'] ?? 'Representante no disponible',
            dni: data['dni'] ?? 'DNI no disponible',
            disability: List<String>.from(data['disability'] ?? []),
            gender: data['gender'] ?? 'Género no disponible',
            relationshipRepresentativePatient:
                data['relationshipRepresentativePatient'] ??
                    'Relación no disponible',
            healthInsurance: data['healthInsurance'] ?? 'Seguro no disponible',
            currentMedications:
                List<String>.from(data['currentMedications'] ?? []),
            allergies: List<String>.from(data['allergies'] ?? []),
            historyTreatmentsReceived:
                List<String>.from(data['historyTreatmentsReceived'] ?? []));

        return patient;
      } else {
        print('Paciente no encontrado');
        throw FirebaseException(
            plugin: 'firestore',
            code: 'not-found',
            message: 'Paciente no encontrado en la base de datos.');
      }
    } on FirebaseException catch (e) {
      print(
          "FirebaseException capturado en datasource: ${e.code} - ${e.message}");
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      print("PlatformException capturado en datasource: ${e.code}");
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      print("Error genérico capturado en datasource: $e (${e.runtimeType})");
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }
}
