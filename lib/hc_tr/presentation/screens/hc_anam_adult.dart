import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_adult_provider.dart';
import 'package:h_c_1/hc_tr/presentation/providers/state/hc_adult_state.dart';
import '/hc_tr/presentation/widgets/headerTR.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_provider.dart';

class HcTrAnamAdult extends ConsumerStatefulWidget {
  const HcTrAnamAdult({Key? key}) : super(key: key);

  @override
  _HcTrAnamAdultState createState() => _HcTrAnamAdultState();
}

class _HcTrAnamAdultState extends ConsumerState<HcTrAnamAdult> {
  late TextEditingController cedulaController;
  late TextEditingController fechaEntrevistaController;
  late TextEditingController nombreCompletoController;
  late TextEditingController quePreparaController;
  late TextEditingController quePorcionConsumeController;
  late TextEditingController cuantoPesoHaPerdidoController;
  late TextEditingController queTipoDeAlimentoController;
  late TextEditingController queTipoDeLiquidoConsumeHabitualmenteController;
  late TextEditingController cuantoLiquidoConsumeAlDiaController;
  late TextEditingController conQueFrecuenciaController;
  late TextEditingController conQueFrecuenciaPresentoNeumoniaController;
  late TextEditingController conQueAlimentosLiquidosMedicamentosController;
  late TextEditingController cuantoTiempoController;
  late TextEditingController queOtraActividadController;
  late TextEditingController porQueNoCuentaConTodasSusPiezasDentalesController;
  late TextEditingController conQueFrecuenciaSeLavaLosDientesController;
  late TextEditingController conQueFrecuenciaAsisteAControlesDentalesController;
  late TextEditingController queMolestiaODolorController;

  @override
  void initState() {
    super.initState();
    cedulaController = TextEditingController();
    fechaEntrevistaController = TextEditingController();
    nombreCompletoController = TextEditingController();
    quePreparaController = TextEditingController();
    quePorcionConsumeController = TextEditingController();
    cuantoPesoHaPerdidoController = TextEditingController();
    queTipoDeAlimentoController = TextEditingController();
    queTipoDeLiquidoConsumeHabitualmenteController = TextEditingController();
    cuantoLiquidoConsumeAlDiaController = TextEditingController();
    conQueFrecuenciaController = TextEditingController();
    conQueFrecuenciaPresentoNeumoniaController = TextEditingController();
    conQueAlimentosLiquidosMedicamentosController = TextEditingController();
    cuantoTiempoController = TextEditingController();
    queOtraActividadController = TextEditingController();
    porQueNoCuentaConTodasSusPiezasDentalesController = TextEditingController();
    conQueFrecuenciaSeLavaLosDientesController = TextEditingController();
    conQueFrecuenciaAsisteAControlesDentalesController =
        TextEditingController();
    queMolestiaODolorController = TextEditingController();
  }

  @override
  void dispose() {
    cedulaController.dispose();
    fechaEntrevistaController.dispose();
    nombreCompletoController.dispose();
    quePreparaController.dispose();
    quePorcionConsumeController.dispose();
    cuantoPesoHaPerdidoController.dispose();
    queTipoDeAlimentoController.dispose();
    queTipoDeLiquidoConsumeHabitualmenteController.dispose();
    cuantoLiquidoConsumeAlDiaController.dispose();
    conQueFrecuenciaController.dispose();
    conQueFrecuenciaPresentoNeumoniaController.dispose();
    conQueAlimentosLiquidosMedicamentosController.dispose();
    cuantoTiempoController.dispose();
    queOtraActividadController.dispose();
    porQueNoCuentaConTodasSusPiezasDentalesController.dispose();
    conQueFrecuenciaSeLavaLosDientesController.dispose();
    conQueFrecuenciaAsisteAControlesDentalesController.dispose();
    queMolestiaODolorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcState = ref.watch(hcAdultFormProvider);
    final hcNotifier = ref.read(hcAdultFormProvider.notifier);

    ref.listen<HcAdultState?>(hcAdultFormProvider, (previous, next) {
      if (next!.successMessage.isNotEmpty) {
        _showSnackBar(context, next.successMessage, true);
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcAdultFormProvider.notifier).clearSuccessMessage();
        });
      } else if (next.errorMessage.isNotEmpty) {
        _showSnackBar(context, next.errorMessage, false);
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcAdultFormProvider.notifier).clearErrorMessage();
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

