import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/infrastructure/errors/auth_errors.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/eficiencia.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/independencia_autonomia.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/proceso_alimentacion.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/salud_bocal.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/seguridad.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_provider.dart';
import 'package:h_c_1/hc_tr/presentation/providers/state/hc_adult_state.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/patient/infrastructure/repositories/patient_repository_impl.dart';

final initialAdult = HcAdultState(
    errorMessage: '',
    successMessage: '',
    createHcAdult: CreateHcAdultEntity(
      patientId: '',
      nombreCompleto: '',
      fechaEvalucion: '',
      lateralidad: '',
      independenciaAutonomia: IndependenciaAutonomia(
          quePrepara: '',
          queTipoDeAyudaNecesita: '',
          seAlimentaSoloOConAyuda: ''),
      eficiencia: Eficiencia(
          cuantoLiquidoConsumeAlDia: '',
          cuantoPesoHaPerdido: 0,
          quePorcionConsume: '',
          queTipoDeAlimento: '',
          queTipoDeLiquidoConsumeHabitualmente: ''),
      seguridad: Seguridad(
        conQueAlimentosLiquidosMedicamentos: '',
        conQueFrecuencia: '',
        conQueFrecuenciaPresentoNeumonia: '',
      ),
      procesoDeAlimentacion:
          ProcesoDeAlimentacion(cuantoTiempo: '', queOtraActividad: ''),
      saludBocal: SaludBocal(
        conQueFrecuenciaAsisteAControlesDentales: '',
        conQueFrecuenciaSeLavaLosDientes: '',
        porQueNoCuentaConTodasSusPiezasDentales: '',
        queMolestiaODolor: '',
      ),
    ),
    loading: false,
    cedula: '',
    tipo: 'Nuevo');

final hcAdultFormProvider =
    StateNotifierProvider.autoDispose<HcAdultFormNotifier, HcAdultState>(
  (ref) {
    final patientRepo = PatientRepositoryImpl();
    final createAdultHc = ref.read(hcProvider.notifier).createHcAdult;
    final getHcAdult = ref.read(hcProvider.notifier).getHcAdult;
    return HcAdultFormNotifier(
        patientRepository: patientRepo,
        createAdultHc: createAdultHc,
        getHcAdult: getHcAdult);
  },
);

class HcAdultFormNotifier extends StateNotifier<HcAdultState> {
  final PatientRepository patientRepository;
  final Function(CreateHcAdultEntity) createAdultHc;
  final Function(String) getHcAdult;
  HcAdultFormNotifier({
    required this.getHcAdult,
    required this.createAdultHc,
    required this.patientRepository,
  }) : super(initialAdult);

  void onCedulaChanged(String value) {
    state = state.copyWith(
      cedula: value,
    );
  }

  void getPacienteByDni(String dni) async {
    try {
      print('🔹 Buscando paciente por DNI: $dni');
      state = state.copyWith(loading: true);
      final paciente = await patientRepository.getPatientByDni(dni);
      state = state.copyWith(
        loading: false,
        createHcAdult: state.createHcAdult.copyWith(
          nombreCompleto: '${paciente.firstname} ${paciente.lastname}',
          patientId: paciente.id,
        ),
      );

      // Actualizar controladores con los nuevos valores
      state = state.copyWith();
    } on CustomError catch (e) {
      state = state.copyWith(
          loading: false,
          errorMessage: e.message ?? 'Error al obtener paciente');
    }
  }

  void onTipoChanged(String value) {
    state = state.copyWith(
      tipo: value,
    );
  }

