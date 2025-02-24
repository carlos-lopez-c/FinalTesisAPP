import 'package:h_c_1/patient/domain/entities/patient_entity.dart';

abstract class PatientRepository {
  Future<Patient> getPatientByDni(String dni);
}
