import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/abuso_verbal.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/antecedentes_morbido.dart';

import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/historia_clinica.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/mal_uso_verbal.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/sintomalogia.dart';

import 'package:h_c_1/hc_tr/domain/entities/hc_voice/antecedentes_terapeuticos.dart';

import 'package:h_c_1/hc_tr/domain/entities/hc_voice/factores_externos.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/habitos_generales.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/uso_laboral_profesional_de_la_voz.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_provider.dart';
import 'package:h_c_1/hc_tr/presentation/providers/state/hc_voice_state.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/patient/infrastructure/repositories/patient_repository_impl.dart';
import 'package:h_c_1/shared/infrastructure/errors/custom_error.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_voice/Template.dart';

final initialVoice = HcVoiceState(
    createHcVoice: CreateHcVoice(
      patientId: '',
      nombreCompleto: '',
      fechaNacimiento: '',
      estadoCivil: '',
      ocupacionActual: '',
      direccion: '',
      derivadoPor: '',
      razonDeDerivacion: '',
      diagnosticoORL: '',
      telefonoDeContacto: '',
      fechaDeEvaluacion: '',
      historiaClinica: HistoriaClinica(
        motivoDeConsulta: '',
        esLaPrimeraVezQueTieneEstaDificultad: '',
        desdeCuandoTieneEstaDificultad: '',
        formaDeInicio: '',
        aQueLoAtribuye: '',
        comoLoAfecta: '',
        cuandoSeAgrava: '',
        comoHaSidoSuEvolucion: '',
        momentoDelDiaConMayorDificultad: '',
        enQueSituacionesAparecenMolestias: '',
      ),
      sintomologia: Sintomologia(
        fonastenia: '',
        fonalgia: '',
      ),
      antecedentesMorbidos: AntecedentesMorbidos(
        problemasDeVozEnSuFamilia: '',
        presentaAlgunaEnfermedad: '',
        lasEmocionesDananSuVoz: '',
        medicamentosQueToma: '',
        accidentesOenfermedadesGravesQueHayaTenido: '',
        haSidoIntervenidoQuirurgicamente: '',
        haSidoEntubado: '',
        haConsultadoConOtrosProfesionales: '',
      ),
      antecedentesTerapeuticos: AntecedentesTerapeuticos(),
      abusoVocal: AbusoVocal(),
      malUsoVocal: MalUsoVocal(),
      factoresExternos: FactoresExternos(),
      habitosGenerales: HabitosGenerales(
        cuantoTiempo: '',
        horasDeSueno: 0,
      ),
      usoLaboralProfesionalDeLaVoz: UsoLaboralProfesionalDeLaVoz(
        horasDeTrabajo: 0,
        posturaParaTrabajar: '',
        utilizaSuVozDeFormaProlongada: '',
        realizaReposoVocalDuranteLaJornadaLaboral: '',
        ingieroLiquidosDuranteLaJornadaLaboral: '',
        utilizaAmplificacionParaCantar: '',
        asisteAClasesConProfesionalesDeLaVoz: '',
      ),
    ),
    loading: false,
    errorMessage: '',
    successMessage: '',
    tipo: 'Nuevo',
    status: 'Nuevo',
    cedula: '');

final hcVoiceFormProvider =
    StateNotifierProvider.autoDispose<HcVoiceFormNotifier, HcVoiceState>(
  (ref) {
    final patientRepo = PatientRepositoryImpl();
    final getHcVoice = ref.watch(hcProvider.notifier).getHcVoice;
    final createHcVoice = ref.watch(hcProvider.notifier).createHcVoice;
    final updateHcVoice = ref.watch(hcProvider.notifier).updateHcVoice;
    final existHcVoice = ref.watch(hcProvider.notifier).existHcVoice;
    return HcVoiceFormNotifier(
        patientRepository: patientRepo,
        getHcVoice: getHcVoice,
        updateHcVoice: updateHcVoice,
        createHcVoice: createHcVoice,
        existHcVoice: existHcVoice);
  },
);

class HcVoiceFormNotifier extends StateNotifier<HcVoiceState> {
  final PatientRepository patientRepository;
  final Function(String) getHcVoice;
  final Function(CreateHcVoice) createHcVoice;
  final Function(CreateHcVoice) updateHcVoice;
  final Function(String) existHcVoice;
  HcVoiceFormNotifier({
    required this.getHcVoice,
    required this.createHcVoice,
    required this.updateHcVoice,
    required this.patientRepository,
    required this.existHcVoice,
  }) : super(initialVoice);

