import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';

abstract class AppointmentRepository {
  Future<List<Appointments>> getAppointmentsByStatus(
      String status, String specialtyTherapyId);
  Future<List<Appointments>> getAppointmentsByDate(
      DateTime date, String medicID, String specialtyTherapyId);
  Future<List<Appointments>> getAppointmentsByStatusAndMedicID(
      String status, String medicID, String specialtyTherapyId);
  Future<List<Appointments>> getAppointmentsByPatientAndMedicID(
      String patientId, String medicID, String specialtyTherapyId);
  Future<void> createAppointment(
      CreateAppointments appointment, String medicID);
  Future<void> updateAppointment(Appointments appointment, String medicID);
  Future<void> updateAppointmentDate(CreateAppointments appointment);
  Future<void> deleteAppointment(Appointments appointment);

  /// 🔹 Métodos en tiempo real (STREAMS)
  Stream<List<Appointments>> watchAppointmentsByStatus(
      String status, String specialtyTherapyId);
  Stream<List<Appointments>> watchAppointmentsByStatusAndMedicID(
      String status, String medicID, String specialtyTherapyId);
  Stream<List<Appointments>> watchAppointmentsByPatientAndMedicID(
      String patientId, String medicID, String specialtyTherapyId);
  Stream<List<Appointments>> watchAppointmentsByDateAndMedicID(
      String date, String medicID, String specialtyTherapyId);
}
