import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';

class HabitosPersonalesWidget extends ConsumerStatefulWidget {
  const HabitosPersonalesWidget({super.key});

  @override
  _HabitosPersonalesWidgetState createState() =>
      _HabitosPersonalesWidgetState();
}

class _HabitosPersonalesWidgetState
    extends ConsumerState<HabitosPersonalesWidget> {
  late TextEditingController aptitudesInteresesEscolaresController;
  late TextEditingController rendimientoGeneralEscolaridadController;
  late TextEditingController quienViveEnCasaController;

  @override
  void initState() {
    super.initState();
    aptitudesInteresesEscolaresController = TextEditingController();
    rendimientoGeneralEscolaridadController = TextEditingController();
    quienViveEnCasaController = TextEditingController();
  }

  @override
  void dispose() {
    aptitudesInteresesEscolaresController.dispose();
    rendimientoGeneralEscolaridadController.dispose();
    quienViveEnCasaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcState = ref.watch(hcGeneralProvider);
    final hcNotifier = ref.read(hcGeneralProvider.notifier);

    // Actualizar los controladores cuando el estado cambia
    aptitudesInteresesEscolaresController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .habitosPersonales
        .aptitudesEInteresesEscolares;
    rendimientoGeneralEscolaridadController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .habitosPersonales
        .rendimientoGeneralEscolaridad;
    quienViveEnCasaController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .habitosPersonales
        .quienViveEnCasa;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection('5.- HÁBITOS PERSONALES'),

        // 🔹 Reacción ante las dificultades
        _buildInlineCheckboxGroup(
          title: "Reacción ante las dificultades",
          options: [
            "Berrinches",
            "Insulta",
            "Llora",
            "Grita",
            "Agrede",
            "Se encierra",
            "Pide ayuda",
            "Pega a los padres"
          ],
          selectedValues: [
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.habitosPersonales.berrinches ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.habitosPersonales.insulta ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.habitosPersonales.llora ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.habitosPersonales.grita ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.habitosPersonales.agrede ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.habitosPersonales.seEncierra ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.habitosPersonales.pideAyuda ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.habitosPersonales.pegaALosPadres ??
                false,
          ],
          onChangedList: [
            hcNotifier.onHabitosPersonalesBerrinchesChanged,
            hcNotifier.onHabitosPersonalesInsultaChanged,
            hcNotifier.onHabitosPersonalesLloraChanged,
            hcNotifier.onHabitosPersonalesGritaChanged,
            hcNotifier.onHabitosPersonalesAgredeChanged,
            hcNotifier.onHabitosPersonalesSeEncierraChanged,
            hcNotifier.onHabitosPersonalesPideAyudaChanged,
            hcNotifier.onHabitosPersonalesPegaALosPadresChanged,
          ],
        ),
        const Divider(),

        // 🔹 Aptitudes e intereses escolares
        _buildSection('Aptitudes e intereses escolares'),
        _buildMultilineFormField(
          label: 'Describa...',
          controller: aptitudesInteresesEscolaresController,
          onChanged:
              hcNotifier.onHabitosPersonalesAptitudesInteresesEscolaresChanged,
        ),
        const Divider(),

        // 🔹 Rendimiento general en escolaridad
        _buildSection('Rendimiento general en escolaridad'),
        _buildMultilineFormField(
          label: 'Describa...',
          controller: rendimientoGeneralEscolaridadController,
          onChanged: hcNotifier
              .onHabitosPersonalesRendimientoGeneralEscolaridadChanged,
        ),
        const Divider(),

        // 🔹 Comportamiento general
        _buildInlineCheckboxGroup(
          title: "Comportamiento general",
          options: [
            "Agresivo",
            "Pasivo",
            "Destructor",
            "Social",
            "Hipercinético",
            "Empatía",
            "Intereses peculiares",
            "Interés por interacción"
          ],
          selectedValues: [
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .comportamientoGeneral
                    .agresivo ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .comportamientoGeneral
                    .pasivo ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .comportamientoGeneral
                    .destructor ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .comportamientoGeneral
                    .sociable ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .comportamientoGeneral
                    .hipercinetico ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .comportamientoGeneral
                    .empatia ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .comportamientoGeneral
                    .interesesPeculiares ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .comportamientoGeneral
                    .interesPorInteraccion ??
                false,
          ],
          onChangedList: [
            hcNotifier.onHabitosPersonalesComportamientoGeneralAgresivoChanged,
            hcNotifier.onHabitosPersonalesComportamientoGeneralPasivoChanged,
            hcNotifier
                .onHabitosPersonalesComportamientoGeneralDestructorChanged,
            hcNotifier.onHabitosPersonalesComportamientoGeneralSociableChanged,
            hcNotifier
                .onHabitosPersonalesComportamientoGeneralHipercineticoChanged,
            hcNotifier.onHabitosPersonalesComportamientoGeneralEmpatiaChanged,
            hcNotifier
                .onHabitosPersonalesComportamientoGeneralInteresesPeculiaresChanged,
            hcNotifier
                .onHabitosPersonalesComportamientoGeneralInteresPorInteraccionChanged,
          ],
        ),
        const Divider(),

        // 🔹 ¿Quién vive en la casa?
        _buildSection('¿Quién vive en la casa?'),
        _buildMultilineFormField(
          label: 'Describa quien vive en la casa',
          controller: quienViveEnCasaController,
          onChanged: hcNotifier.onHabitosPersonalesQuienViveEnCasaChanged,
        ),
        const Divider(),

        // 🔹 INTEGRACIÓN SENSORIAL
        _buildInlineCheckboxGroup(
          title: "Integración Sensorial",
          options: ["Vista", "Oído", "Tacto", "Gusto y Olfato"],
          selectedValues: [
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .integracionSensorial
                    .vista ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .integracionSensorial
                    .oido ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .integracionSensorial
                    .tacto ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .habitosPersonales
                    .integracionSensorial
                    .gustoYolfato ??
                false,
          ],
          onChangedList: [
            hcNotifier.onHabitosPersonalesIntegracionSensorialVistaChanged,
            hcNotifier.onHabitosPersonalesIntegracionSensorialOidoChanged,
            hcNotifier.onHabitosPersonalesIntegracionSensorialTactoChanged,
            hcNotifier
                .onHabitosPersonalesIntegracionSensorialGustoYolfatoChanged,
          ],
        ),
      ],
    );
  }

  // 🔹 Sección con título estilizado
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🔹 Campo de texto multilínea conectado al estado
  Widget _buildMultilineFormField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLines: 5, // Permite múltiples líneas para respuestas detalladas
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

  // 🔹 Grupo de checkboxes en línea
  Widget _buildInlineCheckboxGroup({
    required String title,
    required List<String> options,
    required List<bool> selectedValues,
    required List<Function(bool)> onChangedList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        Wrap(
          spacing: 10.0,
          children: List.generate(options.length, (index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: selectedValues[index],
                  onChanged: (value) {
                    if (value != null) {
                      onChangedList[index](value);
                    }
                  },
                ),
                Text(options[index]),
              ],
            );
          }),
        ),
      ],
    );
  }
}
