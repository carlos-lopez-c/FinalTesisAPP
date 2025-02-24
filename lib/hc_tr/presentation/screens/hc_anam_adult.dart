import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_adult_provider.dart';
import '/hc_tr/presentation/screens/search_hc_TR_AA.dart';
import '/hc_tr/presentation/widgets/NavigationButton.dart';
import '/hc_tr/presentation/widgets/headerTR.dart';

class HcTrAnamAdult extends ConsumerStatefulWidget {
  const HcTrAnamAdult({Key? key}) : super(key: key);

  @override
  _HcTrAnamAdultState createState() => _HcTrAnamAdultState();
}

class _HcTrAnamAdultState extends ConsumerState<HcTrAnamAdult> {
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

    final fechaEvaluacion = hcState.createHcAdult.fechaEvalucion;
    final fechaFormateada =
        fechaEvaluacion != null && fechaEvaluacion.isNotEmpty
            ? fechaEvaluacion.substring(0, 10) // Extraer solo la fecha
            : '';

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
      appBar: AppBar(
        title: const Text(
          'Área de Terapias - Anamnesis Adultos',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            headerTRWidget(textoDinamico: 'ANAMNESIS ALIMENTARIA ADULTOS'),
            const SizedBox(height: 20),
            Center(
                child: _buildRadioButtonGroup(
              title: '',
              options: ['Nuevo', 'Buscar'],
              selectedValue: hcState.tipo,
              onChanged: hcNotifier.onTipoChanged,
            )),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: hcNotifier.onCedulaChanged,
                    decoration:
                        const InputDecoration(labelText: 'Buscar por cédula'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (hcState.tipo == 'Nuevo') {
                      hcNotifier.getPacienteByDni(hcState.cedula);
                    } else {
                      hcNotifier.onSearchHcAdult(hcState.cedula);
                    }
                  },
                  child: const Text('Buscar'),
                ),
              ],
            ),
            _buildSection('1.- Antecedentes personales'),
            _buildFormField(
              controller: nombreCompletoController,
              label: 'Nombre completo',
              onChanged: hcNotifier.setNombreCompleto,
            ),
            _buildFormField(
              label: 'Fecha de evaluación (dd/mm/aaaa)',
              controller: fechaEntrevistaController,
              onChanged: hcNotifier.setFechaEvaluacion,
            ),
            Divider(),
            _buildRadioButtonGroup(
              title: "Lateralidad:",
              options: ["Diestro", "Zurdo", "Ambidiestro"],
              selectedValue: hcState.createHcAdult.lateralidad ?? '',
              onChanged: hcNotifier.setLateralidad,
            ),
            Divider(),
            _buildSection('2 .- Independencia y autonomía'),
            _buildRadioButtonGroup(
              title: "¿Se alimenta solo(a) o necesita ayuda?",
              options: ["Solo(a)", "Con ayuda parcial", "Con ayuda total"],
              selectedValue: hcState
                  .createHcAdult.independenciaAutonomia.seAlimentaSoloOConAyuda,
              onChanged: hcNotifier.setIndepSeAlimentaSoloOConAyuda,
            ),
            _buildRadioButtonGroup(
              title: "¿Qué tipo de ayuda necesita?",
              options: [
                "Para identificar qué está comiendo",
                "Para llevarse la comida a la boca/evitar derrames",
                "Ninguna"
              ],
              selectedValue: hcState
                  .createHcAdult.independenciaAutonomia.queTipoDeAyudaNecesita,
              onChanged: hcNotifier.setIndepQueTipoDeAyudaNecesita,
            ),
            _buildRadioButtonGroupBool(
              title: "¿Prepara sus propios alimentos?",
              options: ["SI", "NO"],
              selectedValue: hcState
                  .createHcAdult.independenciaAutonomia.preparaSusAlimentos,
              onChanged: hcNotifier.setIndepPreparaSusAlimentos,
            ),
            _buildFormField(
              label: "¿Por Qué?",
              controller: quePreparaController,
              onChanged: hcNotifier.setIndepQuePrepara,
            ),
            _buildRadioButtonGroupBool(
              title:
                  "¿Decide qué alimentos desea consumir o participar en estas decisiones en el hogar?",
              options: ["SI", "NO"],
              selectedValue:
                  hcState.createHcAdult.independenciaAutonomia.decideQueComer,
              onChanged: hcNotifier.setIndepDecideQueComer,
            ),
            Divider(),
            _buildSection('3 .- Eficiencia'),
            _buildRadioButtonGroupBool(
              title: "¿Consume la totalidad del alimento?",
              options: ["SI", "NO"],
              selectedValue: hcState
                  .createHcAdult.eficiencia.consumeLaTotalidadDeLosAlimentos,
              onChanged:
                  hcNotifier.setEficienciaConsumeLaTotalidadDeLosAlimentos,
            ),
            _buildFormField(
              label: "¿Qué porción consume?",
              controller: quePorcionConsumeController,
              onChanged: hcNotifier.setEficienciaQuePorcionConsume,
            ),
            _buildRadioButtonGroupBool(
              title: "¿Ha presentado pérdidas de peso?",
              options: ["SI", "NO"],
              selectedValue: hcState.createHcAdult.eficiencia
                  .haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo,
              onChanged: hcNotifier
                  .setEficienciaHaPresentadoPerdidasImportantesDePesoEnElUltimoTiempo,
            ),
            _buildFormField(
              label: "¿Cuántos kilos?",
              controller: cuantoPesoHaPerdidoController,
              onChanged: (value) => hcNotifier.setEficienciaCuantoPesoHaPerdido(
                  double.tryParse(value) ?? 0),
            ),
            _buildRadioButtonGroupBool(
              title: "¿Manifiesta interés por alimentarse?",
              options: ["SI", "NO"],
              selectedValue: hcState
                  .createHcAdult.eficiencia.manifiestaInteresPorAlimentarse,
              onChanged:
                  hcNotifier.setEficienciaManifiestaInteresPorAlimentarse,
            ),
            _buildRadioButtonGroupBool(
              title:
                  "¿Manifiesta rechazo o preferencia por algún tipo de alimento?",
              options: ["SI", "NO"],
              selectedValue: hcState.createHcAdult.eficiencia
                  .manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento,
              onChanged: hcNotifier
                  .setEficienciaManifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento,
            ),
            _buildFormField(
              label: "¿Cuál?",
              controller: queTipoDeAlimentoController,
              onChanged: hcNotifier.setEficienciaQueTipoDeAlimento,
            ),
            _buildFormField(
              label: "¿Qué tipo de líquido consume habitualmente?",
              controller: queTipoDeLiquidoConsumeHabitualmenteController,
              onChanged:
                  hcNotifier.setEficienciaQueTipoDeLiquidoConsumeHabitualmente,
            ),
            _buildFormField(
              label: "¿Cuánto líquido consume al día?",
              controller: cuantoLiquidoConsumeAlDiaController,
              onChanged: hcNotifier.setEficienciaCuantoLiquidoConsumeAlDia,
            ),
            Divider(),
            _buildSection('4 .- Seguridad'),
            _buildRadioButtonGroupBool(
              title: "¿Se atora con su saliva?",
              options: ["SI", "NO"],
              selectedValue: hcState.createHcAdult.seguridad.seAtoraConSuSaliva,
              onChanged: hcNotifier.setSeguridadSeAtoraConSuSaliva,
            ),
            _buildFormField(
              label: "¿Con qué frecuencia?",
              controller: conQueFrecuenciaController,
              onChanged: hcNotifier.setSeguridadConQueFrecuencia,
            ),
            _buildRadioButtonGroupBool(
              title:
                  "¿Tiene tos o ahogos cuando se alimenta o consume sus medicamentos?",
              options: ["SI", "NO"],
              selectedValue: hcState.createHcAdult.seguridad
                  .tieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos,
              onChanged: hcNotifier
                  .setSeguridadTieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos,
            ),
            _buildFormField(
              label: "¿Con qué alimento/liquido/medicamento?",
              controller: conQueAlimentosLiquidosMedicamentosController,
              onChanged:
                  hcNotifier.setSeguridadConQueAlimentosLiquidosMedicamentos,
            ),
            _buildRadioButtonGroupBool(
                title:
                    "¿Presenta alguna dificultad para tomar líquidos de un vaso?",
                options: ["SI", "NO"],
                selectedValue: hcState.createHcAdult.seguridad
                    .presentaAlgunaDificultadParaTomarLiquidosDeUnVaso,
                onChanged: hcNotifier
                    .setSeguridadPresentaAlgunaDificultadParaTomarLiquidosDeUnVaso),
            _buildRadioButtonGroupBool(
                title:
                    "¿Presenta dificultad con las sopas o los granos pequeños como el arroz?",
                options: ["SI", "NO"],
                selectedValue: hcState.createHcAdult.seguridad
                    .presentaDificultadConSopasOLosGranosPequenosComoArroz,
                onChanged: hcNotifier
                    .setSeguridadPresentaDificultadConSopasOLosGranosPequenosComoArroz),
            _buildRadioButtonGroupBool(
                title: "¿Ha presentado neumonías?",
                options: ["SI", "NO"],
                selectedValue:
                    hcState.createHcAdult.seguridad.haPresentadoNeumonias,
                onChanged: hcNotifier.setSeguridadHaPresentadoNeumonias),
            _buildFormField(
              label: "¿Con qué frecuencia?",
              controller: conQueFrecuenciaPresentoNeumoniaController,
              onChanged: hcNotifier.setSeguridadConQueFrecuencia,
            ),
            _buildRadioButtonGroupBool(
                title:
                    "¿Se queda con restos de alimento en la boca luego de alimentarse?",
                options: ["SI", "NO"],
                selectedValue: hcState.createHcAdult.seguridad
                    .seQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse,
                onChanged: hcNotifier
                    .setSeguridadSeQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse),
            _buildRadioButtonGroupBool(
                title: "¿Siente que el alimento se va hacia su nariz?",
                options: ["SI", "NO"],
                selectedValue: hcState.createHcAdult.seguridad
                    .sienteQueElAlimentoSeVaHaciaSuNariz,
                onChanged:
                    hcNotifier.setSeguridadSienteQueElAlimentoSeVaHaciaSuNariz),
            Divider(),
            _buildSection('5 .- Proceso de Alimentación'),
            _buildRadioButtonGroupBool(
                title: "¿Se demora más tiempo que el resto de la familia?",
                options: ["SI", "NO"],
                selectedValue: hcState.createHcAdult.procesoDeAlimentacion
                    .seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer,
                onChanged: hcNotifier
                    .setProcesoDeAlimentacionSeDemoraMasTiempoQueElRestoDeLaFamiliaEnComer),
            _buildFormField(
                label: "¿Cuánto?",
                controller: cuantoTiempoController,
                onChanged: hcNotifier.setProcesoDeAlimentacionCuantoTiempo),
            _buildRadioButtonGroupBool(
              title: "¿Cree usted que come muy rápido?",
              options: ["SI", "NO"],
              selectedValue: hcState.createHcAdult.procesoDeAlimentacion
                  .creeUstedQueComeMuyRapido,
              onChanged:
                  hcNotifier.setProcesoDeAlimentacionCreeUstedQueComeMuyRapido,
            ),
            _buildRadioButtonGroupBool(
                title: "¿Suele realizar alguna otra actividad mientras come?",
                options: ["SI", "NO"],
                selectedValue: hcState.createHcAdult.procesoDeAlimentacion
                    .sueleRealizarAlgunaOtraActividadMientrasCome,
                onChanged: hcNotifier
                    .setProcesoDeAlimentacionSueleRealizarAlgunaOtraActividadMientrasCome),
            _buildFormField(
              label: "¿Cuál(es)?",
              controller: queOtraActividadController,
              onChanged: hcNotifier.setProcesoDeAlimentacionQueOtraActividad,
            ),
            Divider(),
            _buildSection('6 .- Salud Bucal'),
            _buildRadioButtonGroupBool(
              title: "¿Cuenta con todas sus piezas dentarias/dientes?",
              options: ["SI", "NO"],
              selectedValue: hcState
                  .createHcAdult.saludBocal.cuentaConTodasSusPiezasDentales,
              onChanged:
                  hcNotifier.setSaludBocalCuentaConTodasSusPiezasDentales,
            ),
            _buildFormField(
              label: "¿Por qué?",
              controller: porQueNoCuentaConTodasSusPiezasDentalesController,
              onChanged: hcNotifier
                  .setSaludBocalPorQueNoCuentaConTodasSusPiezasDentales,
            ),
            _buildRadioButtonGroupBool(
              title: "¿Utiliza placa dental?",
              options: ["SI", "NO"],
              selectedValue:
                  hcState.createHcAdult.saludBocal.utilizaPlacaDental,
              onChanged: hcNotifier.setSaludBocalUtilizaPlacaDental,
            ),
            _buildRadioButtonGroupBool(
              title: "¿Se realiza aseo bucal después de cada comida?",
              options: ["SI", "NO"],
              selectedValue: hcState.createHcAdult.saludBocal
                  .seRealizaAseoBucalDespuesDeCadaComida,
              onChanged:
                  hcNotifier.setSaludBocalSeRealizaAseoBucalDespuesDeCadaComida,
            ),
            _buildFormField(
              label:
                  "¿Con qué frecuencia se lava los dientes/lava su prótesis?",
              controller: conQueFrecuenciaSeLavaLosDientesController,
              onChanged:
                  hcNotifier.setSaludBocalConQueFrecuenciaSeLavaLosDientes,
            ),
            _buildRadioButtonGroupBool(
              title: "¿Asiste regularmente a controles dentales?",
              options: ["SI", "NO"],
              selectedValue: hcState.createHcAdult.saludBocal
                  .asisteRegularmenteAControlesDentales,
              onChanged:
                  hcNotifier.setSaludBocalAsisteRegularmenteAControlesDentales,
            ),
            _buildFormField(
              label: "¿Con qué frecuencia?",
              controller: conQueFrecuenciaAsisteAControlesDentalesController,
              onChanged: hcNotifier
                  .setSaludBocalConQueFrecuenciaAsisteAControlesDentales,
            ),
            _buildRadioButtonGroupBool(
              title:
                  "¿Tiene alguna molestia o dolor dentro de su boca (dientes, encias, paladar, lengua)?",
              options: ["SI", "NO"],
              selectedValue: hcState.createHcAdult.saludBocal
                  .tieneAlgunaMolestiaODolorDentroDeSuBoca,
              onChanged: hcNotifier
                  .setSaludBocalTieneAlgunaMolestiaODolorDentroDeSuBoca,
            ),
            _buildFormField(
              label: "¿Cuál?",
              controller: queMolestiaODolorController,
              onChanged: hcNotifier.setSaludBocalQueMolestiaODolor,
            ),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          hcNotifier.onCreateHcGeneral();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  // 🔹 Función para construir una sección con título
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🔹 Función para construir campos de formulario con `onChanged`
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorStyle: const TextStyle(color: Colors.red),
        ),
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                Radio(
                  value: option == "SI",
                  groupValue: selectedValue,
                  onChanged: (value) => onChanged(value as bool),
                ),
                Text(option),
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
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                Radio(
                  value: option,
                  groupValue: selectedValue,
                  onChanged: (value) => onChanged(value as String),
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