  void onCedulaChanged(String value) {
    state = state.copyWith(
      cedula: value,
    );
  }

  void onTipoChanged(String value) {
    if (value != state.tipo) {
      state = state.copyWith(
        tipo: value,
        status: 'Nuevo',
        cedula: '',
        successMessage: '',
        errorMessage: '',
        createHcVoice: CreateHcVoice(
          patientId: '',
          nombreCompleto: '',
          fechaNacimiento: '',
          estadoCivil: '',
          ocupacionActual: '',
          direccion: '',
          derivadoPor: '',
          razonDeDerivacion: '',
          diagnosticoORL: '',
          telefonoDeContacto: '',
          fechaDeEvaluacion: '',
          historiaClinica: HistoriaClinica(
            motivoDeConsulta: '',
            esLaPrimeraVezQueTieneEstaDificultad: '',
            desdeCuandoTieneEstaDificultad: '',
            formaDeInicio: '',
            aQueLoAtribuye: '',
            comoLoAfecta: '',
            cuandoSeAgrava: '',
            comoHaSidoSuEvolucion: '',
            momentoDelDiaConMayorDificultad: '',
            enQueSituacionesAparecenMolestias: '',
          ),
          sintomologia: Sintomologia(
            fonastenia: '',
            fonalgia: '',
          ),
          antecedentesMorbidos: AntecedentesMorbidos(
            problemasDeVozEnSuFamilia: '',
            presentaAlgunaEnfermedad: '',
            lasEmocionesDananSuVoz: '',
            medicamentosQueToma: '',
            accidentesOenfermedadesGravesQueHayaTenido: '',
            haSidoIntervenidoQuirurgicamente: '',
            haSidoEntubado: '',
            haConsultadoConOtrosProfesionales: '',
          ),
          antecedentesTerapeuticos: AntecedentesTerapeuticos(),
          abusoVocal: AbusoVocal(),
          malUsoVocal: MalUsoVocal(),
          factoresExternos: FactoresExternos(),
          habitosGenerales: HabitosGenerales(cuantoTiempo: '', horasDeSueno: 0),
          usoLaboralProfesionalDeLaVoz: UsoLaboralProfesionalDeLaVoz(
              horasDeTrabajo: 0,
              posturaParaTrabajar: '',
              utilizaSuVozDeFormaProlongada: '',
              realizaReposoVocalDuranteLaJornadaLaboral: '',
              ingieroLiquidosDuranteLaJornadaLaboral: '',
              utilizaAmplificacionParaCantar: '',
              asisteAClasesConProfesionalesDeLaVoz: ''),
        ),
      );
    }
  }

