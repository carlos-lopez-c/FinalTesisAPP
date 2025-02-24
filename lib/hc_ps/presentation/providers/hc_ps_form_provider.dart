import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/domain/entities/hc_ps_adult/create_hc_adult.dart';
import 'package:h_c_1/hc_ps/presentation/providers/hc_provider.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/patient/infrastructure/repositories/patient_repository_impl.dart';

// 📌 Estado inicial del formulario
final initialPsAdult = CreateHcPsAdult(
  patientId: '',
  antecedenteFamiliares: '',
  areasIntervecion: '',
  cobertura: '',
  curso: '',
  desencadenantesMotivoConsulta: '',
  direccion: '',
  estructuraFamiliar: '',
  fechaCreacion: '',
  fechaEvalucion: '',
  fechaNacimiento: '',
  impresionDiagnostica: '',
  institucion: '',
  motivoConsulta: '',
  nombreCompleto: '',
  observaciones: '',
  pruebasAplicadas: '',
  remision: '',
  responsable: '',
  telefono: '',
);

class HcFormAdultState {
  final bool loading;
  final String errorMessage;
  final CreateHcPsAdult createHcPsAdult;
  final String cedula;
  final String successMessage;
  final String tipo;

  HcFormAdultState({
    this.loading = false,
    this.successMessage = '',
    this.tipo = '',
    this.errorMessage = '',
    required this.createHcPsAdult,
    this.cedula = '',
  });

  HcFormAdultState copyWith({
    bool? loading,
    String? errorMessage,
    String? successMessage,
    String? tipo,
    CreateHcPsAdult? createHcPsAdult,
    String? cedula,
  }) {
    return HcFormAdultState(
      loading: loading ?? this.loading,
      successMessage: successMessage ?? this.successMessage,
      tipo: tipo ?? this.tipo,
      errorMessage: errorMessage ?? this.errorMessage,
      createHcPsAdult: createHcPsAdult ?? this.createHcPsAdult,
      cedula: cedula ?? this.cedula,
    );
  }
}

// 📌 Provider para la historia clínica psicológica
final hcPsAdultFormProvider =
    StateNotifierProvider.autoDispose<HcPsAdultFormNotifier, HcFormAdultState>(
  (ref) {
    final patientRepo = PatientRepositoryImpl();
    final onCallbackHcPsAdult = ref.read(hcProvider.notifier).createHcPsAdult;
    final onCallbackHcPsAdultEdit =
        ref.read(hcProvider.notifier).updateHcPsAdult;
    final onCallbackSearchHcPsAdult =
        ref.read(hcProvider.notifier).getHcPsAdult;
    return HcPsAdultFormNotifier(
        onCallbackHcPsAdultEdit: onCallbackHcPsAdultEdit,
        patientRepository: patientRepo,
        onCallbackHcPsAdult: onCallbackHcPsAdult,
        onCallbackSearchHcPsAdult: onCallbackSearchHcPsAdult);
  },
);

class HcPsAdultFormNotifier extends StateNotifier<HcFormAdultState> {
  final PatientRepository patientRepository;
  final Function(CreateHcPsAdult) onCallbackHcPsAdult;

  final Function(String) onCallbackSearchHcPsAdult;
  final Function(CreateHcPsAdult) onCallbackHcPsAdultEdit;

  HcPsAdultFormNotifier(
      {required this.patientRepository,
      required this.onCallbackSearchHcPsAdult,
      required this.onCallbackHcPsAdultEdit,
      required this.onCallbackHcPsAdult})
      : super(HcFormAdultState(createHcPsAdult: initialPsAdult));

