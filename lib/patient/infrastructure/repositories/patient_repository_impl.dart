import 'package:h_c_1/patient/domain/datasources/patient_datasource.dart';
import 'package:h_c_1/patient/domain/entities/patient_entity.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/patient/infrastructure/datasources/patient_datasource_impl.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientDatasource datasource;

  PatientRepositoryImpl({PatientDatasource? datasource})
      : datasource = datasource ?? PatientDatasourceImpl();

  @override
  Future<Patient> getPatientByDni(String dni) {
    return datasource.getPatientByDni(dni);
  }
}
