import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';

abstract class AppointmentDatasource {
  Future<List<Appointments>> getAppointmentsByStatus(String status);
  Future<void> createAppointment(
      CreateAppointments appointment, String medicID);
  Future<void> updateAppointment(Appointments appointment, String medicID);
  Future<void> deleteAppointment(Appointments appointment);
  Future<List<Appointments>> getAppointmentsByStatusAndMedicID(
      String status, String medicID);
  Future<List<Appointments>> getAppointmentsByDate(
      DateTime date, String medicID);
  Future<void> updateAppointmentDate(CreateAppointments appointment);
}
