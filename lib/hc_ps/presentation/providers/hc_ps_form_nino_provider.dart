import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/domain/entities/hc_ps_nino/create_hc_nino.dart';
import 'package:h_c_1/hc_ps/presentation/providers/hc_provider.dart';
import 'package:h_c_1/hc_ps/presentation/utils/HistoriaClinicaPsicologicaPdfTemplate.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/patient/infrastructure/repositories/patient_repository_impl.dart';

final initialPsNino = CreateHcPsNino(
  patientId: '',
  nombreCompleto: '',
  fechaNacimiento: '',
  edad: '',
  cursoEscolar: '',
  institucion: '',
  nombrePapa: '',
  nombreMama: '',
  direccion: '',
  telefono: '',
  remision: '',
  fechaEvaluacion: '',
  responsable: '',
  observaciones: '',
  motivoConsulta: '',
  desencadenantesMotivoConsulta: '',
  datosEmbarazoParto: '',
  datosPsicomotor: '',
  desarrolloLenguaje: '',
  desarrolloIntelectual: '',
  desarrolloSocioAfectivo: '',
  antecedentesFamiliares: '',
  estructuraFamiliar: '',
  pruebasAplicadas: '',
  impresionDiagnostica: '',
  areasIntervencion: '',
  cobertura: '',
);

class HcFormNinoState {
  final bool loading;
  final String errorMessage;
  final CreateHcPsNino createHcPsNino;
  final String cedula;
  final String successMessage;
  final String tipo;
  final String status;
  final bool busquedaRealizada;
  final bool historiaExiste;

  HcFormNinoState({
    this.loading = false,
    this.successMessage = '',
    this.tipo = 'Nuevo',
    this.errorMessage = '',
    this.status = 'Nuevo',
    required this.createHcPsNino,
    this.cedula = '',
    this.busquedaRealizada = false,
    this.historiaExiste = false,
  });

  HcFormNinoState copyWith({
    bool? loading,
    String? errorMessage,
    String? successMessage,
    String? tipo,
    String? status,
    CreateHcPsNino? createHcPsNino,
    String? cedula,
    bool? busquedaRealizada,
    bool? historiaExiste,
  }) {
    return HcFormNinoState(
      loading: loading ?? this.loading,
      successMessage: successMessage ?? this.successMessage,
      tipo: tipo ?? this.tipo,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      createHcPsNino: createHcPsNino ?? this.createHcPsNino,
      cedula: cedula ?? this.cedula,
      busquedaRealizada: busquedaRealizada ?? this.busquedaRealizada,
      historiaExiste: historiaExiste ?? this.historiaExiste,
    );
  }
}

final hcPsNinoFormProvider =
    StateNotifierProvider.autoDispose<HcPsNinoFormNotifier, HcFormNinoState>(
  (ref) {
    final hcNotifier = ref.read(hcProvider.notifier);
    final patientRepo = PatientRepositoryImpl();
    final onCallbackHcPsNino = ref.read(hcProvider.notifier).createHcPsNino;
    final onCallbackHcPsNinoEdit = ref.read(hcProvider.notifier).updateHcPsNino;
    final onCallbackSearchHcPsNino = ref.read(hcProvider.notifier).getHcPsNino;
    return HcPsNinoFormNotifier(
        onCallbackHcPsNinoEdit: onCallbackHcPsNinoEdit,
        patientRepository: patientRepo,
        onCallbackHcPsNino: onCallbackHcPsNino,
        onCallbackSearchHcPsNino: onCallbackSearchHcPsNino,
        onCallbackExistHcPsNino: (cedula) => hcNotifier.existHcPsNino(cedula));
  },
);

class HcPsNinoFormNotifier extends StateNotifier<HcFormNinoState> {
  final PatientRepository patientRepository;
  final Function(CreateHcPsNino) onCallbackHcPsNino;
  final Function(String) onCallbackSearchHcPsNino;
  final Function(CreateHcPsNino) onCallbackHcPsNinoEdit;
  final Function(String) onCallbackExistHcPsNino;

  HcPsNinoFormNotifier(
      {required this.patientRepository,
      required this.onCallbackSearchHcPsNino,
      required this.onCallbackHcPsNinoEdit,
      required this.onCallbackHcPsNino,
      required this.onCallbackExistHcPsNino})
      : super(HcFormNinoState(createHcPsNino: initialPsNino));

  void setPatientId(String patientId) {
    state = state.copyWith(
        createHcPsNino: state.createHcPsNino.copyWith(patientId: patientId));
  }

  void onCedulaChanged(String value) async {
    state = state.copyWith(cedula: value);
    // No autocompletar datos aquí, solo actualizar la cédula
  }

