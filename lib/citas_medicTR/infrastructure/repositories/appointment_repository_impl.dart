import 'package:h_c_1/citas_medicTR/domain/datasources/appointment_datasource.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/repositories/appointment_repository.dart';
import 'package:h_c_1/citas_medicTR/infrastructure/datasources/appointment_datasource_impl.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentDatasource datasource;

  AppointmentRepositoryImpl({AppointmentDatasource? datasource})
      : datasource = datasource ?? AppointmentDatasourceImpl();
  @override
  Future<void> createAppointment(
      CreateAppointments appointment, String medicID) {
    return datasource.createAppointment(appointment, medicID);
  }

  @override
  Future<void> deleteAppointment(Appointments appointment) {
    return datasource.deleteAppointment(appointment);
  }

  @override
  Future<List<Appointments>> getAppointmentsByStatus(String status) {
    print('getAppointmentsByStatus');
    return datasource.getAppointmentsByStatus(status);
  }

  @override
  Future<void> updateAppointment(Appointments appointment, String medicID) {
    return datasource.updateAppointment(appointment, medicID);
  }

  @override
  Future<List<Appointments>> getAppointmentsByDate(
      DateTime date, String medicID) {
    return datasource.getAppointmentsByDate(date, medicID);
  }

  @override
  Future<List<Appointments>> getAppointmentsByStatusAndMedicID(
      String status, String medicID) {
    return datasource.getAppointmentsByStatusAndMedicID(status, medicID);
  }

  @override
  Future<void> updateAppointmentDate(CreateAppointments appointment) {
    return datasource.updateAppointmentDate(appointment);
  }
}
