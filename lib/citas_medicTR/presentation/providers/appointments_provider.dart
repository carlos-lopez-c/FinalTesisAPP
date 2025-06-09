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
import 'package:h_c_1/shared/infrastructure/errors/custom_error.dart';

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

  void clearError() {
    state = state.copyWith(errorMessage: '');
  }

  void clearSuccess() {
    state = state.copyWith(successMessage: '');
  }

  /// 🔹 Listar citas (todas o por estado)
  Future<void> listarCitas({String estado = ''}) async {
    print('🟢 Cargando citas...');
    state = state.copyWith(loading: true);
    try {
      final citas = await repository.getAppointmentsByStatus(estado);
      state = state.copyWith(loading: false, citas: citas);
    } on CustomError catch (e) {
      print('🔴 Error al obtener citas: ${e.message}');
      state = state.copyWith(
          loading: false, errorMessage: e.message ?? 'Error al obtener citas');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  /// 🔹 Crear una nueva cita
  Future<void> crearCita(CreateAppointments nuevaCita) async {
    state = state.copyWith(loading: true);
    try {
      await repository.createAppointment(nuevaCita, medicID);
      await getAppointmentsByStatusAndMedicID(
          "Agendado"); // ✅ Recargar citas después de crear una nueva
      state = state.copyWith(successMessage: 'Cita creada correctamente');
      ref.read(goRouterProvider).pop();
    } on CustomError catch (e) {
      print('🔴 Error al crear cita: ${e.message}');
      state = state.copyWith(errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
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
    print('🟢 Buscando paciente por DNI: $dni');
    state = state.copyWith(loading: true);
    try {
      final paciente = await patientRepository.getPatientByDni(dni);
      state = state.copyWith(
          loading: false,
          paciente: paciente,
          successMessage: 'Paciente encontrado correctamente');
      print('🔹 Paciente: ${paciente.toJson()}');
    } on CustomError catch (e) {
      print('🔴 Error al obtener paciente: ${e.message}');
      state = state.copyWith(loading: false, errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> getAppointmentsByDate(DateTime date) async {
    print('🟢 Buscando citas para la fecha: $date');
    state = state.copyWith(loading: true);
    try {
      final formattedDate = date.toIso8601String().split('T')[0]; // YYYY-MM-DD
      final appointments = await repository.getAppointmentsByDate(
          DateTime.parse(formattedDate), medicID);

// Solo las citas del dia que esten con estado "Agendado"
      appointments.removeWhere((cita) => cita.status != 'Agendado');
      print('✅ Citas encontradas: ${appointments.length}');
      state = state.copyWith(
          loading: false,
          citasDelDia: appointments,
          calendarioCitaSeleccionada: date);
    } on CustomError catch (e) {
      print('🔴 Error al obtener citas por fecha: ${e.message}');
      state = state.copyWith(
          loading: false,
          errorMessage: e.message ?? 'Error al obtener citas por fecha');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> getAppointmentsByStatusAndMedicID(String status) async {
    print('🟢 Buscando citas por estado: $status');
    state = state.copyWith(loading: true);
    try {
      final appointments =
          await repository.getAppointmentsByStatusAndMedicID(status, medicID);

      state = state.copyWith(loading: false, citasAgendadas: appointments);

      print('✅ Citas encontradas: ${appointments.length}');
    } on CustomError catch (e) {
      print('🔴 Error al obtener citas por estado: ${e.message}');
      state = state.copyWith(
          loading: false,
          errorMessage: e.message ?? 'Error al obtener citas por estado');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> actualizarCita(Appointments cita) async {
    print('🟢 Actualizando cita...');
    state = state.copyWith(loading: true);
    try {
      print("ID Médico: $medicID");
      cita.copyWith(status: 'Agendado', doctorId: medicID);
      await repository.updateAppointment(cita, medicID);
      await listarCitas(
          estado: "Pendiente"); // ✅ Recargar citas después de actualizar
      state = state.copyWith(successMessage: 'Cita actualizada correctamente');
      ref.read(goRouterProvider).pop();
    } on CustomError catch (e) {
      print('🔴 Error al actualizar cita: ${e.message}');
      state =
          state.copyWith(errorMessage: e.message ?? 'Error al actualizar cita');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  /// 🔹 Actualizar estado de una cita
  Future<void> actualizarEstadoCita(String citaId, String nuevoEstado) async {
    print('🟢 Actualizando estado de cita');
    state = state.copyWith(loading: true);
    try {
      // ✅ Actualizar la lista localmente sin necesidad de llamar al backend otra vez
      final nuevasCitas = state.citas.map((cita) {
        if (cita.id == citaId) {
          return cita.copyWith(status: nuevoEstado);
        }
        return cita;
      }).toList();

      state = state.copyWith(
          loading: false,
          citas: nuevasCitas,
          successMessage: 'Estado de cita actualizado correctamente');

      // ✅ Si la cita seleccionada es la que se actualizó, actualizar también
      if (state.citaSeleccionada?.id == citaId) {
        state = state.copyWith(
            citaSeleccionada:
                state.citaSeleccionada!.copyWith(status: nuevoEstado));
      }
    } on CustomError catch (e) {
      print('🔴 Error al actualizar estado: ${e.message}');
      state = state.copyWith(
          loading: false,
          errorMessage: e.message ?? 'Error al actualizar estado');
    } finally {
      state = state.copyWith(loading: false);
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
  final String successMessage;

  AppointmentState(
      {this.loading = false,
      this.citas = const [],
      this.citasAgendadas = const [],
      this.citasDelDia = const [],
      this.citaSeleccionada,
      DateTime? calendarioCitaSeleccionada,
      this.errorMessage = '',
      this.successMessage = '',
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
    String? successMessage,
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
      successMessage: successMessage ?? this.successMessage,
      paciente: paciente ?? this.paciente,
    );
  }
}