  // Este método se llama al presionar el botón Buscar
  Future<void> onBuscarPorCedula() async {
    final value = state.cedula;
    if (value.length < 6) {
      state = state.copyWith(
        errorMessage: 'Ingrese una cédula válida',
        successMessage: '',
      );
      return;
    }
    if (state.tipo == 'Nuevo') {
      try {
        // Verificar si existe paciente
        final patient = await patientRepository.getPatientByDni(value);
        // Verificar si ya existe historia clínica
        final exists = await onCallbackExistHcPsNino(value);
        if (exists) {
          state = state.copyWith(
            createHcPsNino: state.createHcPsNino.copyWith(
              nombreCompleto: '',
              fechaNacimiento: '',
              edad: '',
            ),
            historiaExiste: true,
            errorMessage:
                'Ya existe una historia clínica asociada a esta cédula. Cambie a modo "Buscar/Editar" para verla.',
            successMessage: '',
          );
        } else {
          // Calcular edad
          String calcularEdad(String fechaNacimiento) {
            try {
              final birthDate = DateTime.parse(fechaNacimiento);
              final today = DateTime.now();
              if (birthDate.isAfter(today)) return '';
              int age = today.year - birthDate.year;
              if (today.month < birthDate.month ||
                  (today.month == birthDate.month &&
                      today.day < birthDate.day)) {
                age--;
              }
              return age.toString();
            } catch (_) {
              return '';
            }
          }

          final fechaNacimiento =
              patient.birthdate.toIso8601String().split('T')[0];
          final edadCalculada = calcularEdad(fechaNacimiento);
          final fechaEvaluacion =
              DateTime.now().toIso8601String().split('T')[0];
          state = state.copyWith(
            createHcPsNino: state.createHcPsNino.copyWith(
              nombreCompleto: '${patient.firstname} ${patient.lastname}',
              fechaNacimiento: fechaNacimiento,
              edad: edadCalculada,
              fechaEvaluacion: fechaEvaluacion,
              cobertura: '',
            ),
            historiaExiste: false,
            errorMessage: '',
            successMessage:
                'Paciente encontrado. Puede proceder a crear la historia clínica.',
          );
        }
      } catch (e) {
        state = state.copyWith(
          createHcPsNino: state.createHcPsNino.copyWith(
            nombreCompleto: '',
            fechaNacimiento: '',
          ),
          historiaExiste: false,
          errorMessage: 'No se encontró un paciente con esa cédula',
          successMessage: '',
        );
      }
    } else if (state.tipo == 'Buscar/Editar') {
      // En modo buscar, verificar si existe historia clínica
      try {
        final exists = await onCallbackExistHcPsNino(value);
        if (exists) {
          await onSearchHcPsNino(value);
        } else {
          state = state.copyWith(
            historiaExiste: false,
            errorMessage:
                'No se encontró una historia clínica para esta cédula',
            successMessage: '',
          );
        }
      } catch (e) {
        state = state.copyWith(
          historiaExiste: false,
          errorMessage:
              'Error al verificar la existencia de la historia clínica',
          successMessage: '',
        );
      }
    }
  }

  void onTipoChanged(String value) {
    if (value != state.tipo) {
      state = state.copyWith(
        tipo: value,
        createHcPsNino: initialPsNino,
        cedula: '',
        status: value == 'Nuevo' ? 'Nuevo' : 'Editado',
        successMessage: '',
        errorMessage: '',
        loading: false,
        busquedaRealizada: false,
        historiaExiste: false,
      );
    }
  }

