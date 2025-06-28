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
  Future<List<Appointments>> getAppointmentsByStatus(
      String status, String specialtyTherapyId) {
    return datasource.getAppointmentsByStatus(status, specialtyTherapyId);
  }

  @override
  Future<void> updateAppointment(Appointments appointment, String medicID) {
    return datasource.updateAppointment(appointment, medicID);
  }

  @override
  Future<List<Appointments>> getAppointmentsByDate(
      DateTime date, String medicID, String specialtyTherapyId) {
    return datasource.getAppointmentsByDate(date, medicID, specialtyTherapyId);
  }

  @override
  Future<List<Appointments>> getAppointmentsByStatusAndMedicID(
      String status, String medicID, String specialtyTherapyId) {
    return datasource.getAppointmentsByStatusAndMedicID(
        status, medicID, specialtyTherapyId);
  }

  @override
  Future<List<Appointments>> getAppointmentsByPatientAndMedicID(
      String patientId, String medicID, String specialtyTherapyId) {
    return datasource.getAppointmentsByPatientAndMedicID(
        patientId, medicID, specialtyTherapyId);
  }

  @override
  Future<void> updateAppointmentDate(CreateAppointments appointment) {
    return datasource.updateAppointmentDate(appointment);
  }

  @override
  Stream<List<Appointments>> watchAppointmentsByStatus(
      String status, String specialtyTherapyId) {
    return datasource.watchAppointmentsByStatus(status, specialtyTherapyId);
  }

  @override
  Stream<List<Appointments>> watchAppointmentsByStatusAndMedicID(
      String status, String medicID, String specialtyTherapyId) {
    return datasource.watchAppointmentsByStatusAndMedicID(
        status, medicID, specialtyTherapyId);
  }

  @override
  Stream<List<Appointments>> watchAppointmentsByPatientAndMedicID(
      String patientId, String medicID, String specialtyTherapyId) {
    return datasource.watchAppointmentsByPatientAndMedicID(
        patientId, medicID, specialtyTherapyId);
  }

  @override
  Stream<List<Appointments>> watchAppointmentsByDateAndMedicID(
      String date, String medicID, String specialtyTherapyId) {
    return datasource.watchAppointmentsByDateAndMedicID(
        date, medicID, specialtyTherapyId);
  }
}
