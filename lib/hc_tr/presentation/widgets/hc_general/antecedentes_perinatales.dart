import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';

class AntecedentesPerinatalesWidget extends ConsumerStatefulWidget {
  const AntecedentesPerinatalesWidget({Key? key}) : super(key: key);

  @override
  _AntecedentesPerinatalesWidgetState createState() =>
      _AntecedentesPerinatalesWidgetState();
}

class _AntecedentesPerinatalesWidgetState
    extends ConsumerState<AntecedentesPerinatalesWidget> {
  late TextEditingController lugarDeAtencionController;
  late TextEditingController tiempoController;
  late TextEditingController pesoController;
  late TextEditingController tallaController;
  late TextEditingController perimetroCefalicoController;
  late TextEditingController apgarController;
  late TextEditingController observacionesAdicionalesController;

  @override
  void initState() {
    super.initState();
    lugarDeAtencionController = TextEditingController();
    tiempoController = TextEditingController();
    pesoController = TextEditingController();
    tallaController = TextEditingController();
    perimetroCefalicoController = TextEditingController();
    apgarController = TextEditingController();
    observacionesAdicionalesController = TextEditingController();
  }

  @override
  void dispose() {
    lugarDeAtencionController.dispose();
    tiempoController.dispose();
    pesoController.dispose();
    tallaController.dispose();
    perimetroCefalicoController.dispose();
    apgarController.dispose();
    observacionesAdicionalesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcState = ref.watch(hcGeneralProvider);
    final hcNotifier = ref.read(hcGeneralProvider.notifier);

    lugarDeAtencionController.text =
        hcState.createHcGeneral.antecedentesPerinatales.lugarDeAtencion;
    tiempoController.text =
        hcState.createHcGeneral.antecedentesPerinatales.alNacerNecesito.tiempo!;
    pesoController.text =
        hcState.createHcGeneral.antecedentesPerinatales.alNacerPresento.peso;
    tallaController.text =
        hcState.createHcGeneral.antecedentesPerinatales.alNacerPresento.talla;
    perimetroCefalicoController.text = hcState.createHcGeneral
        .antecedentesPerinatales.alNacerPresento.perimetroCefalico;
    apgarController.text =
        hcState.createHcGeneral.antecedentesPerinatales.alNacerPresento.apgar;
    observacionesAdicionalesController.text =
        hcState.createHcGeneral.antecedentesPerinatales.observaciones;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection('4.2. ANTECEDENTES PERINATALES'),
        _buildRadioButtonGroup(
          title: "Duración de la gestación:",
          options: ["Pre terminó", "A terminó", "Pos terminó"],
          selectedValue: hcState
              .createHcGeneral.antecedentesPerinatales.duracionDeLaGestacion,
          onChanged: hcNotifier.onDuracionDeLaGestacionChanged,
        ),
        _buildFormField(
          label: 'Lugar de atención',
          controller: lugarDeAtencionController,
          onChanged: hcNotifier.onLugarDeAtencionChanged,
        ),
        _buildRadioButtonGroup(
          title: "Tipo de parto:",
          options: ["Normal", "Fórceps", "Cesárea"],
          selectedValue:
              hcState.createHcGeneral.antecedentesPerinatales.tipoDeParto,
          onChanged: hcNotifier.onTipoDePartoChanged,
        ),
        const Divider(),
        _buildRadioButtonGroup(
          title: "Duración del parto:",
          options: ["Breve", "Normal", "Prolongado"],
          selectedValue:
              hcState.createHcGeneral.antecedentesPerinatales.duracionDelParto,
          onChanged: hcNotifier.onDuracionDelPartoChanged,
        ),
        const Divider(),
        _buildRadioButtonGroup(
          title: "Presentación:",
          options: ["Cefálico", "Podálico", "Transverso"],
          selectedValue:
              hcState.createHcGeneral.antecedentesPerinatales.presentacion,
          onChanged: hcNotifier.onPresentacionChanged,
        ),
        const Divider(),
        _buildRadioButtonGroupBool(
          title: 'Lloro al nacer',
          options: ['SI', 'NO'],
          selectedValue:
              hcState.createHcGeneral.antecedentesPerinatales.lloroAlNacer,
          onChanged: hcNotifier.onLloroAlNacerChanged,
        ),
        const Divider(),
        _buildRadioButtonGroupBool(
          title: 'Sufrimiento fetal',
          options: ['SI', 'NO'],
          selectedValue:
              hcState.createHcGeneral.antecedentesPerinatales.sufrimientoFetal,
          onChanged: hcNotifier.onSufrimientoFetalChanged,
        ),
        const Divider(),
        _buildMultipleCheckboxGroup(
          title: "Al nacer necesito:",
          options: {
            "Oxígeno": hcState.createHcGeneral.antecedentesPerinatales
                    .alNacerNecesito.oxigeno ??
                false,
            "Incubadora": hcState.createHcGeneral.antecedentesPerinatales
                    .alNacerNecesito.incubadora ??
                false,
          },
          onChanged: {
            "Oxígeno": hcNotifier.onAlNacerNecesitoOxigenoChanged,
            "Incubadora": hcNotifier.onAlNacerNecesitoIncubadoraChanged,
          },
        ),
        _buildFormField(
          label: 'Tiempo en incubadora u oxígeno',
          controller: tiempoController,
          onChanged: hcNotifier.onAlNacerNecesitoTiempoChanged,
        ),
        const Divider(),
        _buildMultipleCheckboxGroup(
          title: "Al nacer presentó:",
          options: {
            "Cianosis": hcState.createHcGeneral.antecedentesPerinatales
                    .alNacerPresento.cianosis ??
                false,
            "Ictericia": hcState.createHcGeneral.antecedentesPerinatales
                    .alNacerPresento.ictericia ??
                false,
            "Malformaciones": hcState.createHcGeneral.antecedentesPerinatales
                    .alNacerPresento.malformaciones ??
                false,
            "Circulación del cordón en el cuello": hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .alNacerPresento
                    .circulacionDelCordonEnElCuello ??
                false,
            "Sufrimiento fetal": hcState.createHcGeneral.antecedentesPerinatales
                    .alNacerPresento.sufrimientoFetal ??
                false,
          },
          onChanged: {
            "Cianosis": hcNotifier.onAlNacerPresentoCianosisChanged,
            "Ictericia": hcNotifier.onAlNacerPresentoIctericiaChanged,
            "Malformaciones": hcNotifier.onAlNacerPresentoMalformacionesChanged,
            "Circulación del cordón en el cuello": hcNotifier
                .onAlNacerPresentoCirculacionDelCordonEnElCuelloChanged,
            "Sufrimiento fetal":
                hcNotifier.onAlNacerPresentoSufrimientoFetalChanged,
          },
        ),
        _buildFormField(
          label: 'Peso al nacer',
          controller: pesoController,
          onChanged: hcNotifier.onAlNacerPresentoPesoChanged,
        ),
        _buildFormField(
          label: 'Talla al nacer',
          controller: tallaController,
          onChanged: hcNotifier.onAlNacerPresentoTallaChanged,
        ),
        _buildFormField(
          label: 'Perímetro cefálico',
          controller: perimetroCefalicoController,
          onChanged: hcNotifier.onAlNacerPresentoPerimetroCefalicoChanged,
        ),
        _buildFormField(
          label: 'Apgar',
          controller: apgarController,
          onChanged: hcNotifier.onAlNacerPresentoApgarChanged,
        ),
        const Divider(),
        _buildSection('Observaciones'),
        _buildMultilineFormField(
            label: 'Observaciones adicionales',
            controller: observacionesAdicionalesController,
            onChanged: hcNotifier.onObservacionesChanged),
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

  // 🔹 Campo de texto conectado al estado
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    bool? disabled = false,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        enabled: !disabled!,
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

  // 🔹 Grupo de opciones de radio conectado al estado
  Widget _buildRadioButtonGroup({
    required String title,
    required List<String> options,
    required String selectedValue, // ✅ Se cambia a String
    required Function(String) onChanged, // ✅ Se cambia a String
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
                Radio<String>(
                  value: option, // ✅ Ahora usa String
                  groupValue: selectedValue, // ✅ Compara con el valor actual
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value); // ✅ Devuelve el nuevo valor String
                    }
                  },
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRadioButtonGroupBool({
    required String title,
    required List<String> options,
    required bool? selectedValue, // Cambiar a bool?
    required Function(bool?) onChanged, // Cambiar a bool?
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
                Radio<bool?>(
                  value: option == "SI" ? true : false, // Convertir a bool
                  groupValue: selectedValue, // Puede ser null
                  onChanged: (bool? value) {
                    onChanged(
                        value); // Pasar el valor seleccionado (puede ser null)
                  },
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  // 🔹 Grupo de selección en línea
  Widget _buildMultipleCheckboxGroup({
    required String title,
    required Map<String, bool> options, // ✅ Cada opción tiene su propio valor
    required Map<String, Function(bool)>
        onChanged, // ✅ Cada opción tiene su propio onChanged
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        Column(
          children: options.entries.map((entry) {
            return CheckboxListTile(
              title: Text(entry.key),
              value: entry.value,
              onChanged: (bool? newValue) {
                if (newValue != null) {
                  onChanged[entry.key]!(newValue);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