  Future<void> onSearchHcVoice(String cedula) async {
    try {
      print('🟢 Obteniendo historia clínica....');
      state = state.copyWith(loading: true);
      final hcGeneral = await getHcVoice(cedula);
      state = state.copyWith(createHcVoice: hcGeneral, status: 'Editado');
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void clearErrorMessage() {
    state = state.copyWith(errorMessage: '');
  }

  void clearSuccessMessage() {
    state = state.copyWith(successMessage: '');
  }

  Future<void> onCreateHcGeneral(BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
      // Asegúrate de que 'fechaEntrevista' esté en el formato correcto
      // Verifica si la cadena contiene una 'T'; si no, agrégala junto con la hora

      await createHcVoice(state.createHcVoice);

      // Generar PDF después de crear la historia clínica
      await HistoriaClinicaVozPdfTemplate.guardarYMostrarPdf(
          state.createHcVoice.toJson(), context, state.cedula);

      // Limpiar campos
      state = initialVoice;
      state = state.copyWith(
          successMessage: 'Historia clínica creada con éxito',
          errorMessage: '');
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        successMessage: '',
      );
      print('🔴 Error al crear historia clínica: $e');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> onUpdateHcVoice(BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
      await updateHcVoice(state.createHcVoice);

      // Generar PDF después de actualizar la historia clínica
      final datos = state.createHcVoice.toJson();
      print('🔹 Datos: ${datos['antecendentesMorbidos']}');
      print('🔹 Datos: ${datos['abusoVocal']}');
      print('🔹 Datos: ${datos['malUsoVocal']}');
      print('🔹 Datos: ${datos['factoresExternos']}');
      await HistoriaClinicaVozPdfTemplate.guardarYMostrarPdf(
          state.createHcVoice.toJson(), context, state.cedula);

      state = state.copyWith(
          successMessage: 'Historia clínica actualizada con éxito',
          errorMessage: '');
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        successMessage: '',
      );
      print('🔴 Error al actualizar historia clínica: $e');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void getPacienteByDni(String dni) async {
    try {
      if (dni.isEmpty) {
        state = state.copyWith(
          errorMessage: 'Error, debe ingresar un número de cédula',
        );
        return;
      }

      // 🔹 VALIDACIÓN: Verificar si ya existe una historia clínica para este paciente
      final existHc = await existHcVoice(dni);
      if (existHc) {
        state = state.copyWith(
          errorMessage: 'Historia clínica de voz ya existe para este paciente',
        );
        return;
      }

      print('🔹 Buscando paciente por DNI: $dni');
      state = state.copyWith(loading: true);
      final paciente = await patientRepository.getPatientByDni(dni);
      state = state.copyWith(
        loading: false,
        createHcVoice: state.createHcVoice.copyWith(
          nombreCompleto: '${paciente.firstname} ${paciente.lastname}',
          patientId: paciente.id,
          fechaNacimiento:
              '${paciente.birthdate.year}-${paciente.birthdate.month}-${paciente.birthdate.day}',
        ),
      );
    } on CustomError catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.message);
    }
  }