  Future<void> onCreateHcPsNino(BuildContext context) async {
    // Validar que no exista ya una historia clínica
    if (state.historiaExiste) {
      state = state.copyWith(
        errorMessage:
            'Ya existe una historia clínica para esta cédula. Cambie a modo "Buscar" para verla.',
        successMessage: '',
      );
      return;
    }

    // Validar campos requeridos
    if (state.createHcPsNino.nombreCompleto.isEmpty ||
        state.createHcPsNino.fechaNacimiento.isEmpty ||
        state.cedula.isEmpty) {
      state = state.copyWith(
        errorMessage:
            'Por favor complete los campos obligatorios (cédula, nombre completo, fecha de nacimiento)',
        successMessage: '',
      );
      return;
    }

    try {
      state = state.copyWith(loading: true, errorMessage: '');

      // Buscar el paciente para obtener el patientId
      final patient = await patientRepository.getPatientByDni(state.cedula);
      final hcWithPatientId =
          state.createHcPsNino.copyWith(patientId: patient.id);

      await onCallbackHcPsNino(hcWithPatientId);
      final datos = hcWithPatientId.toJson();
      await HistoriaClinicaPsicologicaPdfTemplate.guardarYMostrarPdf(
          datos, context, state.cedula);

      state = state.copyWith(
        createHcPsNino: initialPsNino,
        cedula: '',
        successMessage: 'Historia clínica de niño creada con éxito',
        errorMessage: '',
        historiaExiste: true,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString() ?? 'Error al crear historia clínica',
        successMessage: '',
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> onUpdateHcPsNino(BuildContext context) async {
    try {
      state = state.copyWith(loading: true, errorMessage: '');
      await onCallbackHcPsNinoEdit(state.createHcPsNino);
      final datos = state.createHcPsNino.toJson();
      await HistoriaClinicaPsicologicaPdfTemplate.guardarYMostrarPdf(
          datos, context, state.cedula);
      state = state.copyWith(
        cedula: '',
        createHcPsNino: initialPsNino,
        successMessage: 'Historia clínica de niño actualizada con éxito',
        errorMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString() ?? 'Error al actualizar historia clínica',
        successMessage: '',
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> onSearchHcPsNino(String cedula) async {
    try {
      state = state.copyWith(
          loading: true, busquedaRealizada: false, errorMessage: '');

      // Verificar si existe la historia clínica
      final exists = await onCallbackExistHcPsNino(cedula);
      if (!exists) {
        state = state.copyWith(
          createHcPsNino: initialPsNino,
          errorMessage: 'No se encontró una historia clínica para esta cédula',
          successMessage: '',
          busquedaRealizada: true,
        );
        return;
      }

      // Buscar la historia clínica
      final hcNino = await onCallbackSearchHcPsNino(cedula);
      state = state.copyWith(
        createHcPsNino: hcNino,
        status: 'Editado',
        errorMessage: '',
        successMessage: 'Historia clínica encontrada y cargada',
        busquedaRealizada: true,
        historiaExiste: true,
      );
    } catch (e) {
      state = state.copyWith(
        createHcPsNino: initialPsNino,
        errorMessage: e.toString() ?? 'Error al buscar historia clínica',
        successMessage: '',
        busquedaRealizada: true,
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void clearSuccessMessage() {
    state = state.copyWith(successMessage: '');
  }

  void clearErrorMessage() {
    state = state.copyWith(errorMessage: '');
  }

  // Métodos para actualizar campos individuales
  void onNombreCompletoChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(nombreCompleto: value),
    );
  }

  void onFechaNacimientoChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(fechaNacimiento: value),
    );
  }

  void onEdadChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(edad: value),
    );
  }

  void onCursoEscolarChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(cursoEscolar: value),
    );
  }

  void onInstitucionChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(institucion: value),
    );
  }

  void onNombrePapaChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(nombrePapa: value),
    );
  }

  void onNombreMamaChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(nombreMama: value),
    );
  }

  void onDireccionChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(direccion: value),
    );
  }

  void onTelefonoChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(telefono: value),
    );
  }

  void onRemisionChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(remision: value),
    );
  }

  void onFechaEvaluacionChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(fechaEvaluacion: value),
    );
  }

  void onResponsableChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(responsable: value),
    );
  }

  void onObservacionesChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(observaciones: value),
    );
  }

  void onMotivoConsultaChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(motivoConsulta: value),
    );
  }

  void onDesencadenantesChanged(String value) {
    state = state.copyWith(
      createHcPsNino:
          state.createHcPsNino.copyWith(desencadenantesMotivoConsulta: value),
    );
  }

  void onDatosEmbarazoPartoChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(datosEmbarazoParto: value),
    );
  }

  void onDatosPsicomotorChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(datosPsicomotor: value),
    );
  }

  void onDesarrolloLenguajeChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(desarrolloLenguaje: value),
    );
  }

  void onDesarrolloIntelectualChanged(String value) {
    state = state.copyWith(
      createHcPsNino:
          state.createHcPsNino.copyWith(desarrolloIntelectual: value),
    );
  }

  void onDesarrolloSocioAfectivoChanged(String value) {
    state = state.copyWith(
      createHcPsNino:
          state.createHcPsNino.copyWith(desarrolloSocioAfectivo: value),
    );
  }

  void onAntecedentesFamiliaresChanged(String value) {
    state = state.copyWith(
      createHcPsNino:
          state.createHcPsNino.copyWith(antecedentesFamiliares: value),
    );
  }

  void onEstructuraFamiliarChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(estructuraFamiliar: value),
    );
  }

  void onPruebasAplicadasChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(pruebasAplicadas: value),
    );
  }

  void onImpresionDiagnosticaChanged(String value) {
    state = state.copyWith(
      createHcPsNino:
          state.createHcPsNino.copyWith(impresionDiagnostica: value),
    );
  }

  void onAreasIntervencionChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(areasIntervencion: value),
    );
  }

  void onCoberturaChanged(String value) {
    state = state.copyWith(
      createHcPsNino: state.createHcPsNino.copyWith(cobertura: value),
    );
  }
}