    final fechaEvaluacion = hcState.createHcAdult.fechaEvalucion;
    final fechaFormateada =
        fechaEvaluacion != null && fechaEvaluacion.isNotEmpty
            ? fechaEvaluacion.substring(0, 10) // Extraer solo la fecha
            : '';
    cedulaController.text = hcState.cedula;
    fechaEntrevistaController.text =
        fechaFormateada; // Usar la fecha formateada
    nombreCompletoController.text = hcState.createHcAdult.nombreCompleto!;
    quePreparaController.text =
        hcState.createHcAdult.independenciaAutonomia.quePrepara;
    quePorcionConsumeController.text =
        hcState.createHcAdult.eficiencia.quePorcionConsume;
    cuantoPesoHaPerdidoController.text =
        hcState.createHcAdult.eficiencia.cuantoPesoHaPerdido.toString();
    queTipoDeAlimentoController.text =
        hcState.createHcAdult.eficiencia.queTipoDeAlimento;
    queTipoDeLiquidoConsumeHabitualmenteController.text =
        hcState.createHcAdult.eficiencia.queTipoDeLiquidoConsumeHabitualmente;
    cuantoLiquidoConsumeAlDiaController.text =
        hcState.createHcAdult.eficiencia.cuantoLiquidoConsumeAlDia;
    conQueFrecuenciaController.text =
        hcState.createHcAdult.seguridad.conQueFrecuencia;
    conQueFrecuenciaPresentoNeumoniaController.text =
        hcState.createHcAdult.seguridad.conQueFrecuenciaPresentoNeumonia;
    conQueAlimentosLiquidosMedicamentosController.text =
        hcState.createHcAdult.seguridad.conQueAlimentosLiquidosMedicamentos;
    cuantoTiempoController.text =
        hcState.createHcAdult.procesoDeAlimentacion.cuantoTiempo;
    queOtraActividadController.text =
        hcState.createHcAdult.procesoDeAlimentacion.queOtraActividad;
    conQueFrecuenciaSeLavaLosDientesController.text =
        hcState.createHcAdult.saludBocal.conQueFrecuenciaSeLavaLosDientes;
    conQueFrecuenciaAsisteAControlesDentalesController.text = hcState
        .createHcAdult.saludBocal.conQueFrecuenciaAsisteAControlesDentales;
    queMolestiaODolorController.text =
        hcState.createHcAdult.saludBocal.queMolestiaODolor;
    porQueNoCuentaConTodasSusPiezasDentalesController.text = hcState
        .createHcAdult.saludBocal.porQueNoCuentaConTodasSusPiezasDentales;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text(
          'Anamnesis Alimentaria Adultos',
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
            headerTRWidget(textoDinamico: 'ANAMNESIS ALIMENTARIA ADULTOS'),
            const SizedBox(height: 20),
            Card(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: EdgeInsets.all(16.0),  // Removido const aquí
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(  // Removido const aquí
          'Tipo de registro',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
        ),
        ),
        SizedBox(height: 12),  // Removido const aquí
        
        // Radio buttons
        Row(
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'Nuevo',
                  groupValue: hcState.tipo,
                  onChanged: (value) => hcNotifier.onTipoChanged(value ?? 'Nuevo'),
                  activeColor: Color(0xFF1976D2),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                SizedBox(width: 4),  // Removido const aquí
                Text('Nuevo'),  // Removido const aquí
              ],
            ),
            SizedBox(width: 20),  // Removido const aquí
            Row(
              children: [
                Radio<String>(
                  value: 'Buscar',
                  groupValue: hcState.tipo,
                  onChanged: (value) => hcNotifier.onTipoChanged(value ?? 'Buscar'),
                  activeColor: Color(0xFF1976D2),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                SizedBox(width: 4),  // Removido const aquí
                Text('Buscar'),  // Removido const aquí
              ],
            ),
          ],
        ),

        SizedBox(height: 20),  // Removido const aquí
        
        // Campo de búsqueda
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
            SizedBox(width: 10),  // Removido const aquí
            ElevatedButton(
              onPressed: () {
                if (hcState.tipo == 'Nuevo') {
                  hcNotifier.getPacienteByDni(hcState.cedula);
                } else {
                  hcNotifier.onSearchHcAdult(hcState.cedula);
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
              child: Text('Buscar'),  // Removido const aquí
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
                      '1.- Antecedentes personales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      disabled: true,
                      controller: nombreCompletoController,
                      label: 'Nombre completo',
                      onChanged: hcNotifier.setNombreCompleto,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: true,
                      label: 'Fecha de evaluación (dd/mm/aaaa)',
                      controller: fechaEntrevistaController,
                      onChanged: hcNotifier.setFechaEvaluacion,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroup(
                      disabled: hcState.status == 'Editado' ? true : false,
                      title: "Lateralidad:",
                      options: ["Diestro", "Zurdo", "Ambidiestro"],
                      selectedValue: hcState.createHcAdult.lateralidad ?? '',
                      onChanged: hcNotifier.setLateralidad,
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
                      '2.- Independencia y autonomía',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroup(
                      title: "¿Se alimenta solo(a) o necesita ayuda?",
                      options: [
                        "Solo(a)",
                        "Con ayuda parcial",
                        "Con ayuda total"
                      ],
                      selectedValue: hcState.createHcAdult
                          .independenciaAutonomia.seAlimentaSoloOConAyuda,
                      onChanged: hcNotifier.setIndepSeAlimentaSoloOConAyuda,
                    ),
                    const SizedBox(height: 12),
                    _buildRadioButtonGroup(
                      title: "¿Qué tipo de ayuda necesita?",
                      options: [
                        "Para identificar qué está comiendo",
                        "Para llevarse la comida a la boca/evitar derrames",
                        "Ninguna"
                      ],
                      selectedValue: hcState.createHcAdult
                          .independenciaAutonomia.queTipoDeAyudaNecesita,
                      onChanged: hcNotifier.setIndepQueTipoDeAyudaNecesita,
                    ),
                    const SizedBox(height: 12),
                    _buildRadioButtonGroupBool(
                      title: "¿Prepara sus propios alimentos?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult
                          .independenciaAutonomia.preparaSusAlimentos,
                      onChanged: hcNotifier.setIndepPreparaSusAlimentos,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Por Qué?",
                      controller: quePreparaController,
                      onChanged: hcNotifier.setIndepQuePrepara,
                    ),
                    const SizedBox(height: 12),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Decide qué alimentos desea consumir o participar en estas decisiones en el hogar?",
                      options: ["SI", "NO"],
                      selectedValue: hcState
                          .createHcAdult.independenciaAutonomia.decideQueComer,
                      onChanged: hcNotifier.setIndepDecideQueComer,
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
                      '3.- Eficiencia',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Consume la totalidad del alimento?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.eficiencia
                          .consumeLaTotalidadDeLosAlimentos,
                      onChanged: hcNotifier
                          .setEficienciaConsumeLaTotalidadDeLosAlimentos,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Qué porción consume?",
                      controller: quePorcionConsumeController,
                      onChanged: hcNotifier.setEficienciaQuePorcionConsume,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Ha presentado pérdidas de peso?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.eficiencia
                          .haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo,
                      onChanged: hcNotifier
                          .setEficienciaHaPresentadoPerdidasImportantesDePesoEnElUltimoTiempo,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Cuántos kilos?",
                      controller: cuantoPesoHaPerdidoController,
                      onChanged: (value) =>
                          hcNotifier.setEficienciaCuantoPesoHaPerdido(
                              double.tryParse(value) ?? 0),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Manifiesta interés por alimentarse?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.eficiencia
                          .manifiestaInteresPorAlimentarse,
                      onChanged: hcNotifier
                          .setEficienciaManifiestaInteresPorAlimentarse,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Manifiesta rechazo o preferencia por algún tipo de alimento?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.eficiencia
                          .manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento,
                      onChanged: hcNotifier
                          .setEficienciaManifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Cuál?",
                      controller: queTipoDeAlimentoController,
                      onChanged: hcNotifier.setEficienciaQueTipoDeAlimento,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Qué tipo de líquido consume habitualmente?",
                      controller:
                          queTipoDeLiquidoConsumeHabitualmenteController,
                      onChanged: hcNotifier
                          .setEficienciaQueTipoDeLiquidoConsumeHabitualmente,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Cuánto líquido consume al día?",
                      controller: cuantoLiquidoConsumeAlDiaController,
                      onChanged:
                          hcNotifier.setEficienciaCuantoLiquidoConsumeAlDia,
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
                      '4.- Seguridad',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Se atora con su saliva?",
                      options: ["SI", "NO"],
                      selectedValue:
                          hcState.createHcAdult.seguridad.seAtoraConSuSaliva,
                      onChanged: hcNotifier.setSeguridadSeAtoraConSuSaliva,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Con qué frecuencia?",
                      controller: conQueFrecuenciaController,
                      onChanged: hcNotifier.setSeguridadConQueFrecuencia,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Tiene tos o ahogos cuando se alimenta o consume sus medicamentos?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.seguridad
                          .tieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos,
                      onChanged: hcNotifier
                          .setSeguridadTieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Con qué alimento/liquido/medicamento?",
                      controller: conQueAlimentosLiquidosMedicamentosController,
                      onChanged: hcNotifier
                          .setSeguridadConQueAlimentosLiquidosMedicamentos,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Presenta alguna dificultad para tomar líquidos de un vaso?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.seguridad
                          .presentaAlgunaDificultadParaTomarLiquidosDeUnVaso,
                      onChanged: hcNotifier
                          .setSeguridadPresentaAlgunaDificultadParaTomarLiquidosDeUnVaso,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Presenta dificultad con las sopas o los granos pequeños como el arroz?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.seguridad
                          .presentaDificultadConSopasOLosGranosPequenosComoArroz,
                      onChanged: hcNotifier
                          .setSeguridadPresentaDificultadConSopasOLosGranosPequenosComoArroz,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Ha presentado neumonías?",
                      options: ["SI", "NO"],
                      selectedValue:
                          hcState.createHcAdult.seguridad.haPresentadoNeumonias,
                      onChanged: hcNotifier.setSeguridadHaPresentadoNeumonias,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Con qué frecuencia?",
                      controller: conQueFrecuenciaPresentoNeumoniaController,
                      onChanged: hcNotifier
                          .setSeguridadConQueFrecuenciaPresentoNeumonia,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Se queda con restos de alimento en la boca luego de alimentarse?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.seguridad
                          .seQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse,
                      onChanged: hcNotifier
                          .setSeguridadSeQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Siente que el alimento se va hacia su nariz?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.seguridad
                          .sienteQueElAlimentoSeVaHaciaSuNariz,
                      onChanged: hcNotifier
                          .setSeguridadSienteQueElAlimentoSeVaHaciaSuNariz,
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
                      '5.- Proceso de Alimentación',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Se demora más tiempo que el resto de la familia?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.procesoDeAlimentacion
                          .seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer,
                      onChanged: hcNotifier
                          .setProcesoDeAlimentacionSeDemoraMasTiempoQueElRestoDeLaFamiliaEnComer,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Cuánto?",
                      controller: cuantoTiempoController,
                      onChanged:
                          hcNotifier.setProcesoDeAlimentacionCuantoTiempo,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Cree usted que come muy rápido?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.procesoDeAlimentacion
                          .creeUstedQueComeMuyRapido,
                      onChanged: hcNotifier
                          .setProcesoDeAlimentacionCreeUstedQueComeMuyRapido,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Suele realizar alguna otra actividad mientras come?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.procesoDeAlimentacion
                          .sueleRealizarAlgunaOtraActividadMientrasCome,
                      onChanged: hcNotifier
                          .setProcesoDeAlimentacionSueleRealizarAlgunaOtraActividadMientrasCome,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Cuál(es)?",
                      controller: queOtraActividadController,
                      onChanged:
                          hcNotifier.setProcesoDeAlimentacionQueOtraActividad,
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
                      '6.- Salud Bucal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Cuenta con todas sus piezas dentarias/dientes?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.saludBocal
                          .cuentaConTodasSusPiezasDentales,
                      onChanged: hcNotifier
                          .setSaludBocalCuentaConTodasSusPiezasDentales,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Por qué?",
                      controller:
                          porQueNoCuentaConTodasSusPiezasDentalesController,
                      onChanged: hcNotifier
                          .setSaludBocalPorQueNoCuentaConTodasSusPiezasDentales,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Utiliza placa dental?",
                      options: ["SI", "NO"],
                      selectedValue:
                          hcState.createHcAdult.saludBocal.utilizaPlacaDental,
                      onChanged: hcNotifier.setSaludBocalUtilizaPlacaDental,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Se realiza aseo bucal después de cada comida?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.saludBocal
                          .seRealizaAseoBucalDespuesDeCadaComida,
                      onChanged: hcNotifier
                          .setSaludBocalSeRealizaAseoBucalDespuesDeCadaComida,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label:
                          "¿Con qué frecuencia se lava los dientes/lava su prótesis?",
                      controller: conQueFrecuenciaSeLavaLosDientesController,
                      onChanged: hcNotifier
                          .setSaludBocalConQueFrecuenciaSeLavaLosDientes,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title: "¿Asiste regularmente a controles dentales?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.saludBocal
                          .asisteRegularmenteAControlesDentales,
                      onChanged: hcNotifier
                          .setSaludBocalAsisteRegularmenteAControlesDentales,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Con qué frecuencia?",
                      controller:
                          conQueFrecuenciaAsisteAControlesDentalesController,
                      onChanged: hcNotifier
                          .setSaludBocalConQueFrecuenciaAsisteAControlesDentales,
                    ),
                    const SizedBox(height: 16),
                    _buildRadioButtonGroupBool(
                      title:
                          "¿Tiene alguna molestia o dolor dentro de su boca (dientes, encias, paladar, lengua)?",
                      options: ["SI", "NO"],
                      selectedValue: hcState.createHcAdult.saludBocal
                          .tieneAlgunaMolestiaODolorDentroDeSuBoca,
                      onChanged: hcNotifier
                          .setSaludBocalTieneAlgunaMolestiaODolorDentroDeSuBoca,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: "¿Cuál?",
                      controller: queMolestiaODolorController,
                      onChanged: hcNotifier.setSaludBocalQueMolestiaODolor,
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
            hcNotifier.onUpdateHcAdult(context);
          }
        },
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.save),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

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

  void _showSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isSuccess ? Colors.green.shade300 : Colors.red.shade300,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