  Future<void> onSearchHcAdult(String cedula) async {
    try {
      print('🟢 Obteniendo historia clínica....');
      state = state.copyWith(loading: true);
      final hcGeneral = await getHcAdult(cedula);
      print("Aqui tambien llega ${hcGeneral?.toJson()}");
      state = state.copyWith(
        createHcAdult: hcGeneral,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message ?? 'Error al obtener historia clínica',
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> onCreateHcGeneral() async {
    try {
      state = state.copyWith(loading: true);
      // Asegúrate de que 'fechaEntrevista' esté en el formato correcto
      final fechaEvalucion = state.createHcAdult.fechaEvalucion;
      // Verifica si la cadena contiene una 'T'; si no, agrégala junto con la hora
      final fechaFormatoCorrecto = fechaEvalucion!.contains('T')
          ? fechaEvalucion
          : '${fechaEvalucion}T00:00:00Z';
      // Analiza la cadena de fecha y obtén el objeto DateTime
      final fechaParsed = DateTime.parse(fechaFormatoCorrecto);
      // Actualiza el estado con la fecha en formato ISO 8601
      state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
          fechaEvalucion: fechaParsed.toIso8601String(),
        ),
      );
      print(state.createHcAdult.fechaEvalucion);
      print('🔹 Creando historia clínica general...');
      print(state.createHcAdult.toJson());
      print("Se creó la historia clínica general");
      await createAdultHc(state.createHcAdult);

      // Limpiar campos
      state = initialAdult;
      state = state.copyWith(
          successMessage: 'Historia clínica creada con éxito',
          errorMessage: '');
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message ?? 'Error al crear historia clínica',
        successMessage: '',
      );
      print('🔴 Error al crear historia clínica: $e');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void setPatientId(String patientId) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(patientId: patientId));
  }

  void setNombreCompleto(String nombreCompleto) {
    state = state.copyWith(
        createHcAdult:
            state.createHcAdult.copyWith(nombreCompleto: nombreCompleto));
  }

  void setFechaEvaluacion(String fechaEvaluacion) {
    state = state.copyWith(
        createHcAdult:
            state.createHcAdult.copyWith(fechaEvalucion: fechaEvaluacion));
  }

