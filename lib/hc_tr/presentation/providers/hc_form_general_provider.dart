import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/infrastructure/errors/auth_errors.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/al_nacer_necesito.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/al_nacer_presento.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/alimentacion.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/antecedentes_perinatales.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/antecedentes_personales.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/antecedentes_postnatales.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/aspectos_socializacion.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/comportamiento_general.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/datos_familiares.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/desarrollo_motor_fino.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/desarrollo_motor_grueso.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/especificaciones.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/habitos_personale.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/integracion_sensorial.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/reflejos_primitivos.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_provider.dart';
import 'package:h_c_1/hc_tr/presentation/providers/state/hc_general_state.dart';
import 'package:h_c_1/patient/domain/repositories/patient_repository.dart';
import 'package:h_c_1/patient/infrastructure/repositories/patient_repository_impl.dart';
import 'package:intl/intl.dart';
// 🔹 Provider del formulario de historia clínica general

final initialHcGeneral = HcGeneralFormState(
  edad: 0,
  tipo: 'Nuevo',
  cedula: '',
  successMessage: '',
  errorMessage: '',
  createHcGeneral: CreateHcGeneral(
    patientId: '',
    fechaEntrevista: '',
    nombreCompleto: '',
    fechaNacimiento: '',
    sexo: '',
    escolaridad: '',
    nombreDeInstitucion: '',
    tipoDeInstitucion: '',
    domicilio: '',
    email: '',
    telefono: '',
    entrevistadoPor: '',
    remitidoPor: '',
    motivoDeConsulta: '',
    caracterizacionDelProblema: '',
    historiaEscolar: '',
    antecedentesPersonales: AntecedentesPersonales(
      deseado: false,
      automedicacion: false,
      depresion: false,
      estres: false,
      ansiedad: false,
      traumatismo: false,
      radiaciones: false,
      medicina: false,
      riesgoDeAborto: false,
      maltratoFisico: false,
      consumoDeDrogas: false,
      consumoDeAlcohol: false,
      consumoDeTabaco: false,
      hipertension: false,
      dietaBalanceada: false,
    ),
    antecedentesPerinatales: AntecedentesPerinatales(
      duracionDeLaGestacion: '',
      lugarDeAtencion: '',
      tipoDeParto: '',
      duracionDelParto: '',
      presentacion: '',
      lloroAlNacer: false,
      sufrimientoFetal: false,
      alNacerNecesito: AlNacerNecesito(
        incubadora: false,
        oxigeno: false,
        tiempo: '',
      ),
      alNacerPresento: AlNacerPresento(
        cianosis: false,
        ictericia: false,
        malformaciones: false,
        circulacionDelCordonEnElCuello: false,
        sufrimientoFetal: false,
        peso: '',
        talla: '',
        perimetroCefalico: '',
        apgar: '',
      ),
      observaciones: '',
      antecedentesPostnatales: AntecedentesPostnatales(
        alimentacion: Alimentacion(
          materna: false,
          artificial: false,
          maticacion: false,
        ),
        desarrolloMotorGrueso: DesarrolloMotorGrueso(
          controlCefalico: false,
          gateo: false,
          marcha: false,
          sedestacion: false,
          sincinesias: false,
          subeBajaGradas: false,
          rotacionPies: false,
        ),
        reflejosPrimitivos: ReflejosPrimitivos(
          palmar: false,
          moro: false,
          presion: false,
          deBusqueda: false,
          banbiski: false,
        ),
        desarrolloMotorFino: DesarrolloMotorFino(
          pinzaDigital: false,
          garabateo: false,
          sostenerObjetos: false,
          angustiaSinCausa: false,
          balanceos: false,
          cambioDeCaracterExtremo: false,
          caminaEnPuntitas: false,
          caminaSinSentido: false,
          conductasProblematicas: false,
          conocimientoDeAlgunTema: false,
          ecolalia: false,
          frioEmocional: false,
          frioParaHablar: false,
          garabato: false,
          hablaComoAdulto: false,
          ingenuo: false,
          iniciaYMantieneConversaciones: false,
          intencionComunicativa: false,
          interesRestringido: false,
          irritabilidad: false,
          juegoImaginativo: false,
          juegoRepetitivo: false,
          lenguajeLiteral: false,
          manipulaPermanentementeAlgo: false,
          manipulaPermanentementeUnObjeto: false,
          miraALosOjos: false,
          movimientosEstereotipados: false,
          otrosSistemasDeComunicacion: false,
          pensamientosObsesivos: false,
          pocosAmigos: false,
          preferenciaPorAlgunAlimento: false,
          problemaDeSueno: false,
          problemasAlimenticios: false,
          reiteraTemasFavoritos: false,
          selectivoEnLaComida: false,
          sonidosExtranos: false,
          sonrisaSocial: false,
          tendenciaARutinas: false,
          ticsMotores: false,
          ticsVocales: false,
          torpezaMotriz: false,
        ),
        especificaciones: Especificaciones(
          intensionComunicativaHospitalizaciones: '',
          traumatismo: '',
          infecciones: '',
          reaccionesPeculiaresVacunas: '',
          desnutricionOObesidad: '',
          cirugias: '',
          convulsiones: '',
          medicacion: '',
          sindromes: '',
          observaciones: '',
          diagnosticStudies: '',
        ),
        habitosPersonales: HabitosPersonales(
          berrinches: false,
          insulta: false,
          llora: false,
          grita: false,
          agrede: false,
          seEncierra: false,
          pideAyuda: false,
          pegaALosPadres: false,
          aptitudesEInteresesEscolares: '',
          rendimientoGeneralEscolaridad: '',
          comportamientoGeneral: ComportamientoGeneral(
            agresivo: false,
            pasivo: false,
            destructor: false,
            sociable: false,
            hipercinetico: false,
            empatia: false,
            interesesPeculiares: false,
            interesPorInteraccion: false,
          ),
          aspectosSocializacion: AspectosSocializacion(
              asociaObjetos: false,
              lograConcentrarse5Min: false,
              mayores: false,
              menores: false,
              reaccionConPersonasExtranas: false,
              reconoceASusFamiliares: false,
              reconoceColoresBasicos: false,
              reconocePartesDelCuerpo: false,
              socializacionConFamilia: false,
              todos: false),
          datosFamiliares: DatosFamiliares(
            disfuncional: false,
            extensa: false,
            funcional: false,
            monoParental: false,
            nuclear: false,
            reconstituida: false,
          ),
          quienViveEnCasa: '',
          integracionSensorial: IntegracionSensorial(
            tacto: false,
            gustoYolfato: false,
            oido: false,
            vista: false,
          ),
        ),
      ),
    ),
  ),
);

