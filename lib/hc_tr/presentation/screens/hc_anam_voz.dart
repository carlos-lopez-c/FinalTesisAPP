import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_voice_provider.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_provider.dart';
import 'package:h_c_1/hc_tr/presentation/providers/state/hc_voice_state.dart';
import '/hc_tr/presentation/widgets/headerTR.dart';

class HcTrAnamVoz extends ConsumerStatefulWidget {
  const HcTrAnamVoz({Key? key}) : super(key: key);

  @override
  _HcTrAnamVozState createState() => _HcTrAnamVozState();
}

class _HcTrAnamVozState extends ConsumerState<HcTrAnamVoz> {
  late TextEditingController cedulaController;
  late TextEditingController fechaNacimientoController;
  late TextEditingController nombreCompletoController;
  late TextEditingController ocupacionActualController;
  late TextEditingController direccionController;
  late TextEditingController derivadoPorController;
  late TextEditingController razonDeDerivacionController;
  late TextEditingController diagnosticoORLController;
  late TextEditingController telefonoDeContactoController;
  late TextEditingController fechaDeEvaluacionController;
  late TextEditingController motivoDeConsultaController;
  late TextEditingController esLaPrimeraVezQueTieneEstaDificultadController;
  late TextEditingController desdeCuandoTieneEstaDificultadController;
  late TextEditingController formaDeInicioController;
  late TextEditingController aQueLoAtribuyeController;
  late TextEditingController comoLoAfectaController;
  late TextEditingController cuandoSeAgravaController;
  late TextEditingController comoHaSidoSuEvolucionController;
  late TextEditingController momentoDelDiaConMayorDificultadController;
  late TextEditingController enQueSituacionesAparecenMolestiasController;
  late TextEditingController problemasDeVozEnSuFamiliaController;
  late TextEditingController lasEmocionesDananSuVozController;
  late TextEditingController medicamentosQueTomaController;
  late TextEditingController
      accidentesOenfermedadesGravesQueHayaTenidoController;
  late TextEditingController haSidoIntervenidoQuirurgicamenteController;
  late TextEditingController haSidoEntubadoController;
  late TextEditingController haConsultadoConOtrosProfesionalesController;
  late TextEditingController cuantoTiempoController;
  late TextEditingController horasDeSuenoController;
  late TextEditingController horasDeTrabajoController;
  late TextEditingController posturaParaTrabajarController;
  late TextEditingController utilizaSuVozDeFormaProlongadaController;
  late TextEditingController realizaReposoVocalController;
  late TextEditingController ingieoLiquidosDuranteLaJornadaLaboralController;
  late TextEditingController utilizaAmplificacionParaCantarController;
  late TextEditingController asisteAClasesConProfesionalesDeLaVozController;

  @override
  void initState() {
    super.initState();
    cedulaController = TextEditingController();
    fechaNacimientoController = TextEditingController();
    nombreCompletoController = TextEditingController();
    ocupacionActualController = TextEditingController();
    direccionController = TextEditingController();
    derivadoPorController = TextEditingController();
    razonDeDerivacionController = TextEditingController();
    diagnosticoORLController = TextEditingController();
    telefonoDeContactoController = TextEditingController();
    fechaDeEvaluacionController = TextEditingController();
    motivoDeConsultaController = TextEditingController();
    esLaPrimeraVezQueTieneEstaDificultadController = TextEditingController();
    desdeCuandoTieneEstaDificultadController = TextEditingController();
    aQueLoAtribuyeController = TextEditingController();
    comoLoAfectaController = TextEditingController();
    cuandoSeAgravaController = TextEditingController();
    comoHaSidoSuEvolucionController = TextEditingController();
    momentoDelDiaConMayorDificultadController = TextEditingController();
    enQueSituacionesAparecenMolestiasController = TextEditingController();
    problemasDeVozEnSuFamiliaController = TextEditingController();
    lasEmocionesDananSuVozController = TextEditingController();
    medicamentosQueTomaController = TextEditingController();
    accidentesOenfermedadesGravesQueHayaTenidoController =
        TextEditingController();
    formaDeInicioController = TextEditingController();
    haSidoIntervenidoQuirurgicamenteController = TextEditingController();
    haSidoEntubadoController = TextEditingController();
    haConsultadoConOtrosProfesionalesController = TextEditingController();
    cuantoTiempoController = TextEditingController();
    horasDeSuenoController = TextEditingController();
    horasDeTrabajoController = TextEditingController();
    posturaParaTrabajarController = TextEditingController();
    utilizaSuVozDeFormaProlongadaController = TextEditingController();
    realizaReposoVocalController = TextEditingController();
    ingieoLiquidosDuranteLaJornadaLaboralController = TextEditingController();
    utilizaAmplificacionParaCantarController = TextEditingController();
    asisteAClasesConProfesionalesDeLaVozController = TextEditingController();
  }