  // 🔹 Métodos para actualizar los campos
  void setPatientId(String patientId) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(patientId: patientId));
  }

  void onCedulaChanged(String value) {
    state = state.copyWith(cedula: value);
  }

  void onTipoChanged(String value) {
    state = state.copyWith(tipo: value);
  }

  Future<void> onCreateHcPsAdult(BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
      // Asegúrate de que 'fechaEntrevista' esté en el formato correcto

      await onCallbackHcPsAdult(state.createHcPsAdult);

      // Limpiar campos
      ;
      state = state.copyWith(
        createHcPsAdult: initialPsAdult,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Historia clínica creada con éxito'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      state = state.copyWith();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear historia clínica'),
          backgroundColor: Colors.red,
        ),
      );
      print('🔴 Error al crear historia clínica: $e');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> onUpdateHcPsAdult(BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
      // Asegúrate de que 'fechaEntrevista' esté en el formato correcto
      await onCallbackHcPsAdultEdit(state.createHcPsAdult);

      // Limpiar campos

      state = state.copyWith(
        cedula: '',
        createHcPsAdult: initialPsAdult,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Historia clínica actualizada con éxito'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString() ?? 'Error al actualizar historia clínica',
        successMessage: '',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar historia clínica'),
          backgroundColor: Colors.red,
        ),
      );
      print('🔴 Error al actualizar historia clínica: $e');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> onSearchHcPsAdult(String cedula) async {
    try {
      state = state.copyWith(loading: true);
      final hcGeneral = await onCallbackSearchHcPsAdult(cedula);
      print("Aqui tambien llega ${hcGeneral?.toJson()}");
      state = state.copyWith(
        createHcPsAdult: hcGeneral,
        errorMessage: '',
        successMessage: 'Historia clínica encontrada',
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString() ?? 'Error al obtener historia clínica',
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void setAntecedenteFamiliares(String value) {
    state = state.copyWith(
        createHcPsAdult:
            state.createHcPsAdult.copyWith(antecedenteFamiliares: value));
  }

  void setAreasIntervencion(String value) {
    state = state.copyWith(
        createHcPsAdult:
            state.createHcPsAdult.copyWith(areasIntervecion: value));
  }

  void setCobertura(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(cobertura: value));
  }

  void setCurso(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(curso: value));
  }

  void setDesencadenantesMotivoConsulta(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult
            .copyWith(desencadenantesMotivoConsulta: value));
  }

  void setDireccion(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(direccion: value));
  }

  void setEstructuraFamiliar(String value) {
    state = state.copyWith(
        createHcPsAdult:
            state.createHcPsAdult.copyWith(estructuraFamiliar: value));
  }

  void setFechaEvaluacion(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(fechaEvalucion: value));
  }

  void setFechaNacimiento(String value) {
    state = state.copyWith(
        createHcPsAdult:
            state.createHcPsAdult.copyWith(fechaNacimiento: value));
  }

  void setImpresionDiagnostica(String value) {
    state = state.copyWith(
        createHcPsAdult:
            state.createHcPsAdult.copyWith(impresionDiagnostica: value));
  }

  void setInstitucion(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(institucion: value));
  }

  void setMotivoConsulta(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(motivoConsulta: value));
  }

  void setNombreCompleto(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(nombreCompleto: value));
  }

  void setObservaciones(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(observaciones: value));
  }

  void setPruebasAplicadas(String value) {
    state = state.copyWith(
        createHcPsAdult:
            state.createHcPsAdult.copyWith(pruebasAplicadas: value));
  }

  void setRemision(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(remision: value));
  }

  void setResponsable(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(responsable: value));
  }

  void setTelefono(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(telefono: value));
  }

  // 🔹 Método para buscar paciente por DNI y actualizar los datos
  void getPacienteByDni(String dni) async {
    try {
      print('🔹 Buscando paciente por DNI: $dni');
      final paciente = await patientRepository.getPatientByDni(dni);
      state = state.copyWith(
        cedula: dni,
        createHcPsAdult: state.createHcPsAdult.copyWith(
          patientId: paciente.id,
          nombreCompleto: '${paciente.firstname} ${paciente.lastname}',
          fechaNacimiento:
              '${paciente.birthdate.year}-${paciente.birthdate.month}-${paciente.birthdate.day}',
        ),
      );
    } catch (e) {
      print('🔴 Error al obtener paciente: $e');
    }
  }

  // 🔹 Resetear formulario
  void reset() {
    state = HcFormAdultState(createHcPsAdult: initialPsAdult);
  }
}
