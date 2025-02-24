import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';

abstract class AppointmentRepository {
  Future<List<Appointments>> getAppointmentsByStatus(String status);
  Future<List<Appointments>> getAppointmentsByDate(
      DateTime date, String medicID);
  Future<List<Appointments>> getAppointmentsByStatusAndMedicID(
      String status, String medicID);
  Future<void> createAppointment(
      CreateAppointments appointment, String medicID);
  Future<void> updateAppointment(Appointments appointment, String medicID);
  Future<void> updateAppointmentDate(CreateAppointments appointment);
  Future<void> deleteAppointment(Appointments appointment);
}