  void setLateralidad(String lateralidad) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(lateralidad: lateralidad));
  }

  void setIndepDecideQueComer(bool decideQueComer) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            independenciaAutonomia: state.createHcAdult.independenciaAutonomia
                .copyWith(decideQueComer: decideQueComer)));
  }

  void setIndepPreparaSusAlimentos(bool preparaSusAlimentos) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            independenciaAutonomia: state.createHcAdult.independenciaAutonomia
                .copyWith(preparaSusAlimentos: preparaSusAlimentos)));
  }

  void setIndepQuePrepara(String quePrepara) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            independenciaAutonomia: state.createHcAdult.independenciaAutonomia
                .copyWith(quePrepara: quePrepara)));
  }

  void setIndepQueTipoDeAyudaNecesita(String queTipoDeAyudaNecesita) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            independenciaAutonomia: state.createHcAdult.independenciaAutonomia
                .copyWith(queTipoDeAyudaNecesita: queTipoDeAyudaNecesita)));
  }

  void setIndepSeAlimentaSoloOConAyuda(String seAlimentaSoloOConAyuda) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            independenciaAutonomia: state.createHcAdult.independenciaAutonomia
                .copyWith(seAlimentaSoloOConAyuda: seAlimentaSoloOConAyuda)));
  }

  void setEficienciaConsumeLaTotalidadDeLosAlimentos(
      bool consumeLaTotalidadDeLosAlimentos) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia.copyWith(
                consumeLaTotalidadDeLosAlimentos:
                    consumeLaTotalidadDeLosAlimentos)));
  }

  void setEficienciaCuantoLiquidoConsumeAlDia(
      String cuantoLiquidoConsumeAlDia) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia.copyWith(
                cuantoLiquidoConsumeAlDia: cuantoLiquidoConsumeAlDia)));
  }

  void setEficienciaCuantoPesoHaPerdido(double cuantoPesoHaPerdido) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia
                .copyWith(cuantoPesoHaPerdido: cuantoPesoHaPerdido)));
  }

  void setEficienciaHaPresentadoPerdidasImportantesDePesoEnElUltimoTiempo(
      bool haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia.copyWith(
                haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo:
                    haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo)));
  }

  void setEficienciaManifiestaInteresPorAlimentarse(
      bool manifiestaInteresPorAlimentarse) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia.copyWith(
                manifiestaInteresPorAlimentarse:
                    manifiestaInteresPorAlimentarse)));
  }

  void setEficienciaManifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento(
      bool manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia.copyWith(
                manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento:
                    manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento)));
  }

  void setEficienciaQuePorcionConsume(String quePorcionConsume) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia
                .copyWith(quePorcionConsume: quePorcionConsume)));
  }

  void setEficienciaQueTipoDeAlimento(String queTipoDeAlimento) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia
                .copyWith(queTipoDeAlimento: queTipoDeAlimento)));
  }

  void setEficienciaQueTipoDeLiquidoConsumeHabitualmente(
      String queTipoDeLiquidoConsumeHabitualmente) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            eficiencia: state.createHcAdult.eficiencia.copyWith(
                queTipoDeLiquidoConsumeHabitualmente:
                    queTipoDeLiquidoConsumeHabitualmente)));
  }

  void setSeguridadConQueAlimentosLiquidosMedicamentos(
      String conQueAlimentosLiquidosMedicamentos) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad.copyWith(
                conQueAlimentosLiquidosMedicamentos:
                    conQueAlimentosLiquidosMedicamentos)));
  }

  void setSeguridadConQueFrecuencia(String conQueFrecuencia) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad
                .copyWith(conQueFrecuencia: conQueFrecuencia)));
  }

  void setSeguridadConQueFrecuenciaPresentoNeumonia(
      String conQueFrecuenciaPresentoNeumonia) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad.copyWith(
                conQueFrecuenciaPresentoNeumonia:
                    conQueFrecuenciaPresentoNeumonia)));
  }

  void setSeguridadHaPresentadoNeumonias(bool haPresentadoNeumonias) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad
                .copyWith(haPresentadoNeumonias: haPresentadoNeumonias)));
  }

  void setSeguridadPresentaAlgunaDificultadParaTomarLiquidosDeUnVaso(
      bool presentaAlgunaDificultadParaTomarLiquidosDeUnVaso) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad.copyWith(
                presentaAlgunaDificultadParaTomarLiquidosDeUnVaso:
                    presentaAlgunaDificultadParaTomarLiquidosDeUnVaso)));
  }

  void setSeguridadPresentaDificultadConSopasOLosGranosPequenosComoArroz(
      bool presentaDificultadConSopasOLosGranosPequenosComoArroz) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad.copyWith(
                presentaDificultadConSopasOLosGranosPequenosComoArroz:
                    presentaDificultadConSopasOLosGranosPequenosComoArroz)));
  }

  void setSeguridadSeAtoraConSuSaliva(bool seAtoraConSuSaliva) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad
                .copyWith(seAtoraConSuSaliva: seAtoraConSuSaliva)));
  }

  void setSeguridadSeQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse(
      bool seQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad.copyWith(
                seQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse:
                    seQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse)));
  }

  void setSeguridadSienteQueElAlimentoSeVaHaciaSuNariz(
      bool sienteQueElAlimentoSeVaHaciaSuNariz) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad.copyWith(
                sienteQueElAlimentoSeVaHaciaSuNariz:
                    sienteQueElAlimentoSeVaHaciaSuNariz)));
  }

  void setSeguridadTieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos(
      bool tieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            seguridad: state.createHcAdult.seguridad.copyWith(
                tieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos:
                    tieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos)));
  }

  void setProcesoDeAlimentacionCreeUstedQueComeMuyRapido(
      bool creeUstedQueComeMuyRapido) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            procesoDeAlimentacion: state.createHcAdult.procesoDeAlimentacion
                .copyWith(
                    creeUstedQueComeMuyRapido: creeUstedQueComeMuyRapido)));
  }

  void setProcesoDeAlimentacionSeDemoraMasTiempoQueElRestoDeLaFamiliaEnComer(
      bool seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            procesoDeAlimentacion: state.createHcAdult.procesoDeAlimentacion
                .copyWith(
                    seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer:
                        seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer)));
  }

  void setProcesoDeAlimentacionSueleRealizarAlgunaOtraActividadMientrasCome(
      bool sueleRealizarAlgunaOtraActividadMientrasCome) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            procesoDeAlimentacion: state.createHcAdult.procesoDeAlimentacion
                .copyWith(
                    sueleRealizarAlgunaOtraActividadMientrasCome:
                        sueleRealizarAlgunaOtraActividadMientrasCome)));
  }

  void setProcesoDeAlimentacionCuantoTiempo(String cuantoTiempo) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            procesoDeAlimentacion: state.createHcAdult.procesoDeAlimentacion
                .copyWith(cuantoTiempo: cuantoTiempo)));
  }

  void setProcesoDeAlimentacionQueOtraActividad(String queOtraActividad) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            procesoDeAlimentacion: state.createHcAdult.procesoDeAlimentacion
                .copyWith(queOtraActividad: queOtraActividad)));
  }

  void setSaludBocalAsisteRegularmenteAControlesDentales(
      bool asisteRegularmenteAControlesDentales) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal.copyWith(
                asisteRegularmenteAControlesDentales:
                    asisteRegularmenteAControlesDentales)));
  }

  void setSaludBocalConQueFrecuenciaAsisteAControlesDentales(
      String conQueFrecuenciaAsisteAControlesDentales) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal.copyWith(
                conQueFrecuenciaAsisteAControlesDentales:
                    conQueFrecuenciaAsisteAControlesDentales)));
  }

  void setSaludBocalConQueFrecuenciaSeLavaLosDientes(
      String conQueFrecuenciaSeLavaLosDientes) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal.copyWith(
                conQueFrecuenciaSeLavaLosDientes:
                    conQueFrecuenciaSeLavaLosDientes)));
  }

  void setSaludBocalCuentaConTodasSusPiezasDentales(
      bool cuentaConTodasSusPiezasDentales) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal.copyWith(
                cuentaConTodasSusPiezasDentales:
                    cuentaConTodasSusPiezasDentales)));
  }

  void setSaludBocalSeRealizaAseoBucalDespuesDeCadaComida(
      bool seRealizaAseoBucalDespuesDeCadaComida) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal.copyWith(
                seRealizaAseoBucalDespuesDeCadaComida:
                    seRealizaAseoBucalDespuesDeCadaComida)));
  }

  void setSaludBocalTieneAlgunaMolestiaODolorDentroDeSuBoca(
      bool tieneAlgunaMolestiaODolorDentroDeSuBoca) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal.copyWith(
                tieneAlgunaMolestiaODolorDentroDeSuBoca:
                    tieneAlgunaMolestiaODolorDentroDeSuBoca)));
  }

  void setSaludBocalUtilizaPlacaDental(bool utilizaPlacaDental) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal
                .copyWith(utilizaPlacaDental: utilizaPlacaDental)));
  }

  void setSaludBocalPorQueNoCuentaConTodasSusPiezasDentales(
      String porQueNoCuentaConTodasSusPiezasDentales) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal.copyWith(
                porQueNoCuentaConTodasSusPiezasDentales:
                    porQueNoCuentaConTodasSusPiezasDentales)));
  }

  void setSaludBocalQueMolestiaODolor(String queMolestiaODolor) {
    state = state.copyWith(
        createHcAdult: state.createHcAdult.copyWith(
            saludBocal: state.createHcAdult.saludBocal
                .copyWith(queMolestiaODolor: queMolestiaODolor)));
  }

  void reset() {
    state = initialAdult;
  }
}