  void setPatientId(String patientId) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(patientId: patientId));
  }

  void setFechaNacimiento(String fechaNacimiento) {
    state = state.copyWith(
        createHcVoice:
            state.createHcVoice.copyWith(fechaNacimiento: fechaNacimiento));
  }

  void setOcupacionActual(String ocupacionActual) {
    state = state.copyWith(
        createHcVoice:
            state.createHcVoice.copyWith(ocupacionActual: ocupacionActual));
  }

  void setNombreCompleto(String nombreCompleto) {
    state = state.copyWith(
        createHcVoice:
            state.createHcVoice.copyWith(nombreCompleto: nombreCompleto));
  }

  void setFechaDeEvaluacion(String fechaDeEvaluacion) {
    state = state.copyWith(
        createHcVoice:
            state.createHcVoice.copyWith(fechaDeEvaluacion: fechaDeEvaluacion));
  }

  void setEstadoCivil(String estadoCivil) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(estadoCivil: estadoCivil));
  }

  void setDireccion(String direccion) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(direccion: direccion));
  }

  void setDerivadoPor(String derivadoPor) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(derivadoPor: derivadoPor));
  }

  void setRazonDeDerivacion(String razonDeDerivacion) {
    state = state.copyWith(
        createHcVoice:
            state.createHcVoice.copyWith(razonDeDerivacion: razonDeDerivacion));
  }

  void setDiagnosticoORL(String diagnosticoORL) {
    state = state.copyWith(
        createHcVoice:
            state.createHcVoice.copyWith(diagnosticoORL: diagnosticoORL));
  }

  void setTelefonoDeContacto(String telefonoDeContacto) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice
            .copyWith(telefonoDeContacto: telefonoDeContacto));
  }

  void setHistoriaClinicaMotivoDeConsulta(String motivoDeConsulta) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        motivoDeConsulta: motivoDeConsulta,
      ),
    ));
  }

  void setHistoriaClinicaEsLaPrimeraVezQueTieneEstaDificultad(
      String esLaPrimeraVezQueTieneEstaDificultad) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        esLaPrimeraVezQueTieneEstaDificultad:
            esLaPrimeraVezQueTieneEstaDificultad,
      ),
    ));
  }

  void setHistoriaClinicaDesdeCuandoTieneEstaDificultad(
      String desdeCuandoTieneEstaDificultad) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        desdeCuandoTieneEstaDificultad: desdeCuandoTieneEstaDificultad,
      ),
    ));
  }

  void setHistoriaClinicaFormaDeInicio(String formaDeInicio) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        formaDeInicio: formaDeInicio,
      ),
    ));
  }

  void setHistoriaClinicaAQueLoAtribuye(String aQueLoAtribuye) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        aQueLoAtribuye: aQueLoAtribuye,
      ),
    ));
  }

  void setHistoriaClinicaComoLoAfecta(String comoLoAfecta) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        comoLoAfecta: comoLoAfecta,
      ),
    ));
  }

  void setHistoriaClinicaCuandoSeAgrava(String cuandoSeAgrava) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        cuandoSeAgrava: cuandoSeAgrava,
      ),
    ));
  }

  void setHistoriaClinicaComoHaSidoSuEvolucion(String comoHaSidoSuEvolucion) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        comoHaSidoSuEvolucion: comoHaSidoSuEvolucion,
      ),
    ));
  }

  void setHistoriaClinicaMomentoDelDiaConMayorDificultad(
      String momentoDelDiaConMayorDificultad) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        momentoDelDiaConMayorDificultad: momentoDelDiaConMayorDificultad,
      ),
    ));
  }

  void setHistoriaClinicaEnQueSituacionesAparecenMolestias(
      String enQueSituacionesAparecenMolestias) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      historiaClinica: state.createHcVoice.historiaClinica.copyWith(
        enQueSituacionesAparecenMolestias: enQueSituacionesAparecenMolestias,
      ),
    ));
  }

  void setSintomologiaFonastenia(String fonastenia) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        fonastenia: fonastenia,
      ),
    ));
  }

  void setSintomologiaFonalgia(String fonalgia) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        fonalgia: fonalgia,
      ),
    ));
  }

  void setSintomologiaTensionEnFonacion(bool tensionEnFonacion) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        tensionEnFonacion: tensionEnFonacion,
      ),
    ));
  }

  void setSintomologiaSensacionDeConstriccionEnElCuello(
      bool sensacionDeConstriccionEnElCuello) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        sensacionDeConstriccionEnElCuello: sensacionDeConstriccionEnElCuello,
      ),
    ));
  }

  void setSintomologiaSensacionDeCuerpoExtrano(bool sensacionDeCuerpoExtrano) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        sensacionDeCuerpoExtrano: sensacionDeCuerpoExtrano,
      ),
    ));
  }

  void setSintomologiaDescargaPosterior(bool descargaPosterior) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        descargaPosterior: descargaPosterior,
      ),
    ));
  }

  void setSintomologiaOdinofagia(bool odinofagia) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        odinofagia: odinofagia,
      ),
    ));
  }

  void setSintomologiaExtensionTonalReducida(bool extensionTonalReducida) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        extensionTonalReducida: extensionTonalReducida,
      ),
    ));
  }

  void setSintomologiaPicorLaringeo(bool picorLaringeo) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      sintomologia: state.createHcVoice.sintomologia.copyWith(
        picorLaringeo: picorLaringeo,
      ),
    ));
  }

  void setAntecedentesMorbidosProblemasDeVozEnSuFamilia(
      String problemasDeVozEnSuFamilia) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        problemasDeVozEnSuFamilia: problemasDeVozEnSuFamilia,
      ),
    ));
  }

  void setAntecedentesMorbidosPresentaAlgunaEnfermedad(
      String presentaAlgunaEnfermedad) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        presentaAlgunaEnfermedad: presentaAlgunaEnfermedad,
      ),
    ));
  }

  void setAntecedentesMorbidosSufreDeEstres(bool sufreDeEstres) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        sufreDeEstres: sufreDeEstres,
      ),
    ));
  }

  void setAntecedentesMorbidosLasEmocionesDananSuVoz(
      String lasEmocionesDananSuVoz) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        lasEmocionesDananSuVoz: lasEmocionesDananSuVoz,
      ),
    ));
  }

  void setAntecedentesMorbidosMedicamentosQueToma(String medicamentosQueToma) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        medicamentosQueToma: medicamentosQueToma,
      ),
    ));
  }

  void setAntecedentesMorbidosAccidentesOenfermedadesGravesQueHayaTenido(
      String accidentesOenfermedadesGravesQueHayaTenido) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        accidentesOenfermedadesGravesQueHayaTenido:
            accidentesOenfermedadesGravesQueHayaTenido,
      ),
    ));
  }

  void setAntecedentesMorbidosHaSidoIntervenidoQuirurgicamente(
      String haSidoIntervenidoQuirurgicamente) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        haSidoIntervenidoQuirurgicamente: haSidoIntervenidoQuirurgicamente,
      ),
    ));
  }

  void setAntecedentesMorbidosHaSidoEntubado(String haSidoEntubado) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        haSidoEntubado: haSidoEntubado,
      ),
    ));
  }

  void setAntecedentesMorbidosHaConsultadoConOtrosProfesionales(
      String haConsultadoConOtrosProfesionales) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesMorbidos: state.createHcVoice.antecedentesMorbidos.copyWith(
        haConsultadoConOtrosProfesionales: haConsultadoConOtrosProfesionales,
      ),
    ));
  }

  void
      setAntecedentesTerapeuticosHaRecibidoTratamientoMedicoPorProblemasDeLaVoz(
          bool haRecibidoTratamientoMedicoPorProblemasDeLaVoz) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesTerapeuticos:
          state.createHcVoice.antecedentesTerapeuticos.copyWith(
        haRecibidoTratamientoMedicoPorProblemasDeLaVoz:
            haRecibidoTratamientoMedicoPorProblemasDeLaVoz,
      ),
    ));
  }

  void setAntecedentesTerapeuticosSeHaRealizadoExamenes(
      bool seHaRealizadoExamenes) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesTerapeuticos:
          state.createHcVoice.antecedentesTerapeuticos.copyWith(
        seHaRealizadoExamenes: seHaRealizadoExamenes,
      ),
    ));
  }

  void
      setAntecedentesTerapeuticosHaRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz(
          bool haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesTerapeuticos:
          state.createHcVoice.antecedentesTerapeuticos.copyWith(
        haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz:
            haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz,
      ),
    ));
  }

  void setAntecedentesTerapeuticosHaRecibidoTecnicaVocal(
      bool haRecibidoTecnicaVocal) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesTerapeuticos:
          state.createHcVoice.antecedentesTerapeuticos.copyWith(
        haRecibidoTecnicaVocal: haRecibidoTecnicaVocal,
      ),
    ));
  }

  void setAntecedentesTerapeuticosAplicaLaTecnicaVocal(
      bool aplicaLaTecnicaVocal) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      antecedentesTerapeuticos:
          state.createHcVoice.antecedentesTerapeuticos.copyWith(
        aplicaLaTecnicaVocal: aplicaLaTecnicaVocal,
      ),
    ));
  }

  void setAbusoVocalToseEnExceso(bool toseEnExceso) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        toseEnExceso: toseEnExceso,
      ),
    ));
  }

  void setAbusoVocalGritaEnExceso(bool gritaEnExceso) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        gritaEnExceso: gritaEnExceso,
      ),
    ));
  }

  void setAbusoVocalHablaMucho(bool hablaMucho) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        hablaMucho: hablaMucho,
      ),
    ));
  }

  void setAbusoVocalHablaRapido(bool hablaRapido) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        hablaRapido: hablaRapido,
      ),
    ));
  }

  void setAbusoVocalImitaVoces(bool imitaVoces) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        imitaVoces: imitaVoces,
      ),
    ));
  }

  void setAbusoVocalHablaConExcesoDeRuido(bool hablaConExcesoDeRuido) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        hablaConExcesoDeRuido: hablaConExcesoDeRuido,
      ),
    ));
  }

  void setAbusoVocalReduceElUsoDeLaVozEnResfrios(
      bool reduceElUsoDeLaVozEnResfrios) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        reduceElUsoDeLaVozEnResfrios: reduceElUsoDeLaVozEnResfrios,
      ),
    ));
  }

  void setAbusoVocalCarraspeaEnExceso(bool carraspeaEnExceso) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        carraspeaEnExceso: carraspeaEnExceso,
      ),
    ));
  }

  void setAbusoVocalHablaForzandoLaVoz(bool hablaForzandoLaVoz) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        hablaForzandoLaVoz: hablaForzandoLaVoz,
      ),
    ));
  }

  void setAbusoVocalHablaAlMismoTiempoQueOtrasPersonas(
      bool hablaAlMismoTiempoQueOtrasPersonas) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        hablaAlMismoTiempoQueOtrasPersonas: hablaAlMismoTiempoQueOtrasPersonas,
      ),
    ));
  }

  void setAbusoVocalHablaConDientesHombroYCuelloApretados(
      bool hablaConDientesHombroYCuelloApretados) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      abusoVocal: state.createHcVoice.abusoVocal.copyWith(
        hablaConDientesHombroYCuelloApretados:
            hablaConDientesHombroYCuelloApretados,
      ),
    ));
  }

  void setMalUsoVocalTrataDeHablarConUnTonoMasAgudoOGraveQueElSuyo(
      bool trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      malUsoVocal: state.createHcVoice.malUsoVocal.copyWith(
        trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo:
            trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo,
      ),
    ));
  }

  void setMalUsoVocalTrataDeHablarConUnVolumenMasDebilOAltoDeLoUsual(
      bool trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      malUsoVocal: state.createHcVoice.malUsoVocal.copyWith(
        trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual:
            trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual,
      ),
    ));
  }

  void setMalUsoVocalCantaFueraDeSuRegistro(bool cantaFueraDeSuRegistro) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      malUsoVocal: state.createHcVoice.malUsoVocal.copyWith(
        cantaFueraDeSuRegistro: cantaFueraDeSuRegistro,
      ),
    ));
  }

  void setMalUsoVocalCantaSinVocalizar(bool cantaSinVocalizar) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      malUsoVocal: state.createHcVoice.malUsoVocal.copyWith(
        cantaSinVocalizar: cantaSinVocalizar,
      ),
    ));
  }

  void setFactoresExternosViveEnAmbienteDeFumadores(
      bool viveEnAmbienteDeFumadores) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      factoresExternos: state.createHcVoice.factoresExternos.copyWith(
        viveEnAmbienteDeFumadores: viveEnAmbienteDeFumadores,
      ),
    ));
  }

  void setFactoresExternosTrabajaEnAmbienteRuidoso(
      bool trabajaEnAmbienteRuidoso) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      factoresExternos: state.createHcVoice.factoresExternos.copyWith(
        trabajaEnAmbienteRuidoso: trabajaEnAmbienteRuidoso,
      ),
    ));
  }

  void setFactoresExternosPermaneceEnAmbientesConAireAcondicionado(
      bool permaneceEnAmbientesConAireAcondicionado) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      factoresExternos: state.createHcVoice.factoresExternos.copyWith(
        permaneceEnAmbientesConAireAcondicionado:
            permaneceEnAmbientesConAireAcondicionado,
      ),
    ));
  }

  void setFactoresExternosPermaneceEnAmbientesConPocaVentilacion(
      bool permaneceEnAmbientesConPocaVentilacion) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      factoresExternos: state.createHcVoice.factoresExternos.copyWith(
        permaneceEnAmbientesConPocaVentilacion:
            permaneceEnAmbientesConPocaVentilacion,
      ),
    ));
  }

  void setFactoresExternosSeExponeACambiosBruscosDeTemperatura(
      bool seExponeACambiosBruscosDeTemperatura) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      factoresExternos: state.createHcVoice.factoresExternos.copyWith(
        seExponeACambiosBruscosDeTemperatura:
            seExponeACambiosBruscosDeTemperatura,
      ),
    ));
  }

  void setHabitosGeneralesRealizaReposoVocal(bool realizaReposoVocal) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        realizaReposoVocal: realizaReposoVocal,
      ),
    ));
  }

  void setHabitosGeneralesCuantoTiempo(String cuantoTiempo) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        cuantoTiempo: cuantoTiempo,
      ),
    ));
  }

  void setHabitosGeneralesHablaMuchoTiempoSinBebeLiquido(
      bool hablaMuchoTiempoSinBebeLiquido) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        hablaMuchoTiempoSinBebeLiquido: hablaMuchoTiempoSinBebeLiquido,
      ),
    ));
  }

  void setHabitosGeneralesAsisteAlOtorrinolaringologo(
      bool asisteAlOtorrinolaringologo) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        asisteAlOtorrinolaringologo: asisteAlOtorrinolaringologo,
      ),
    ));
  }

  void setHabitosGeneralesConsumeAlimentosMuyCondimentados(
      bool consumeAlimentosMuyCondimentados) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        consumeAlimentosMuyCondimentados: consumeAlimentosMuyCondimentados,
      ),
    ));
  }

  void setHabitosGeneralesConsumeAlimentosMuyCalientesOMuyFrios(
      bool consumeAlimentosMuyCalientesOMuyFrios) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        consumeAlimentosMuyCalientesOMuyFrios:
            consumeAlimentosMuyCalientesOMuyFrios,
      ),
    ));
  }

  void setHabitosGeneralesConsumeAlcohol(bool consumeAlcohol) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        consumeAlcohol: consumeAlcohol,
      ),
    ));
  }

  void setHabitosGeneralesConsumeTabaco(bool consumeTabaco) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        consumeTabaco: consumeTabaco,
      ),
    ));
  }

  void setHabitosGeneralesConsumeCafe(bool consumeCafe) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        consumeCafe: consumeCafe,
      ),
    ));
  }

  void setHabitosGeneralesConsumeDrogas(bool consumeDrogas) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        consumeDrogas: consumeDrogas,
      ),
    ));
  }

  void setHabitosGeneralesUtilizaRopaAjustada(bool utilizaRopaAjustada) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        utilizaRopaAjustada: utilizaRopaAjustada,
      ),
    ));
  }

  void setHabitosGeneralesHorasDeSueno(int horasDeSueno) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      habitosGenerales: state.createHcVoice.habitosGenerales.copyWith(
        horasDeSueno: horasDeSueno,
      ),
    ));
  }

  void setUsoLaboralProfesionalDeLaVozHorasDeTrabajo(int horasDeTrabajo) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      usoLaboralProfesionalDeLaVoz:
          state.createHcVoice.usoLaboralProfesionalDeLaVoz.copyWith(
        horasDeTrabajo: horasDeTrabajo,
      ),
    ));
  }

  void setUsoLaboralProfesionalDeLaVozPosturaParaTrabajar(
      String posturaParaTrabajar) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      usoLaboralProfesionalDeLaVoz:
          state.createHcVoice.usoLaboralProfesionalDeLaVoz.copyWith(
        posturaParaTrabajar: posturaParaTrabajar,
      ),
    ));
  }

  void setUsoLaboralProfesionalDeLaVozUtilizaSuVozDeFormaProlongada(
      String utilizaSuVozDeFormaProlongada) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      usoLaboralProfesionalDeLaVoz:
          state.createHcVoice.usoLaboralProfesionalDeLaVoz.copyWith(
        utilizaSuVozDeFormaProlongada: utilizaSuVozDeFormaProlongada,
      ),
    ));
  }

  void setUsoLaboralProfesionalDeLaVozRealizaReposoVocalDuranteLaJornadaLaboral(
      String realizaReposoVocalDuranteLaJornadaLaboral) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      usoLaboralProfesionalDeLaVoz:
          state.createHcVoice.usoLaboralProfesionalDeLaVoz.copyWith(
        realizaReposoVocalDuranteLaJornadaLaboral:
            realizaReposoVocalDuranteLaJornadaLaboral,
      ),
    ));
  }

  void setUsoLaboralProfesionalDeLaVozIngieroLiquidosDuranteLaJornadaLaboral(
      String ingieroLiquidosDuranteLaJornadaLaboral) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      usoLaboralProfesionalDeLaVoz:
          state.createHcVoice.usoLaboralProfesionalDeLaVoz.copyWith(
        ingieroLiquidosDuranteLaJornadaLaboral:
            ingieroLiquidosDuranteLaJornadaLaboral,
      ),
    ));
  }

  void setUsoLaboralProfesionalDeLaVozUtilizaAmplificacionParaCantar(
      String utilizaAmplificacionParaCantar) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      usoLaboralProfesionalDeLaVoz:
          state.createHcVoice.usoLaboralProfesionalDeLaVoz.copyWith(
        utilizaAmplificacionParaCantar: utilizaAmplificacionParaCantar,
      ),
    ));
  }

  void setUsoLaboralProfesionalDeLaVozAsisteAClasesConProfesionalesDeLaVoz(
      String asisteAClasesConProfesionalesDeLaVoz) {
    state = state.copyWith(
        createHcVoice: state.createHcVoice.copyWith(
      usoLaboralProfesionalDeLaVoz:
          state.createHcVoice.usoLaboralProfesionalDeLaVoz.copyWith(
        asisteAClasesConProfesionalesDeLaVoz:
            asisteAClasesConProfesionalesDeLaVoz,
      ),
    ));
  }

  void reset() {
    state = initialVoice;
  }
}