final hcGeneralProvider =
    AutoDisposeStateNotifierProvider<HcGeneralFormNotifier, HcGeneralFormState>(
  (ref) {
    final getHcGeneral = ref.read(hcProvider.notifier).getHcGeneral;
    PatientRepository patientRepository = PatientRepositoryImpl();
    final createHcGeneral = ref.read(hcProvider.notifier).createHcGeneral;
    return HcGeneralFormNotifier(
        patientRepository: patientRepository,
        createHcGeneral: createHcGeneral,
        getHcGeneral: getHcGeneral);
  },
);

class HcGeneralFormNotifier extends StateNotifier<HcGeneralFormState> {
  final PatientRepository patientRepository;
  final Function(CreateHcGeneral) createHcGeneral;
  final Function(String) getHcGeneral;
  HcGeneralFormNotifier({
    required this.getHcGeneral,
    required this.createHcGeneral,
    required this.patientRepository,
  }) : super(
          initialHcGeneral,
        );

  // 🔹 Métodos para actualizar los campos principales
  void onPatientIdChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(patientId: value),
    );
  }

  void onCedulaChanged(String value) {
    state = state.copyWith(
      cedula: value,
    );
  }

void onFechaEntrevistaChanged(DateTime fecha) {
  final fechaFormato = DateFormat('yyyy-MM-dd').format(fecha);
  state = state.copyWith(
    createHcGeneral: state.createHcGeneral.copyWith(fechaEntrevista: fechaFormato),
  );
}

  Future<void> getPacienteByDni(String dni) async {
    try {
      state = state.copyWith(loading: true);
      final paciente = await patientRepository.getPatientByDni(dni);

      // Formatear la fecha de nacimiento a 'yyyy-MM-dd'
      final fechaNacimiento =
          DateFormat('yyyy-MM-dd').format(paciente.birthdate);

      // Calcular la edad
      final edad = calcularEdad(fechaNacimiento);

      // Mapear el género obtenido al formato esperado
      final genders = {
        'HOMBRE': 'Masculino',
        'MUJER': 'Femenino',
        'Otro': 'Otro',
      };
      final sexo = genders[paciente.gender] ?? 'Otro';

      // Actualizar el estado con la información del paciente
      state = state.copyWith(
        loading: false,
        edad: edad,
        createHcGeneral: state.createHcGeneral.copyWith(
          patientId: paciente.id,
          nombreCompleto: '${paciente.firstname} ${paciente.lastname}',
          fechaNacimiento: fechaNacimiento,
          sexo: sexo,
          // Actualiza otros campos según sea necesario
        ),
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        loading: false,
        errorMessage: e.message ?? 'Error al obtener paciente',
      );
    }
  }

  Future<void> onCreateHcGeneral() async {
    try {
      state = state.copyWith(loading: true);
      // Asegúrate de que 'fechaEntrevista' esté en el formato correcto
      final fechaEntrevista = state.createHcGeneral.fechaEntrevista;
      final fechaNacimiento = state.createHcGeneral.fechaNacimiento;
      // Verifica si la cadena contiene una 'T'; si no, agrégala junto con la hora
      final fechaFormatoCorrecto = fechaEntrevista.contains('T')
          ? fechaEntrevista
          : '${fechaEntrevista}T00:00:00Z';
      final fechaNacimientoFormatoCorrecto = fechaNacimiento.contains('T')
          ? fechaNacimiento
          : '${fechaNacimiento}T00:00:00Z';
      // Analiza la cadena de fecha y obtén el objeto DateTime
      final fechaParsed = DateTime.parse(fechaFormatoCorrecto);
      final fechaNacimientoParsed =
          DateTime.parse(fechaNacimientoFormatoCorrecto);
      // Actualiza el estado con la fecha en formato ISO 8601
      state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
          fechaEntrevista: fechaParsed.toIso8601String(),
          fechaNacimiento: fechaNacimientoParsed.toIso8601String(),
        ),
      );
      print(state.createHcGeneral.fechaEntrevista);
      print('🔹 Creando historia clínica general...');
      print(state.createHcGeneral.toJson());
      print("Se creó la historia clínica general");
      await createHcGeneral(state.createHcGeneral);

      // Limpiar campos
      state = initialHcGeneral;
      state =
          state.copyWith(successMessage: 'Historia clínica creada con éxito');
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

  Future<void> onSearchHcGeneral(String cedula) async {
    try {
      state = state.copyWith(loading: true);
      final hcGeneral = await getHcGeneral(cedula);
      print("Aqui tambien llega ${hcGeneral?.toJson()}");
      state = state.copyWith(
        createHcGeneral: hcGeneral,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message ?? 'Error al obtener historia clínica',
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void onTipoChanged(String value) {
    state = state.copyWith(
      tipo: value,
    );
  }


  void onNombreCompletoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(nombreCompleto: value),
    );
  }

  void onFechaNacimientoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(fechaNacimiento: value),
    );
  }

  void onSexoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(sexo: value),
    );
  }

  void onEscolaridadChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(escolaridad: value),
    );
  }

  void onNombreDeInstitucionChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        nombreDeInstitucion: value,
      ),
    );
  }

  void onTipoDeInstitucionChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        tipoDeInstitucion: value,
      ),
    );
  }

  void onDomicilioChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(domicilio: value),
    );
  }

  void onEmailChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(email: value),
    );
  }

  void onTelefonoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(telefono: value),
    );
  }

  void onEntrevistadoPorChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(entrevistadoPor: value),
    );
  }

  void onRemitidoPorChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(remitidoPor: value),
    );
  }

  void onMotivoDeConsultaChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(motivoDeConsulta: value),
    );
  }

  void onCaracterizacionDelProblemaChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        caracterizacionDelProblema: value,
      ),
    );
  }

  void onHistoriaEscolarChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(historiaEscolar: value),
    );
  }

  // 🔹 Métodos para actualizar los campos de antecedentes personales
  void onDeseadoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(deseado: value),
      ),
    );
  }

  void onAutomedicacionChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(automedicacion: value),
      ),
    );
  }

  void onDepresionChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(depresion: value),
      ),
    );
  }

  void onEstresChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(estres: value),
      ),
    );
  }

  void onAnsiedadChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(ansiedad: value),
      ),
    );
  }

  void onTraumatismoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(traumatismo: value),
      ),
    );
  }

  void onRadiacionesChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(radiaciones: value),
      ),
    );
  }

  void onMedicinaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(medicina: value),
      ),
    );
  }

  void onRiesgoDeAbortoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(riesgoDeAborto: value),
      ),
    );
  }

  void onMaltratoFisicoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(maltratoFisico: value),
      ),
    );
  }

  void onConsumoDeDrogasChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(consumoDeDrogas: value),
      ),
    );
  }

  void onConsumoDeAlcoholChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(consumoDeAlcohol: value),
      ),
    );
  }

  void onConsumoDeTabacoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(consumoDeTabaco: value),
      ),
    );
  }

  void onHipertensionChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(hipertension: value),
      ),
    );
  }

  void onDietaBalanceadaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPersonales: state.createHcGeneral.antecedentesPersonales
            .copyWith(dietaBalanceada: value),
      ),
    );
  }

  // 🔹 Métodos para actualizar antecedentes perinatales
  void onTipoDePartoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales
            .copyWith(tipoDeParto: value),
      ),
    );
  }

  void onDuracionDeLaGestacionChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales
            .copyWith(duracionDeLaGestacion: value),
      ),
    );
  }

  void onLugarDeAtencionChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales
            .copyWith(lugarDeAtencion: value),
      ),
    );
  }

  void onDuracionDelPartoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales
            .copyWith(duracionDelParto: value),
      ),
    );
  }

  void onPresentacionChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales
            .copyWith(presentacion: value),
      ),
    );
  }

  void onLloroAlNacerChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales
            .copyWith(lloroAlNacer: value),
      ),
    );
  }

  void onSufrimientoFetalChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales
            .copyWith(sufrimientoFetal: value),
      ),
    );
  }

  void onObservacionesChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales
            .copyWith(observaciones: value),
      ),
    );
  }

  void onAlNacerNecesitoIncubadoraChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerNecesito: state
              .createHcGeneral.antecedentesPerinatales.alNacerNecesito
              .copyWith(incubadora: value),
        ),
      ),
    );
  }

  void onAlNacerNecesitoOxigenoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerNecesito: state
              .createHcGeneral.antecedentesPerinatales.alNacerNecesito
              .copyWith(oxigeno: value),
        ),
      ),
    );
  }

  void onAlNacerNecesitoTiempoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerNecesito: state
              .createHcGeneral.antecedentesPerinatales.alNacerNecesito
              .copyWith(tiempo: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoCianosisChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(cianosis: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoIctericiaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(ictericia: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoMalformacionesChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(malformaciones: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoCirculacionDelCordonEnElCuelloChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(circulacionDelCordonEnElCuello: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoSufrimientoFetalChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(sufrimientoFetal: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoPesoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(peso: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoTallaChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(talla: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoPerimetroCefalicoChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(perimetroCefalico: value),
        ),
      ),
    );
  }

  void onAlNacerPresentoApgarChanged(String value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          alNacerPresento: state
              .createHcGeneral.antecedentesPerinatales.alNacerPresento
              .copyWith(apgar: value),
        ),
      ),
    );
  }

  // 🔹 Métodos para antecedentres Postnatales
  // 🔹 Métodos para actualizar alimentación
  void onAlimentacionMaternaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            alimentacion: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.alimentacion
                .copyWith(materna: value),
          ),
        ),
      ),
    );
  }

  void onAlimentacionArtificialChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            alimentacion: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.alimentacion
                .copyWith(artificial: value),
          ),
        ),
      ),
    );
  }

  void onAlimentacionMaticacionChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            alimentacion: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.alimentacion
                .copyWith(maticacion: value),
          ),
        ),
      ),
    );
  }

  // 🔹 Métodos para actualizar desarrollo motor grueso
  void onControlCefalicoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorGrueso: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorGrueso
                .copyWith(controlCefalico: value),
          ),
        ),
      ),
    );
  }

  void onGateoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorGrueso: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorGrueso
                .copyWith(gateo: value),
          ),
        ),
      ),
    );
  }

  void onMarchaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorGrueso: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorGrueso
                .copyWith(marcha: value),
          ),
        ),
      ),
    );
  }

  void onSedestacionChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorGrueso: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorGrueso
                .copyWith(sedestacion: value),
          ),
        ),
      ),
    );
  }

  void onSincinesiasChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorGrueso: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorGrueso
                .copyWith(sincinesias: value),
          ),
        ),
      ),
    );
  }

  void onSubeBajaGradasChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorGrueso: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorGrueso
                .copyWith(subeBajaGradas: value),
          ),
        ),
      ),
    );
  }

  void onRotacionPiesChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorGrueso: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorGrueso
                .copyWith(rotacionPies: value),
          ),
        ),
      ),
    );
  }

  // 🔹 Métodos para actualizar reflejos primitivos
  void onPalmarChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            reflejosPrimitivos: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos
                .copyWith(palmar: value),
          ),
        ),
      ),
    );
  }

  void onMoroChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            reflejosPrimitivos: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos
                .copyWith(moro: value),
          ),
        ),
      ),
    );
  }

  void onPresionChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            reflejosPrimitivos: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos
                .copyWith(presion: value),
          ),
        ),
      ),
    );
  }

  void onDeBusquedaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            reflejosPrimitivos: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos
                .copyWith(deBusqueda: value),
          ),
        ),
      ),
    );
  }

  void onBanbiskiChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            reflejosPrimitivos: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos
                .copyWith(banbiski: value),
          ),
        ),
      ),
    );
  }

  // 🔹 Método para actualizar `pinzaDigital`
  void onPinzaDigitalChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(pinzaDigital: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `garabateo`
  void onGarabateoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(garabateo: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `sostenerObjetos`
  void onSostenerObjetosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(sostenerObjetos: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `problemasAlimenticios`
  void onProblemasAlimenticiosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(problemasAlimenticios: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `garabato`
  void onGarabatoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(garabato: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `ticsMotores`
  void onTicsMotoresChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(ticsMotores: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `ticsVocales`
  void onTicsVocalesChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(ticsVocales: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `conductasProblematicas`
  void onConductasProblematicasChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(conductasProblematicas: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `sonrisaSocial`
  void onSonrisaSocialChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(sonrisaSocial: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `movimientosEstereotipados`
  void onMovimientosEstereotipadosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(movimientosEstereotipados: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `manipulaPermanentementeUnObjeto`
  void onManipulaPermanentementeUnObjetoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(manipulaPermanentementeUnObjeto: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `balanceos`
  void onBalanceosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(balanceos: value),
          ),
        ),
      ),
    );
  }

  // 🔹 Método para actualizar `juegoRepetitivo`
  void onJuegoRepetitivoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(juegoRepetitivo: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `tendenciaARutinas`
  void onTendenciaARutinasChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(tendenciaARutinas: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `caminaSinSentido`
  void onCaminaSinSentidoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(caminaSinSentido: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `problemaDeSueno`
  void onProblemaDeSuenoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(problemaDeSueno: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `reiteraTemasFavoritos`
  void onReiteraTemasFavoritosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(reiteraTemasFavoritos: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `caminaEnPuntitas`
  void onCaminaEnPuntitasChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(caminaEnPuntitas: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `irritabilidad`
  void onIrritabilidadChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(irritabilidad: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `manipulaPermanentementeAlgo`
  void onManipulaPermanentementeAlgoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(manipulaPermanentementeAlgo: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `iniciaYMantieneConversaciones`
  void onIniciaYMantieneConversacionesChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(iniciaYMantieneConversaciones: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `ecolalia`
  void onEcolaliaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(ecolalia: value),
          ),
        ),
      ),
    );
  }

  // 🔹 Método para actualizar `conocimientoDeAlgunTema`
  void onConocimientoDeAlgunTemaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(conocimientoDeAlgunTema: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `lenguajeLiteral`
  void onLenguajeLiteralChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(lenguajeLiteral: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `miraALosOjos`
  void onMiraALosOjosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(miraALosOjos: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `otrosSistemasDeComunicacion`
  void onOtrosSistemasDeComunicacionChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(otrosSistemasDeComunicacion: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `selectivoEnLaComida`
  void onSelectivoEnLaComidaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(selectivoEnLaComida: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `intencionComunicativa`
  void onIntencionComunicativaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(intencionComunicativa: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `interesRestringido`
  void onInteresRestringidoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(interesRestringido: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `angustiaSinCausa`
  void onAngustiaSinCausaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(angustiaSinCausa: value),
          ),
        ),
      ),
    );
  }

  // 🔹 Método para actualizar `preferenciaPorAlgunAlimento`
  void onPreferenciaPorAlgunAlimentoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(preferenciaPorAlgunAlimento: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `sonidosExtranos`
  void onSonidosExtranosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(sonidosExtranos: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `hablaComoAdulto`
  void onHablaComoAdultoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(hablaComoAdulto: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `frioParaHablar`
  void onFrioParaHablarChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(frioParaHablar: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `pensamientosObsesivos`
  void onPensamientosObsesivosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(pensamientosObsesivos: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `cambioDeCaracterExtremo`
  void onCambioDeCaracterExtremoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(cambioDeCaracterExtremo: value),
          ),
        ),
      ),
    );
  }

  // 🔹 Método para actualizar `ingenuo`
  void onIngenuoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(ingenuo: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `torpezaMotriz`
  void onTorpezaMotrizChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(torpezaMotriz: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `frioEmocional`
  void onFrioEmocionalChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(frioEmocional: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `pocosAmigos`
  void onPocosAmigosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(pocosAmigos: value),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `juegoImaginativo`
  void onJuegoImaginativoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            desarrolloMotorFino: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.desarrolloMotorFino
                .copyWith(juegoImaginativo: value),
          ),
        ),
      ),
    );
  }

// 🔹 Métodos para actualizar la subclase Especificaciones

  void onIntensionComunicativaHospitalizacionesChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(
                                    intensionComunicativaHospitalizaciones:
                                        value)))));
  }

  void onEspecificacionesTraumatismoChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(traumatismo: value)))));
  }

  void onEspecificacionesCirugiasChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(cirugias: value)))));
  }

  void onEspecificacionesInfeccionesChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(infecciones: value)))));
  }

  void onEspecificacionesReaccionesPeculiaresVacunasChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(
                                    reaccionesPeculiaresVacunas: value)))));
  }

  void onEspecificacionesDesnutricionOObesidadChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(desnutricionOObesidad: value)))));
  }

  void onEspecificacionesConvulcionesChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(convulsiones: value)))));
  }

  void onEspecificacionesMedicacionChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(medicacion: value)))));
  }

  void onEspecificacionesSindromesChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(sindromes: value)))));
  }

  void onEspecificacionesObservacionesChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(observaciones: value)))));
  }

  void onEspecificacionesDiagnosticStudiesChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            especificaciones: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .especificaciones
                                .copyWith(diagnosticStudies: value)))));
  }

  // 🔹 Método para actualizar la subclase de Habitos Personales
  //berrinches, insulta, llora, grita, agrede, seEncierra, pideAyuda, pegaALosPadres, aptitudesInteresesEscolares, rendimientoGeneralEscolaridad

  void onHabitosPersonalesBerrinchesChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(berrinches: value)))));
  }

  void onHabitosPersonalesInsultaChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(insulta: value)))));
  }

  void onHabitosPersonalesLloraChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(llora: value)))));
  }

  void onHabitosPersonalesGritaChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(grita: value)))));
  }

  void onHabitosPersonalesAgredeChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(agrede: value)))));
  }

  void onHabitosPersonalesSeEncierraChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(seEncierra: value)))));
  }

  void onHabitosPersonalesPideAyudaChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(pideAyuda: value)))));
  }

  void onHabitosPersonalesPegaALosPadresChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(pegaALosPadres: value)))));
  }

  void onHabitosPersonalesAptitudesInteresesEscolaresChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(
                                    aptitudesEInteresesEscolares: value)))));
  }

  void onHabitosPersonalesRendimientoGeneralEscolaridadChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(
                                    rendimientoGeneralEscolaridad: value)))));
  }

