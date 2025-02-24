import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:h_c_1/patient/domain/datasources/patient_datasource.dart';
import 'package:h_c_1/patient/domain/entities/patient_entity.dart';

class PatientDatasourceImpl implements PatientDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Patient> getPatientByDni(String dni) async {
    try {
      // Obtiene el documento del paciente por su ID
      DocumentSnapshot docSnapshot = await _firestore
          .collection('patients')
          .where('dni', isEqualTo: dni)
          .get()
          .then((value) => value.docs.first);

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
          legalGuardian: data['legalGuardian'] ?? 'Representante no disponible',
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
              List<String>.from(data['historyTreatmentsReceived'] ?? [])
        );

        return patient;
      } else {
        throw Exception('Paciente no encontrado');
      }
    } catch (e) {
      print('Error al obtener la información del paciente: $e');
      throw Exception('Error al obtener la información del paciente');
    }
  }
}