  @override
  void dispose() {
    // Liberar todos los controladores de texto
    cedulaController.dispose();
    fechaNacimientoController.dispose();
    nombreCompletoController.dispose();
    ocupacionActualController.dispose();
    direccionController.dispose();
    derivadoPorController.dispose();
    razonDeDerivacionController.dispose();
    diagnosticoORLController.dispose();
    telefonoDeContactoController.dispose();
    fechaDeEvaluacionController.dispose();
    motivoDeConsultaController.dispose();
    esLaPrimeraVezQueTieneEstaDificultadController.dispose();
    desdeCuandoTieneEstaDificultadController.dispose();
    aQueLoAtribuyeController.dispose();
    comoLoAfectaController.dispose();
    cuandoSeAgravaController.dispose();
    comoHaSidoSuEvolucionController.dispose();
    formaDeInicioController.dispose();
    momentoDelDiaConMayorDificultadController.dispose();
    enQueSituacionesAparecenMolestiasController.dispose();
    problemasDeVozEnSuFamiliaController.dispose();
    lasEmocionesDananSuVozController.dispose();
    medicamentosQueTomaController.dispose();
    accidentesOenfermedadesGravesQueHayaTenidoController.dispose();
    haSidoIntervenidoQuirurgicamenteController.dispose();
    haSidoEntubadoController.dispose();
    haConsultadoConOtrosProfesionalesController.dispose();
    cuantoTiempoController.dispose();
    horasDeSuenoController.dispose();
    horasDeTrabajoController.dispose();
    posturaParaTrabajarController.dispose();
    utilizaSuVozDeFormaProlongadaController.dispose();
    realizaReposoVocalController.dispose();
    ingieoLiquidosDuranteLaJornadaLaboralController.dispose();
    utilizaAmplificacionParaCantarController.dispose();
    asisteAClasesConProfesionalesDeLaVozController.dispose();

    // Llamar al método dispose de la superclase
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcState = ref.watch(hcVoiceFormProvider);
    final hcNotifier = ref.read(hcVoiceFormProvider.notifier);

    ref.listen<HcVoiceState?>(hcVoiceFormProvider, (previous, next) {
      if (next!.successMessage.isNotEmpty) {
        _showSnackBar(context, next.successMessage, true);
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcVoiceFormProvider.notifier).clearSuccessMessage();
        });
      } else if (next.errorMessage.isNotEmpty) {
        _showSnackBar(context, next.errorMessage, false);
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcVoiceFormProvider.notifier).clearErrorMessage();
        });
      }
    });

    ref.listen<HCState?>(hcProvider, (previous, next) {
      if (next!.successMessage.isNotEmpty) {
        _showSnackBar(context, next.successMessage, true);
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcProvider.notifier).clearSuccess();
        });
      } else if (next.errorMessage.isNotEmpty) {
        _showSnackBar(context, next.errorMessage, false);
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcProvider.notifier).clearError();
        });
      }
    });

    // Actualizar los controladores cuando el estado cambia
    cedulaController.text = hcState.cedula;
    fechaNacimientoController.text = hcState.createHcVoice.fechaNacimiento;
    nombreCompletoController.text = hcState.createHcVoice.nombreCompleto;
    ocupacionActualController.text = hcState.createHcVoice.ocupacionActual;
    direccionController.text = hcState.createHcVoice.direccion;
    derivadoPorController.text = hcState.createHcVoice.derivadoPor;
    razonDeDerivacionController.text = hcState.createHcVoice.razonDeDerivacion;
    diagnosticoORLController.text = hcState.createHcVoice.diagnosticoORL;
    telefonoDeContactoController.text =
        hcState.createHcVoice.telefonoDeContacto;
    fechaDeEvaluacionController.text = hcState.createHcVoice.fechaDeEvaluacion;
    motivoDeConsultaController.text =
        hcState.createHcVoice.historiaClinica.motivoDeConsulta;
    esLaPrimeraVezQueTieneEstaDificultadController.text = hcState
        .createHcVoice.historiaClinica.esLaPrimeraVezQueTieneEstaDificultad;
    desdeCuandoTieneEstaDificultadController.text =
        hcState.createHcVoice.historiaClinica.desdeCuandoTieneEstaDificultad;
    aQueLoAtribuyeController.text =
        hcState.createHcVoice.historiaClinica.aQueLoAtribuye;
    comoLoAfectaController.text =
        hcState.createHcVoice.historiaClinica.comoLoAfecta;
    cuandoSeAgravaController.text =
        hcState.createHcVoice.historiaClinica.cuandoSeAgrava;
    comoHaSidoSuEvolucionController.text =
        hcState.createHcVoice.historiaClinica.comoHaSidoSuEvolucion;
    momentoDelDiaConMayorDificultadController.text =
        hcState.createHcVoice.historiaClinica.momentoDelDiaConMayorDificultad;
    enQueSituacionesAparecenMolestiasController.text =
        hcState.createHcVoice.historiaClinica.enQueSituacionesAparecenMolestias;
    formaDeInicioController.text =
        hcState.createHcVoice.historiaClinica.formaDeInicio;
    problemasDeVozEnSuFamiliaController.text =
        hcState.createHcVoice.antecedentesMorbidos.problemasDeVozEnSuFamilia;
    lasEmocionesDananSuVozController.text =
        hcState.createHcVoice.antecedentesMorbidos.lasEmocionesDananSuVoz;
    medicamentosQueTomaController.text =
        hcState.createHcVoice.antecedentesMorbidos.medicamentosQueToma;
    accidentesOenfermedadesGravesQueHayaTenidoController.text = hcState
        .createHcVoice
        .antecedentesMorbidos
        .accidentesOenfermedadesGravesQueHayaTenido;
    haSidoIntervenidoQuirurgicamenteController.text = hcState
        .createHcVoice.antecedentesMorbidos.haSidoIntervenidoQuirurgicamente;
    haSidoEntubadoController.text =
        hcState.createHcVoice.antecedentesMorbidos.haSidoEntubado;
    haConsultadoConOtrosProfesionalesController.text = hcState
        .createHcVoice.antecedentesMorbidos.haConsultadoConOtrosProfesionales;
    cuantoTiempoController.text =
        hcState.createHcVoice.habitosGenerales.cuantoTiempo;
    horasDeSuenoController.text =
        hcState.createHcVoice.habitosGenerales.horasDeSueno.toString();
    horasDeTrabajoController.text = hcState
        .createHcVoice.usoLaboralProfesionalDeLaVoz.horasDeTrabajo
        .toString();
    posturaParaTrabajarController.text =
        hcState.createHcVoice.usoLaboralProfesionalDeLaVoz.posturaParaTrabajar;
    utilizaSuVozDeFormaProlongadaController.text = hcState.createHcVoice
        .usoLaboralProfesionalDeLaVoz.utilizaSuVozDeFormaProlongada;
    realizaReposoVocalController.text = hcState.createHcVoice
        .usoLaboralProfesionalDeLaVoz.realizaReposoVocalDuranteLaJornadaLaboral;
    ingieoLiquidosDuranteLaJornadaLaboralController.text = hcState.createHcVoice
        .usoLaboralProfesionalDeLaVoz.ingieroLiquidosDuranteLaJornadaLaboral;
    utilizaAmplificacionParaCantarController.text = hcState.createHcVoice
        .usoLaboralProfesionalDeLaVoz.utilizaAmplificacionParaCantar;
    asisteAClasesConProfesionalesDeLaVozController.text = hcState.createHcVoice
        .usoLaboralProfesionalDeLaVoz.asisteAClasesConProfesionalesDeLaVoz;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text(
          'Anamnesis de Voz',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            headerTRWidget(textoDinamico: 'ANAMNESIS DE VOZ'),
            const SizedBox(height: 20),
            Card(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: EdgeInsets.all(16.0),  // Removido const
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,  // Cambiado de Center a start
      children: [
        Text(  // Título agregado
          'Tipo de registro',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
        SizedBox(height: 12),  // Espaciado ajustado
        
        // RadioButtonGroup modificado para alineación horizontal
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'Nuevo',
                  groupValue: hcState.tipo,
                  onChanged: (value) => hcNotifier.onTipoChanged(value ?? 'Nuevo'),
                  activeColor: Color(0xFF1976D2),
                ),
                SizedBox(width: 4),
                Text('Nuevo'),
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Radio<String>(
                  value: 'Buscar',
                  groupValue: hcState.tipo,
                  onChanged: (value) => hcNotifier.onTipoChanged(value ?? 'Buscar'),
                  activeColor: Color(0xFF1976D2),
                ),
                SizedBox(width: 4),
                Text('Buscar'),
              ],
            ),
          ],
        ),

        SizedBox(height: 20),
        
        // Campo de búsqueda (igual al original)
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: cedulaController,
                onChanged: hcNotifier.onCedulaChanged,
                decoration: InputDecoration(
                  labelText: 'Buscar por cédula',
                  labelStyle: TextStyle(color: Color(0xFF1976D2)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF1976D2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF1976D2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xFF1976D2),
                      width: 2
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                if (hcState.tipo == 'Nuevo') {
                  hcNotifier.getPacienteByDni(hcState.cedula);
                } else {
                  hcNotifier.onSearchHcVoice(hcState.cedula);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Buscar'),
            ),
          ],
        ),
      ],
    ),
  ),
),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1.- Datos de identificación',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      disabled: true,
                      label: 'Nombres y apellidos',
                      controller: nombreCompletoController,
                      onChanged: hcNotifier.setNombreCompleto,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: true,
                      label: 'Fecha de nacimiento (dd/mm/aaaa)',
                      controller: fechaNacimientoController,
                      onChanged: hcNotifier.setFechaNacimiento,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroup(
                      title: 'Estado civil',
                      options: ['Soltero', 'Casado', 'Otro'],
                      selectedValue: hcState.createHcVoice.estadoCivil,
                      onChanged: hcNotifier.setEstadoCivil,
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Ocupación actual',
                      controller: ocupacionActualController,
                      onChanged: hcNotifier.setOcupacionActual,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'Dirección',
                      controller: direccionController,
                      onChanged: hcNotifier.setDireccion,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'Derivado por',
                      controller: derivadoPorController,
                      onChanged: hcNotifier.setDerivadoPor,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'Razón de derivación',
                      controller: razonDeDerivacionController,
                      onChanged: hcNotifier.setRazonDeDerivacion,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'Diagnóstico ORL',
                      controller: diagnosticoORLController,
                      onChanged: hcNotifier.setDiagnosticoORL,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'Teléfono de contacto',
                      controller: telefonoDeContactoController,
                      onChanged: hcNotifier.setTelefonoDeContacto,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'Fecha de evaluación',
                      controller: fechaDeEvaluacionController,
                      onChanged: hcNotifier.setFechaDeEvaluacion,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2.- Historia clínica',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Motivo de consulta',
                      controller: motivoDeConsultaController,
                      onChanged: hcNotifier.setHistoriaClinicaMotivoDeConsulta,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Es la primera vez que tiene esta dificultad?',
                      controller:
                          esLaPrimeraVezQueTieneEstaDificultadController,
                      onChanged: hcNotifier
                          .setHistoriaClinicaEsLaPrimeraVezQueTieneEstaDificultad,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Cuándo comenzó el problema?',
                      controller: desdeCuandoTieneEstaDificultadController,
                      onChanged: hcNotifier
                          .setHistoriaClinicaDesdeCuandoTieneEstaDificultad,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'Forma de inicio',
                      controller: formaDeInicioController,
                      onChanged: hcNotifier.setHistoriaClinicaFormaDeInicio,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿A qué lo atribuye?',
                      controller: aQueLoAtribuyeController,
                      onChanged: hcNotifier.setHistoriaClinicaAQueLoAtribuye,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Cómo lo afecta?',
                      controller: comoLoAfectaController,
                      onChanged: hcNotifier.setHistoriaClinicaComoLoAfecta,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Cuándo se agrava?',
                      controller: cuandoSeAgravaController,
                      onChanged: hcNotifier.setHistoriaClinicaCuandoSeAgrava,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Como ha sido su evolución?',
                      controller: comoHaSidoSuEvolucionController,
                      onChanged:
                          hcNotifier.setHistoriaClinicaComoHaSidoSuEvolucion,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'Momento del dia con mayor dificultad',
                      controller: momentoDelDiaConMayorDificultadController,
                      onChanged: hcNotifier
                          .setHistoriaClinicaMomentoDelDiaConMayorDificultad,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿En qué situaciones aparecen molestias?',
                      controller: enQueSituacionesAparecenMolestiasController,
                      onChanged: hcNotifier
                          .setHistoriaClinicaEnQueSituacionesAparecenMolestias,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3.- Sintomatología',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroup(
                      title: 'Fonestenia',
                      options: ['SI', 'NO', 'Leve', 'Moderado', 'Severo'],
                      selectedValue:
                          hcState.createHcVoice.sintomologia.fonastenia,
                      onChanged: hcNotifier.setSintomologiaFonastenia,
                    ),
                    _buildRadioButtonGroup(
                      title: 'Fonalgia (dolor al hablar)',
                      options: ['SI', 'NO', 'Leve', 'Moderado', 'Severo'],
                      selectedValue:
                          hcState.createHcVoice.sintomologia.fonalgia,
                      onChanged: hcNotifier.setSintomologiaFonalgia,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Tensión en fonación',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.sintomologia.tensionEnFonacion,
                      onChanged: hcNotifier.setSintomologiaTensionEnFonacion,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Sensación de constricción en el cuello',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.sintomologia
                          .sensacionDeConstriccionEnElCuello,
                      onChanged: hcNotifier
                          .setSintomologiaSensacionDeConstriccionEnElCuello,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Sensación de cuerpo extraño',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice.sintomologia.sensacionDeCuerpoExtrano,
                      onChanged:
                          hcNotifier.setSintomologiaSensacionDeCuerpoExtrano,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Descarga posterior',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.sintomologia.descargaPosterior,
                      onChanged: hcNotifier.setSintomologiaDescargaPosterior,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Odinofagia',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.sintomologia.odinofagia,
                      onChanged: hcNotifier.setSintomologiaOdinofagia,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Extensión tonal reducida',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice.sintomologia.extensionTonalReducida,
                      onChanged:
                          hcNotifier.setSintomologiaExtensionTonalReducida,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Picor laríngeo',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.sintomologia.picorLaringeo,
                      onChanged: hcNotifier.setSintomologiaPicorLaringeo,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '4.- Antecedentes mórbidos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("     En relación a ciertas enfermedades:"),
                    _buildFormField(
                      label: 'Existen problemas de voz en su familia ¿Cuáles?',
                      controller: problemasDeVozEnSuFamiliaController,
                      onChanged: hcNotifier
                          .setAntecedentesMorbidosProblemasDeVozEnSuFamilia,
                    ),
                    _buildRadioButtonGroup(
                      title: '¿Presenta alguna enfermedad?',
                      options: [
                        'Respiratoria',
                        'Auditiva',
                        'Digestiva',
                        'Psicológica'
                      ],
                      selectedValue: hcState.createHcVoice.antecedentesMorbidos
                          .presentaAlgunaEnfermedad,
                      onChanged: hcNotifier
                          .setAntecedentesMorbidosPresentaAlgunaEnfermedad,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Sufre de estrés?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice.antecedentesMorbidos.sufreDeEstres,
                      onChanged:
                          hcNotifier.setAntecedentesMorbidosSufreDeEstres,
                    ),
                    _buildFormField(
                      label: '¿Las emociones dañan su voz?',
                      controller: lasEmocionesDananSuVozController,
                      onChanged: hcNotifier
                          .setAntecedentesMorbidosLasEmocionesDananSuVoz,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Utiliza algún medicamento? ¿Cuáles?',
                      controller: medicamentosQueTomaController,
                      onChanged:
                          hcNotifier.setAntecedentesMorbidosMedicamentosQueToma,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label:
                          '¿Ha sufrido accidentes, enfermedades graves, hospitalizaciones, etc?',
                      controller:
                          accidentesOenfermedadesGravesQueHayaTenidoController,
                      onChanged: hcNotifier
                          .setAntecedentesMorbidosAccidentesOenfermedadesGravesQueHayaTenido,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Ha sido intervenido quirúrgicamente?¿Por qué?',
                      controller: haSidoIntervenidoQuirurgicamenteController,
                      onChanged: hcNotifier
                          .setAntecedentesMorbidosHaSidoIntervenidoQuirurgicamente,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Ha sido entubado?¿Por cuánto tiempo?',
                      controller: haSidoEntubadoController,
                      onChanged:
                          hcNotifier.setAntecedentesMorbidosHaSidoEntubado,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Ha consultado con otros profesionales?',
                      controller: haConsultadoConOtrosProfesionalesController,
                      onChanged: hcNotifier
                          .setAntecedentesMorbidosHaConsultadoConOtrosProfesionales,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '5.- Antecedentes terapéuticos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          '¿Ha recibido tratamiento médico por problemas de la voz?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice
                          .antecedentesTerapeuticos
                          .haRecibidoTratamientoMedicoPorProblemasDeLaVoz,
                      onChanged: hcNotifier
                          .setAntecedentesTerapeuticosHaRecibidoTratamientoMedicoPorProblemasDeLaVoz,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Se ha realizado exámenes?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice
                          .antecedentesTerapeuticos.seHaRealizadoExamenes,
                      onChanged: hcNotifier
                          .setAntecedentesTerapeuticosSeHaRealizadoExamenes,
                    ),
                    _buildRadioButtonGroupBool(
                      title:
                          '¿Ha recibido tratamiento fonoaudiológico por problemas de voz?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice
                          .antecedentesTerapeuticos
                          .haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz,
                      onChanged: hcNotifier
                          .setAntecedentesTerapeuticosHaRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Ha recibido técnica vocal?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice
                          .antecedentesTerapeuticos.haRecibidoTecnicaVocal,
                      onChanged: hcNotifier
                          .setAntecedentesTerapeuticosHaRecibidoTecnicaVocal,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Aplica la técnica vocal?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice
                          .antecedentesTerapeuticos.aplicaLaTecnicaVocal,
                      onChanged: hcNotifier
                          .setAntecedentesTerapeuticosAplicaLaTecnicaVocal,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '6.- Abuso vocal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: 'Tose en exceso',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.abusoVocal.toseEnExceso,
                      onChanged: hcNotifier.setAbusoVocalToseEnExceso,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Grita en exceso',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.abusoVocal.gritaEnExceso,
                      onChanged: hcNotifier.setAbusoVocalGritaEnExceso,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Habla mucho',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.abusoVocal.hablaMucho,
                      onChanged: hcNotifier.setAbusoVocalHablaMucho,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Habla rápido',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.abusoVocal.hablaRapido,
                      onChanged: hcNotifier.setAbusoVocalHablaRapido,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Imita voces',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.abusoVocal.imitaVoces,
                      onChanged: hcNotifier.setAbusoVocalImitaVoces,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Habla con exceso de ruido',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice.abusoVocal.hablaConExcesoDeRuido,
                      onChanged: hcNotifier.setAbusoVocalHablaConExcesoDeRuido,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Reduce el uso de la voz en resfríos?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.abusoVocal
                          .reduceElUsoDeLaVozEnResfrios,
                      onChanged:
                          hcNotifier.setAbusoVocalReduceElUsoDeLaVozEnResfrios,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Carraspea en exceso',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.abusoVocal.carraspeaEnExceso,
                      onChanged: hcNotifier.setAbusoVocalCarraspeaEnExceso,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Habla forzando la voz?',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.abusoVocal.hablaForzandoLaVoz,
                      onChanged: hcNotifier.setAbusoVocalHablaForzandoLaVoz,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Habla al mismo tiempo que otras personas?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.abusoVocal
                          .hablaAlMismoTiempoQueOtrasPersonas,
                      onChanged: hcNotifier
                          .setAbusoVocalHablaAlMismoTiempoQueOtrasPersonas,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Habla con dientes, hombro y cuello apretado?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.abusoVocal
                          .hablaConDientesHombroYCuelloApretados,
                      onChanged: hcNotifier
                          .setAbusoVocalHablaConDientesHombroYCuelloApretados,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '7.- Mal uso vocal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          'Trata de hablar con un tono más agudo o grave que el suyo',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.malUsoVocal
                          .trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo,
                      onChanged: hcNotifier
                          .setMalUsoVocalTrataDeHablarConUnTonoMasAgudoOGraveQueElSuyo,
                    ),
                    _buildRadioButtonGroupBool(
                      title:
                          'Trata de hablar con un volumen de voz más débil o alto de lo usual',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.malUsoVocal
                          .trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual,
                      onChanged: hcNotifier
                          .setMalUsoVocalTrataDeHablarConUnVolumenMasDebilOAltoDeLoUsual,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Canta fuera de registro',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice.malUsoVocal.cantaFueraDeSuRegistro,
                      onChanged:
                          hcNotifier.setMalUsoVocalCantaFueraDeSuRegistro,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Canta sin vocalizar',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.malUsoVocal.cantaSinVocalizar,
                      onChanged: hcNotifier.setMalUsoVocalCantaSinVocalizar,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '8.- Factores externos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: 'Vive en ambiente de fumadores',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.factoresExternos
                          .viveEnAmbienteDeFumadores,
                      onChanged: hcNotifier
                          .setFactoresExternosViveEnAmbienteDeFumadores,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Trabaja en un ambiente ruidoso',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.factoresExternos
                          .trabajaEnAmbienteRuidoso,
                      onChanged: hcNotifier
                          .setFactoresExternosTrabajaEnAmbienteRuidoso,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Permanece en ambiente con aire acondicionado',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.factoresExternos
                          .permaneceEnAmbientesConAireAcondicionado,
                      onChanged: hcNotifier
                          .setFactoresExternosPermaneceEnAmbientesConAireAcondicionado,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Permanece en ambientes con poca ventilación',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.factoresExternos
                          .permaneceEnAmbientesConPocaVentilacion,
                      onChanged: hcNotifier
                          .setFactoresExternosPermaneceEnAmbientesConPocaVentilacion,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Se expone a cambios bruscos de temperatura',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.factoresExternos
                          .seExponeACambiosBruscosDeTemperatura,
                      onChanged: hcNotifier
                          .setFactoresExternosSeExponeACambiosBruscosDeTemperatura,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '9.- Hábitos generales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: 'Realiza reposo vocal',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice.habitosGenerales.realizaReposoVocal,
                      onChanged:
                          hcNotifier.setHabitosGeneralesRealizaReposoVocal,
                    ),
                    _buildFormField(
                      label: '¿Cuanto tiempo?',
                      controller: cuantoTiempoController,
                      onChanged: hcNotifier.setHabitosGeneralesCuantoTiempo,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Habla mucho tiempo sin beber liquido',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.habitosGenerales
                          .hablaMuchoTiempoSinBebeLiquido,
                      onChanged: hcNotifier
                          .setHabitosGeneralesHablaMuchoTiempoSinBebeLiquido,
                    ),
                    _buildRadioButtonGroupBool(
                      title: '¿Asiste al otorrinolaringólogo?',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.habitosGenerales
                          .asisteAlOtorrinolaringologo,
                      onChanged: hcNotifier
                          .setHabitosGeneralesAsisteAlOtorrinolaringologo,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Consume alimentos muy condimentados',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.habitosGenerales
                          .consumeAlimentosMuyCondimentados,
                      onChanged: hcNotifier
                          .setHabitosGeneralesConsumeAlimentosMuyCondimentados,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Consume alimentos muy calientes o muy fríos',
                      options: ['SI', 'NO'],
                      selectedValue: hcState.createHcVoice.habitosGenerales
                          .consumeAlimentosMuyCalientesOMuyFrios,
                      onChanged: hcNotifier
                          .setHabitosGeneralesConsumeAlimentosMuyCalientesOMuyFrios,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Consume bebidas alcohólicas',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.habitosGenerales.consumeAlcohol,
                      onChanged: hcNotifier.setHabitosGeneralesConsumeAlcohol,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Fuma',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.habitosGenerales.consumeTabaco,
                      onChanged: hcNotifier.setHabitosGeneralesConsumeTabaco,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Consume café',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.habitosGenerales.consumeCafe,
                      onChanged: hcNotifier.setHabitosGeneralesConsumeCafe,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Consume drogas',
                      options: ['SI', 'NO'],
                      selectedValue:
                          hcState.createHcVoice.habitosGenerales.consumeDrogas,
                      onChanged: hcNotifier.setHabitosGeneralesConsumeDrogas,
                    ),
                    _buildRadioButtonGroupBool(
                      title: 'Utiliza ropa ajustada',
                      options: ['SI', 'NO'],
                      selectedValue: hcState
                          .createHcVoice.habitosGenerales.utilizaRopaAjustada,
                      onChanged:
                          hcNotifier.setHabitosGeneralesUtilizaRopaAjustada,
                    ),
                    _buildFormField(
                      label: '¿Cuántas horas duerme?',
                      controller: horasDeSuenoController,
                      onChanged: (value) => hcNotifier
                          .setHabitosGeneralesHorasDeSueno(int.parse(value)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '10.- Uso laboral y profesional de la voz',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: '¿Cuántas horas trabaja?',
                      controller: horasDeTrabajoController,
                      onChanged: (value) => hcNotifier
                          .setUsoLaboralProfesionalDeLaVozHorasDeTrabajo(
                              int.parse(value)),
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Cuál es su postura para trabajar?',
                      controller: posturaParaTrabajarController,
                      onChanged: hcNotifier
                          .setUsoLaboralProfesionalDeLaVozPosturaParaTrabajar,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label:
                          '¿Utiliza su voz de forma prolongada durante la jornada laboral?',
                      controller: utilizaSuVozDeFormaProlongadaController,
                      onChanged: hcNotifier
                          .setUsoLaboralProfesionalDeLaVozUtilizaSuVozDeFormaProlongada,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label:
                          '¿Realiza reposo vocal durante su jornada laboral?',
                      controller: realizaReposoVocalController,
                      onChanged: hcNotifier
                          .setUsoLaboralProfesionalDeLaVozRealizaReposoVocalDuranteLaJornadaLaboral,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Ingiere líquidos durante su trabajo?',
                      controller:
                          ingieoLiquidosDuranteLaJornadaLaboralController,
                      onChanged: hcNotifier
                          .setUsoLaboralProfesionalDeLaVozIngieroLiquidosDuranteLaJornadaLaboral,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Utiliza amplificación para cantar?',
                      controller: utilizaAmplificacionParaCantarController,
                      onChanged: hcNotifier
                          .setUsoLaboralProfesionalDeLaVozUtilizaAmplificacionParaCantar,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: '¿Asiste a clases con profesionales de la voz?',
                      controller:
                          asisteAClasesConProfesionalesDeLaVozController,
                      onChanged: hcNotifier
                          .setUsoLaboralProfesionalDeLaVozAsisteAClasesConProfesionalesDeLaVoz,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (hcState.tipo == 'Nuevo') {
            hcNotifier.onCreateHcGeneral(context);
          } else {
            hcNotifier.onUpdateHcVoice(context);
          }
        },
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.save),
      ),
    );
  }
}

