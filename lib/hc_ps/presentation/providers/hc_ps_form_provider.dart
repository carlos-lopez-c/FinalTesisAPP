import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/domain/entities/hc_ps_adult/create_hc_adult.dart';
import 'package:h_c_1/hc_ps/presentation/providers/hc_provider.dart';
import 'package:h_c_1/hc_ps/presentation/utils/HistoriaClinicaPsicologicaPdfTemplate.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/patient/infrastructure/repositories/patient_repository_impl.dart';
import 'dart:io';

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
  final String status;

  HcFormAdultState({
    this.loading = false,
    this.successMessage = '',
    this.tipo = 'Nuevo',
    this.errorMessage = '',
    this.status = 'Nuevo',
    required this.createHcPsAdult,
    this.cedula = '',
  });

  HcFormAdultState copyWith({
    bool? loading,
    String? errorMessage,
    String? successMessage,
    String? tipo,
    String? status,
    CreateHcPsAdult? createHcPsAdult,
    String? cedula,
  }) {
    return HcFormAdultState(
      loading: loading ?? this.loading,
      successMessage: successMessage ?? this.successMessage,
      tipo: tipo ?? this.tipo,
      status: status ?? this.status,
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
    final hcNotifier = ref.read(hcProvider.notifier);
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
        onCallbackSearchHcPsAdult: onCallbackSearchHcPsAdult,
        onCallbackExistHcPsAdult: (cedula) =>
            hcNotifier.existHcPsAdult(cedula));
  },
);

class HcPsAdultFormNotifier extends StateNotifier<HcFormAdultState> {
  final PatientRepository patientRepository;
  final Function(CreateHcPsAdult) onCallbackHcPsAdult;

  final Function(String) onCallbackSearchHcPsAdult;
  final Function(CreateHcPsAdult) onCallbackHcPsAdultEdit;
  final Function(String) onCallbackExistHcPsAdult;

  HcPsAdultFormNotifier(
      {required this.patientRepository,
      required this.onCallbackSearchHcPsAdult,
      required this.onCallbackHcPsAdultEdit,
      required this.onCallbackHcPsAdult,
      required this.onCallbackExistHcPsAdult})
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
    if (value != state.tipo) {
      print('🔹 Cambiando tipo de historia clínica a: $value');
      state = state.copyWith(
        tipo: value,
        createHcPsAdult: initialPsAdult,
        cedula: '',
        status: value == 'Nuevo' ? 'Nuevo' : 'Editado',
        successMessage: '',
        errorMessage: '',
        loading: false,
      );
    }
  }

  Future<void> onCreateHcPsAdult(BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
      // Asegúrate de que 'fechaEntrevista' esté en el formato correcto

      await onCallbackHcPsAdult(state.createHcPsAdult);
      final datos = state.createHcPsAdult.toJson();
      print('🔹 Datos para PDF: $datos');
      await HistoriaClinicaPsicologicaPdfTemplate.generarPdfPlantillaAdulto(
              datos)
          .then((pdfBytes) async {
        final dir = Directory('/storage/emulated/0/Documents');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
        final filePath =
            '${dir.path}/AreaPsicologia_historiaClinicaAdultos_${state.cedula}.pdf';
        final file = File(filePath);
        await file.writeAsBytes(pdfBytes);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('PDF guardado en: $filePath'),
            duration: const Duration(seconds: 5),
          ));
        }
      });

      // Limpiar campos
      state = state.copyWith(
        createHcPsAdult: initialPsAdult,
        successMessage: 'Historia clínica creada con éxito',
        errorMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString() ?? 'Error al crear historia clínica',
        successMessage: '',
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
      final datos = state.createHcPsAdult.toJson();
      print('🔹 Datos para PDF: $datos');
      await HistoriaClinicaPsicologicaPdfTemplate.generarPdfPlantillaAdulto(
              datos)
          .then((pdfBytes) async {
        final dir = Directory('/storage/emulated/0/Documents');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
        final filePath =
            '${dir.path}/AreaPsicologia_historiaClinicaAdultos_${state.cedula}.pdf';
        final file = File(filePath);
        await file.writeAsBytes(pdfBytes);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('PDF guardado en: $filePath'),
            duration: const Duration(seconds: 5),
          ));
        }
      });

      // Limpiar campos
      state = state.copyWith(
        cedula: '',
        createHcPsAdult: initialPsAdult,
        successMessage: 'Historia clínica actualizada con éxito',
        errorMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString() ?? 'Error al actualizar historia clínica',
        successMessage: '',
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
        status: 'Editado',
        errorMessage: '',
        successMessage: 'Historia clínica encontrada',
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString() ?? 'Error al obtener historia clínica',
        successMessage: '',
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

  void setEdad(String value) {
    state = state.copyWith(
        createHcPsAdult: state.createHcPsAdult.copyWith(edad: value));
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
      print('🔹 Buscando paciente por DI: $dni');
      if (dni.isEmpty) {
        state = state.copyWith(
          errorMessage: 'Error, debe ingresar un número de cédula',
        );
        return;
      }
      if (state.tipo == 'Nuevo') {
        final existHc = await onCallbackExistHcPsAdult(dni);
        if (existHc) {
          print(
              '🔹 Historia clínica de psicología ya existe para este paciente');
          state = state.copyWith(
            errorMessage:
                'Historia clínica de psicología ya existe para este paciente',
          );
          return;
        }
      }
      state = state.copyWith(loading: true);
      final paciente = await patientRepository.getPatientByDni(dni);
      final fechaNacimiento =
          '${paciente.birthdate.year.toString().padLeft(4, '0')}-${paciente.birthdate.month.toString().padLeft(2, '0')}-${paciente.birthdate.day.toString().padLeft(2, '0')}';
      final now = DateTime.now();
      final fechaEvaluacion =
          '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      // Calcular edad
      int age = now.year - paciente.birthdate.year;
      if (now.month < paciente.birthdate.month ||
          (now.month == paciente.birthdate.month &&
              now.day < paciente.birthdate.day)) {
        age--;
      }
      final edad = age.toString();
      state = state.copyWith(
        loading: false,
        cedula: dni,
        createHcPsAdult: state.createHcPsAdult.copyWith(
          patientId: paciente.id,
          nombreCompleto: '${paciente.firstname} ${paciente.lastname}',
          fechaNacimiento: fechaNacimiento,
          fechaEvalucion: fechaEvaluacion,
          edad: edad,
        ),
        successMessage: 'Paciente encontrado correctamente',
        errorMessage: '',
      );
    } catch (e) {
      print('🔴 Error al obtener paciente: $e');
      state = state.copyWith(
        loading: false,
        errorMessage: 'Error al buscar paciente: ${e.toString()}',
        successMessage: '',
      );
    }
  }

  // 🔹 Resetear formulario
  void reset() {
    state = HcFormAdultState(createHcPsAdult: initialPsAdult);
  }

  // 🔹 Limpiar mensajes
  void clearSuccessMessage() {
    state = state.copyWith(successMessage: '');
  }

  void clearErrorMessage() {
    state = state.copyWith(errorMessage: '');
  }
}
