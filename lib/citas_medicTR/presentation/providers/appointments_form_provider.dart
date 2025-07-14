import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/registerCita.entity.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_provider.dart';
import 'package:h_c_1/patient/domain/entities/patient_entity.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/citas_medicTR/domain/repositories/appointment_repository.dart';
import 'package:h_c_1/citas_medicTR/infrastructure/repositories/appointment_repository_impl.dart';
import 'package:h_c_1/patient/infrastructure/repositories/patient_repository_impl.dart';
import 'package:h_c_1/type_therapy/domain/entities/type_therapy_entity.dart';
import 'package:h_c_1/type_therapy/domain/repositories/type_therapy_repository.dart';
import 'package:h_c_1/type_therapy/infrastructure/repositories/type_therapy_repository_impl.dart';

// 🔹 Provider del formulario de citas
final appointmentFormProvider =
    StateNotifierProvider<AppointmentFormNotifier, AppointmentFormState>(
  (ref) {
    final appointmentRepo = AppointmentRepositoryImpl();
    final patientRepo = PatientRepositoryImpl();
    final typeTherapyRepo = TypeTherapyRepositoryImpl();
    final authState = ref.watch(authProvider);
    final onCallbackAppointment =
        ref.read(appointmentProvider.notifier).crearCita;

    return AppointmentFormNotifier(
        onCallbackAppointment: onCallbackAppointment,
        appointmentRepository: appointmentRepo,
        patientRepository: patientRepo,
        typeTherapyRepository: typeTherapyRepo,
        medicID: authState.user!.medicID);
  },
);

// 🔹 Notifier que maneja el estado del formulario de citas
class AppointmentFormNotifier extends StateNotifier<AppointmentFormState> {
  final AppointmentRepository appointmentRepository;
  final Function(CreateAppointments) onCallbackAppointment;
  final PatientRepository patientRepository;
  final TypeTherapyRepository typeTherapyRepository;
  final String medicID;

  AppointmentFormNotifier(
      {required this.appointmentRepository,
      required this.onCallbackAppointment,
      required this.patientRepository,
      required this.typeTherapyRepository,
      required this.medicID})
      : super(AppointmentFormState()) {
    getTypeTherapics(); // ✅ Cargar áreas terapéuticas al iniciar
  }

  // 🔹 Cambiar paciente manualmente
  void onPatientChanged(String value) {
    state = state.copyWith(patientId: value);
  }

  void onCedulaChanged(String value) {
    state = state.copyWith(cedula: value);
  }

  Future<void> getTypeTherapics() async {
    try {
      print('🔹 Cargando áreas terapéuticas...');
      final areas = await typeTherapyRepository.getTypeTherapies();
      state = state.copyWith(areas: areas);
      print('🔹 Áreas terapéuticas cargadas: ${areas.length}');
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener áreas terapéuticas');
    }
  }

  // 🔹 Buscar paciente por DNI
  Future<void> getPacienteByDni(String dni) async {
    try {
      print('🔹 Buscando paciente por DNI: $dni');
      state = state.copyWith(loading: true);
      final paciente = await patientRepository.getPatientByDni(dni);
      state = state.copyWith(
        loading: false,
        patientId: paciente.id,
        patientEntity: paciente,
      );
      print('🔹 Paciente: ${state.patientEntity?.firstname} ');
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener paciente');
    }
  }

  // 🔹 Cambiar diagnóstico
  void onDiagnosisChanged(String value) {
    state = state.copyWith(diagnosis: value);
  }

  // 🔹 Seleccionar Área
  void onAreaChanged(String value) {
    state = state.copyWith(specialtyTherapyId: value);
  }

  // 🔹 Seleccionar Fecha
  void onDateChanged(DateTime value) {
    state = state.copyWith(selectedDate: value);
  }

  // 🔹 Seleccionar Hora
  void onTimeChanged(String value) {
    state = state.copyWith(selectedTime: value);
  }

  // 🔹 Guardar Cita
  Future<void> saveAppointment() async {
    if (state.specialtyTherapyId == null ||
        state.selectedDate == null ||
        state.selectedTime == null ||
        state.patientId.isEmpty ||
        state.diagnosis.isEmpty) {
      state = state.copyWith(errorMessage: 'Todos los campos son obligatorios');
      return;
    }

    try {
      state = state.copyWith(loading: true);
      // Formatear hora a 12:30 sin segundos ni AM/PM
      final time = (state.selectedTime!.split(':').sublist(0, 2).join(':'))
          .split(' ')[0];
      final newAppointment = CreateAppointments(
        date: state.selectedDate!,
        appointmentTime: time,
        medicalInsurance: state.patientEntity?.healthInsurance ?? 'No seguro',
        diagnosis: state.diagnosis,
        status: 'Agendado',
        patient:
            '${state.patientEntity?.firstname} ${state.patientEntity?.lastname}',
        doctorId: medicID,
        patientId: state.patientId,
        specialtyTherapyId: state.specialtyTherapyId!,
      );

      await onCallbackAppointment(newAppointment);
      state = state.copyWith(loading: false);
      await getTypeTherapics(); // ✅ Recargar áreas terapéuticas después de guardar
    } catch (e) {
      state =
          state.copyWith(loading: false, errorMessage: 'Error al guardar cita');
    }
  }

  Future<void> updateAppointment(
      Appointments cita, BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
      // Crear un objeto CreateAppointments con los datos actualizados
      print(cita.toJson());
      // Llamar al repositorio para actualizar la cita
      await appointmentRepository.updateAppointmentDate(CreateAppointments(
        id: cita.id,
        patientId: cita.patientId,
        date: DateTime.parse(cita.date),
        appointmentTime: cita.appointmentTime,
        medicalInsurance: cita.medicalInsurance,
        doctorId: medicID,
        patient: cita.patient,
        status: cita.status,
        specialtyTherapyId: cita.specialtyTherapyId!,
        diagnosis: cita.diagnosis,
      ));

      // Actualizar el estado
      state = state.copyWith(loading: false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cita Medica actualizada con éxito'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al actualizar cita');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar la cita'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

// 📌 Estado del formulario de citas
class AppointmentFormState {
  final String cedula;
  final String patientId;
  final Patient? patientEntity;
  final String diagnosis;
  final List<TypeTherapyEntity> areas;
  final String? specialtyTherapyId;
  final DateTime? selectedDate;
  final String? selectedTime;
  final bool loading;
  final String errorMessage;

  const AppointmentFormState({
    this.cedula = '',
    this.patientId = '',
    this.patientEntity,
    this.diagnosis = '',
    this.areas = const [],
    this.specialtyTherapyId,
    this.selectedDate,
    this.selectedTime,
    this.loading = false,
    this.errorMessage = '',
  });

  AppointmentFormState copyWith({
    String? cedula,
    String? patientId,
    Patient? patientEntity,
    String? diagnosis,
    List<TypeTherapyEntity>? areas,
    String? specialtyTherapyId,
    DateTime? selectedDate,
    String? selectedTime,
    bool? loading,
    String? errorMessage,
  }) {
    return AppointmentFormState(
      cedula: cedula ?? this.cedula,
      patientId: patientId ?? this.patientId,
      patientEntity: patientEntity ?? this.patientEntity,
      diagnosis: diagnosis ?? this.diagnosis,
      areas: areas ?? this.areas,
      specialtyTherapyId: specialtyTherapyId ?? this.specialtyTherapyId,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