Widget _buildSection(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1976D2),
      ),
    ),
  );
}

Widget _buildFormField({
  required String label,
  required TextEditingController controller,
  required Function(String) onChanged,
  bool disabled = false,
}) {
  return TextFormField(
    controller: controller,
    enabled: !disabled,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF1976D2)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1976D2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1976D2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    style: const TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
  );
}

// 🔹 Función para construir grupos de botones de radio
Widget _buildRadioButtonGroupBool({
  required String title,
  required List<String> options,
  required bool? selectedValue,
  required Function(bool) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xFF1976D2),
          ),
        ),
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 10.0,
        alignment: WrapAlignment.start,
        children: options.map((option) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<bool?>(
                value: option == "SI",
                groupValue: selectedValue,
                onChanged: (value) => onChanged(value as bool),
                activeColor: const Color(0xFF1976D2),
              ),
              Text(
                option,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    ],
  );
}

void _showSnackBar(BuildContext context, String message, bool isSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? Colors.green.shade300 : Colors.red.shade300,
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

Widget _buildRadioButtonGroup({
  required String title,
  required List<String> options,
  required String selectedValue,
  bool disabled = false,
  required Function(String) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xFF1976D2),
          ),
        ),
      ),
      Column(
        children: options.map((option) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                value: option,
                groupValue: selectedValue,
                onChanged: disabled
                    ? null
                    : (String? value) {
                        if (value != null) {
                          onChanged(value);
                        }
                      },
                activeColor: const Color(0xFF1976D2),
              ),
              Expanded(
                child: Text(
                  option,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    ],
  );
}
