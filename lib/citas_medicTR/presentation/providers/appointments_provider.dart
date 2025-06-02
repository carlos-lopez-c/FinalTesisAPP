import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';
import 'package:h_c_1/config/routes/app_routes.dart';
import 'package:h_c_1/patient/domain/entities/patient_entity.dart';
import 'package:h_c_1/citas_medicTR/domain/repositories/appointment_repository.dart';
import 'package:h_c_1/citas_medicTR/infrastructure/repositories/appointment_repository_impl.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/patient/infrastructure/repositories/patient_repository_impl.dart';

final appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, AppointmentState>((ref) {
  final repository = AppointmentRepositoryImpl();
  final patientRepository = PatientRepositoryImpl();
  final authState = ref.watch(authProvider);
  return AppointmentNotifier(repository, patientRepository,
      medicID: authState.user!.medicID, ref: ref);
});

class AppointmentNotifier extends StateNotifier<AppointmentState> {
  final AppointmentRepository repository;
  final PatientRepository patientRepository;
  final String medicID;
  final Ref ref;
  AppointmentNotifier(this.repository, this.patientRepository,
      {required this.medicID, required this.ref})
      : super(AppointmentState()) {
    listarCitas(estado: 'Pendiente'); // ✅ Cargar todas las citas al iniciar
  }

  /// 🔹 Listar citas (todas o por estado)
  Future<void> listarCitas({String estado = ''}) async {
    try {
      state = state.copyWith(loading: true);
      print('🔹 Cargando citas...');
      final citas = await repository.getAppointmentsByStatus(estado);
      state = state.copyWith(loading: false, citas: citas);
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener citas');
    }
  }

  /// 🔹 Crear una nueva cita
  Future<void> crearCita(CreateAppointments nuevaCita) async {
    try {
      state = state.copyWith(loading: true);
      await repository.createAppointment(nuevaCita, medicID);
      await getAppointmentsByStatusAndMedicID(
          "Agendado"); // ✅ Recargar citas después de crear una nueva

      ref.read(goRouterProvider).pop();
    } catch (e) {
      print('🔴 Error al crear cita: $e');
      state = state.copyWith(
          loading: false, errorMessage: e.toString() ?? 'Error al crear cita');
    }
  }

  /// 🔹 Seleccionar una cita específica
  void seleccionarCita(Appointments cita) {
    state = state.copyWith(citaSeleccionada: cita);
  }

  void onDateSelected(DateTime date) {
    state = state.copyWith(calendarioCitaSeleccionada: date);
    getAppointmentsByDate(date);
  }

  void getPacienteByDni(String dni) async {
    try {
      print('🔹 Buscando paciente por DNI: $dni');
      state = state.copyWith(loading: true);
      final paciente = await patientRepository.getPatientByDni(dni);
      state = state.copyWith(loading: false, paciente: paciente);
      print('🔹 Paciente: ${paciente.toJson()}');
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener paciente');
    }
  }

  Future<void> getAppointmentsByDate(DateTime date) async {
    try {
      state = state.copyWith(loading: true);
      print('🔹 Buscando citas para la fecha: $date');

      final formattedDate = date.toIso8601String().split('T')[0]; // YYYY-MM-DD
      final appointments = await repository.getAppointmentsByDate(
          DateTime.parse(formattedDate), medicID);

      state = state.copyWith(
        loading: false,
        citasDelDia: appointments,
        calendarioCitaSeleccionada: date,
      );

      print('✅ Citas encontradas: ${appointments.length}');
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener citas por fecha');
    }
  }

  Future<void> getAppointmentsByStatusAndMedicID(String status) async {
    try {
      state = state.copyWith(loading: true);
      print('🔹 Buscando citas por estado: $status');

      final appointments =
          await repository.getAppointmentsByStatusAndMedicID(status, medicID);

      state = state.copyWith(loading: false, citasAgendadas: appointments);

      print('✅ Citas encontradas: ${appointments.length}');
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener citas por estado');
    }
  }

  Future<void> actualizarCita(Appointments cita) async {
    try {
      print('🔹 Actualizando cita...');
      state = state.copyWith(loading: true);
      print("IID: " + medicID);
      cita.copyWith(status: 'Agendado', doctorId: medicID);
      await repository.updateAppointment(cita, medicID);
      await listarCitas(
          estado: "Pendiente"); // ✅ Recargar citas después de actualizar
      ref.read(goRouterProvider).pop();
    } catch (e) {
      print('🔴 Error al actualizar cita: $e');
      state = state.copyWith(
          loading: false, errorMessage: 'Error al actualizar cita');
    }
  }

  /// 🔹 Actualizar estado de una cita
  Future<void> actualizarEstadoCita(String citaId, String nuevoEstado) async {
    try {
      state = state.copyWith(loading: true);
      // await repository.updateAppointment(citaId, nuevoEstado);

      // ✅ Actualizar la lista localmente sin necesidad de llamar al backend otra vez
      final nuevasCitas = state.citas.map((cita) {
        if (cita.id == citaId) {
          return cita.copyWith(status: nuevoEstado);
        }
        return cita;
      }).toList();

      state = state.copyWith(loading: false, citas: nuevasCitas);

      // ✅ Si la cita seleccionada es la que se actualizó, actualizar también
      if (state.citaSeleccionada?.id == citaId) {
        state = state.copyWith(
            citaSeleccionada:
                state.citaSeleccionada!.copyWith(status: nuevoEstado));
      }
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al actualizar estado');
    }
  }
}

/// 📌 Estado del provider de citas
class AppointmentState {
  final bool loading;
  final List<Appointments> citas;
  final List<Appointments> citasAgendadas;
  final List<Appointments> citasDelDia;
  final Patient? paciente;
  final Appointments? citaSeleccionada;
  final DateTime calendarioCitaSeleccionada;
  final String errorMessage;

  AppointmentState(
      {this.loading = false,
      this.citas = const [],
      this.citasAgendadas = const [],
      this.citasDelDia = const [],
      this.citaSeleccionada,
      DateTime? calendarioCitaSeleccionada,
      this.errorMessage = '',
      this.paciente})
      : calendarioCitaSeleccionada =
            calendarioCitaSeleccionada ?? DateTime.now();

  AppointmentState copyWith({
    bool? loading,
    List<Appointments>? citas,
    List<Appointments>? citasDelDia,
    List<Appointments>? citasAgendadas,
    DateTime? calendarioCitaSeleccionada,
    Appointments? citaSeleccionada,
    Patient? paciente,
    String? errorMessage,
  }) {
    return AppointmentState(
      loading: loading ?? this.loading,
      citas: citas ?? this.citas,
      citasDelDia: citasDelDia ?? this.citasDelDia,
      citasAgendadas: citasAgendadas ?? this.citasAgendadas,
      citaSeleccionada: citaSeleccionada ?? this.citaSeleccionada,
      calendarioCitaSeleccionada:
          calendarioCitaSeleccionada ?? this.calendarioCitaSeleccionada,
      errorMessage: errorMessage ?? this.errorMessage,
      paciente: paciente ?? this.paciente,
    );
  }
}