// Metodos para actualizar Comportamiento General de Habitos

  void onHabitosPersonalesComportamientoGeneralAgresivoChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales.copyWith(
                antecedentesPostnatales: state.createHcGeneral
                    .antecedentesPerinatales.antecedentesPostnatales
                    .copyWith(
                        habitosPersonales: state
                            .createHcGeneral
                            .antecedentesPerinatales
                            .antecedentesPostnatales
                            .habitosPersonales
                            .copyWith(
                                comportamientoGeneral: state
                                    .createHcGeneral
                                    .antecedentesPerinatales
                                    .antecedentesPostnatales
                                    .habitosPersonales
                                    .comportamientoGeneral
                                    .copyWith(agresivo: value))))));
  }

  void onHabitosPersonalesComportamientoGeneralPasivoChanged(bool value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales: state.createHcGeneral.antecedentesPerinatales.copyWith(
                antecedentesPostnatales: state.createHcGeneral
                    .antecedentesPerinatales.antecedentesPostnatales
                    .copyWith(
                        habitosPersonales: state
                            .createHcGeneral
                            .antecedentesPerinatales
                            .antecedentesPostnatales
                            .habitosPersonales
                            .copyWith(
                                comportamientoGeneral: state
                                    .createHcGeneral
                                    .antecedentesPerinatales
                                    .antecedentesPostnatales
                                    .habitosPersonales
                                    .comportamientoGeneral
                                    .copyWith(pasivo: value))))));
  }

  // 🔹 Método para actualizar `destructor`
  void onHabitosPersonalesComportamientoGeneralDestructorChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              comportamientoGeneral: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .comportamientoGeneral
                  .copyWith(
                destructor: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `sociable`
  void onHabitosPersonalesComportamientoGeneralSociableChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              comportamientoGeneral: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .comportamientoGeneral
                  .copyWith(
                sociable: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `hipercinetico`
  void onHabitosPersonalesComportamientoGeneralHipercineticoChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              comportamientoGeneral: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .comportamientoGeneral
                  .copyWith(
                hipercinetico: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `empatia`
  void onHabitosPersonalesComportamientoGeneralEmpatiaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              comportamientoGeneral: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .comportamientoGeneral
                  .copyWith(
                empatia: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `interesesPeculiares`
  void onHabitosPersonalesComportamientoGeneralInteresesPeculiaresChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              comportamientoGeneral: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .comportamientoGeneral
                  .copyWith(
                interesesPeculiares: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `interesPorInteraccion`
  void onHabitosPersonalesComportamientoGeneralInteresPorInteraccionChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              comportamientoGeneral: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .comportamientoGeneral
                  .copyWith(
                interesPorInteraccion: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Método para actualizar `mayores`
  void onHabitosPersonalesAspectosSocializacionMayoresChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                mayores: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `menores`
  void onHabitosPersonalesAspectosSocializacionMenoresChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                menores: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `todos`
  void onHabitosPersonalesAspectosSocializacionTodosChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                todos: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `socializacionConFamilia`
  void onHabitosPersonalesAspectosSocializacionSocializacionConFamiliaChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                socializacionConFamilia: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `reaccionConPersonasExtrañas`
  void
      onHabitosPersonalesAspectosSocializacionReaccionConPersonasExtranasChanged(
          bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                reaccionConPersonasExtranas: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `lograConcentrarse5Min`
  void onHabitosPersonalesAspectosSocializacionLograConcentrarse5MinChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                lograConcentrarse5Min: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `reconocePartesDelCuerpo`
  void onHabitosPersonalesAspectosSocializacionReconocePartesDelCuerpoChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                reconocePartesDelCuerpo: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `asociaObjetos`
  void onHabitosPersonalesAspectosSocializacionAsociaObjetosChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                asociaObjetos: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `reconoceASusFamiliares`
  void onHabitosPersonalesAspectosSocializacionReconoceASusFamiliaresChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                reconoceASusFamiliares: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `reconoceColoresBasicos`
  void onHabitosPersonalesAspectosSocializacionReconoceColoresBasicosChanged(
      bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              aspectosSocializacion: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .aspectosSocializacion
                  .copyWith(
                reconoceColoresBasicos: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Método para actualizar `nuclear`
  void onHabitosPersonalesDatosFamiliaresNuclearChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              datosFamiliares: state.createHcGeneral.antecedentesPerinatales
                  .antecedentesPostnatales.habitosPersonales.datosFamiliares
                  .copyWith(
                nuclear: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `monoParental`
  void onHabitosPersonalesDatosFamiliaresMonoParentalChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              datosFamiliares: state.createHcGeneral.antecedentesPerinatales
                  .antecedentesPostnatales.habitosPersonales.datosFamiliares
                  .copyWith(
                monoParental: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `funcional`
  void onHabitosPersonalesDatosFamiliaresFuncionalChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              datosFamiliares: state.createHcGeneral.antecedentesPerinatales
                  .antecedentesPostnatales.habitosPersonales.datosFamiliares
                  .copyWith(
                funcional: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `reconstituida`
  void onHabitosPersonalesDatosFamiliaresReconstituidaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              datosFamiliares: state.createHcGeneral.antecedentesPerinatales
                  .antecedentesPostnatales.habitosPersonales.datosFamiliares
                  .copyWith(
                reconstituida: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `disfuncional`
  void onHabitosPersonalesDatosFamiliaresDisfuncionalChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              datosFamiliares: state.createHcGeneral.antecedentesPerinatales
                  .antecedentesPostnatales.habitosPersonales.datosFamiliares
                  .copyWith(
                disfuncional: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `extensa`
  void onHabitosPersonalesDatosFamiliaresExtensaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              datosFamiliares: state.createHcGeneral.antecedentesPerinatales
                  .antecedentesPostnatales.habitosPersonales.datosFamiliares
                  .copyWith(
                extensa: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onHabitosPersonalesQuienViveEnCasaChanged(String value) {
    state = state.copyWith(
        createHcGeneral: state.createHcGeneral.copyWith(
            antecedentesPerinatales:
                state.createHcGeneral.antecedentesPerinatales.copyWith(
                    antecedentesPostnatales: state.createHcGeneral
                        .antecedentesPerinatales.antecedentesPostnatales
                        .copyWith(
                            habitosPersonales: state
                                .createHcGeneral
                                .antecedentesPerinatales
                                .antecedentesPostnatales
                                .habitosPersonales
                                .copyWith(quienViveEnCasa: value)))));
  }

  // 🔹 Método para actualizar `vista`
  void onHabitosPersonalesIntegracionSensorialVistaChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              integracionSensorial: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .integracionSensorial
                  .copyWith(
                vista: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `oido`
  void onHabitosPersonalesIntegracionSensorialOidoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              integracionSensorial: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .integracionSensorial
                  .copyWith(
                oido: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `tacto`
  void onHabitosPersonalesIntegracionSensorialTactoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              integracionSensorial: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .integracionSensorial
                  .copyWith(
                tacto: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

// 🔹 Método para actualizar `gustoYolfato`
  void onHabitosPersonalesIntegracionSensorialGustoYolfatoChanged(bool value) {
    state = state.copyWith(
      createHcGeneral: state.createHcGeneral.copyWith(
        antecedentesPerinatales:
            state.createHcGeneral.antecedentesPerinatales.copyWith(
          antecedentesPostnatales: state
              .createHcGeneral.antecedentesPerinatales.antecedentesPostnatales
              .copyWith(
            habitosPersonales: state.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.habitosPersonales
                .copyWith(
              integracionSensorial: state
                  .createHcGeneral
                  .antecedentesPerinatales
                  .antecedentesPostnatales
                  .habitosPersonales
                  .integracionSensorial
                  .copyWith(
                gustoYolfato: value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  int calcularEdad(String fechaNacimiento) {
    try {
      final fechaNacimientoParse = DateTime.parse(fechaNacimiento);
      final fechaActual = DateTime.now();
      int edad = fechaActual.year - fechaNacimientoParse.year;
      if (fechaActual.month < fechaNacimientoParse.month ||
          (fechaActual.month == fechaNacimientoParse.month &&
              fechaActual.day < fechaNacimientoParse.day)) {
        edad--;
      }
      return edad;
    } catch (e) {
      print('Error al parsear la fecha: $e');
      return 0; // Retorna 0 si hay un error en el parseo
    }
  }
}
