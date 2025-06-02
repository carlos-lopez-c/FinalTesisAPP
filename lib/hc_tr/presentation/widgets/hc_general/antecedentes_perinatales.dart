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

    return Card(
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
              '4.2. ANTECEDENTES PERINATALES',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 16),
            _buildRadioButtonGroup(
              disabled: hcState.status == 'Editado' ? true : false,
              title: "Duración de la gestación:",
              options: ["Pre terminó", "A terminó", "Pos terminó"],
              selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                  .duracionDeLaGestacion,
              onChanged: hcNotifier.onDuracionDeLaGestacionChanged,
            ),
            const SizedBox(height: 12),
            _buildFormField(
              label: 'Lugar de atención',
              disabled: hcState.status == 'Editado' ? true : false,
              controller: lugarDeAtencionController,
              onChanged: hcNotifier.onLugarDeAtencionChanged,
            ),
            const SizedBox(height: 12),
            _buildRadioButtonGroup(
              title: "Tipo de parto:",
              disabled: hcState.status == 'Editado' ? true : false,
              options: ["Normal", "Fórceps", "Cesárea"],
              selectedValue:
                  hcState.createHcGeneral.antecedentesPerinatales.tipoDeParto,
              onChanged: hcNotifier.onTipoDePartoChanged,
            ),
            const SizedBox(height: 12),
            _buildRadioButtonGroup(
              disabled: hcState.status == 'Editado' ? true : false,
              title: "Duración del parto:",
              options: ["Breve", "Normal", "Prolongado"],
              selectedValue: hcState
                  .createHcGeneral.antecedentesPerinatales.duracionDelParto,
              onChanged: hcNotifier.onDuracionDelPartoChanged,
            ),
            const SizedBox(height: 12),
            _buildRadioButtonGroup(
              disabled: hcState.status == 'Editado' ? true : false,
              title: "Presentación:",
              options: ["Cefálico", "Podálico", "Transverso"],
              selectedValue:
                  hcState.createHcGeneral.antecedentesPerinatales.presentacion,
              onChanged: hcNotifier.onPresentacionChanged,
            ),
            const SizedBox(height: 12),
            _buildRadioButtonGroupBool(
              disabled: hcState.status == 'Editado' ? true : false,
              title: 'Lloro al nacer',
              options: ['SI', 'NO'],
              selectedValue:
                  hcState.createHcGeneral.antecedentesPerinatales.lloroAlNacer,
              onChanged: hcNotifier.onLloroAlNacerChanged,
            ),
            const SizedBox(height: 12),
            _buildRadioButtonGroupBool(
              disabled: hcState.status == 'Editado' ? true : false,
              title: 'Sufrimiento fetal',
              options: ['SI', 'NO'],
              selectedValue: hcState
                  .createHcGeneral.antecedentesPerinatales.sufrimientoFetal,
              onChanged: hcNotifier.onSufrimientoFetalChanged,
            ),
            const SizedBox(height: 12),
            _buildMultipleCheckboxGroup(
              disabled: hcState.status == 'Editado' ? true : false,
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
            const SizedBox(height: 12),
            _buildFormField(
              disabled: hcState.status == 'Editado' ? true : false,
              label: 'Tiempo en incubadora u oxígeno',
              controller: tiempoController,
              onChanged: hcNotifier.onAlNacerNecesitoTiempoChanged,
            ),
            const SizedBox(height: 12),
            _buildMultipleCheckboxGroup(
              disabled: hcState.status == 'Editado' ? true : false,
              title: "Al nacer presentó:",
              options: {
                "Cianosis": hcState.createHcGeneral.antecedentesPerinatales
                        .alNacerPresento.cianosis ??
                    false,
                "Ictericia": hcState.createHcGeneral.antecedentesPerinatales
                        .alNacerPresento.ictericia ??
                    false,
                "Malformaciones": hcState
                        .createHcGeneral
                        .antecedentesPerinatales
                        .alNacerPresento
                        .malformaciones ??
                    false,
                "Circulación del cordón en el cuello": hcState
                        .createHcGeneral
                        .antecedentesPerinatales
                        .alNacerPresento
                        .circulacionDelCordonEnElCuello ??
                    false,
                "Sufrimiento fetal": hcState
                        .createHcGeneral
                        .antecedentesPerinatales
                        .alNacerPresento
                        .sufrimientoFetal ??
                    false,
              },
              onChanged: {
                "Cianosis": hcNotifier.onAlNacerPresentoCianosisChanged,
                "Ictericia": hcNotifier.onAlNacerPresentoIctericiaChanged,
                "Malformaciones":
                    hcNotifier.onAlNacerPresentoMalformacionesChanged,
                "Circulación del cordón en el cuello": hcNotifier
                    .onAlNacerPresentoCirculacionDelCordonEnElCuelloChanged,
                "Sufrimiento fetal":
                    hcNotifier.onAlNacerPresentoSufrimientoFetalChanged,
              },
            ),
            const SizedBox(height: 12),
            _buildFormField(
              disabled: hcState.status == 'Editado' ? true : false,
              label: 'Peso al nacer',
              controller: pesoController,
              onChanged: hcNotifier.onAlNacerPresentoPesoChanged,
            ),
            const SizedBox(height: 12),
            _buildFormField(
              disabled: hcState.status == 'Editado' ? true : false,
              label: 'Talla al nacer',
              controller: tallaController,
              onChanged: hcNotifier.onAlNacerPresentoTallaChanged,
            ),
            const SizedBox(height: 12),
            _buildFormField(
              disabled: hcState.status == 'Editado' ? true : false,
              label: 'Perímetro cefálico',
              controller: perimetroCefalicoController,
              onChanged: hcNotifier.onAlNacerPresentoPerimetroCefalicoChanged,
            ),
            const SizedBox(height: 12),
            _buildFormField(
              disabled: hcState.status == 'Editado' ? true : false,
              label: 'Apgar',
              controller: apgarController,
              onChanged: hcNotifier.onAlNacerPresentoApgarChanged,
            ),
            const SizedBox(height: 16),
            const Text(
              'Observaciones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 12),
            _buildMultilineFormField(
                label: 'Observaciones adicionales',
                controller: observacionesAdicionalesController,
                onChanged: hcNotifier.onObservacionesChanged),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    bool? disabled = false,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      enabled: !disabled!,
      controller: controller,
      onChanged: disabled ? null : onChanged,
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

  Widget _buildMultilineFormField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      maxLines: 5,
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

  Widget _buildRadioButtonGroup({
    required String title,
    bool disabled = false,
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

  Widget _buildRadioButtonGroupBool({
    required String title,
    bool disabled = false,
    required List<String> options,
    required bool? selectedValue,
    required Function(bool?) onChanged,
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
                  value: option == "SI" ? true : false,
                  groupValue: selectedValue,
                  onChanged: disabled
                      ? null
                      : (bool? value) {
                          onChanged(value);
                        },
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

  Widget _buildMultipleCheckboxGroup({
    required String title,
    bool disabled = false,
    required Map<String, bool> options,
    required Map<String, Function(bool)> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xFF1976D2),
          ),
        ),
        Column(
          children: options.entries.map((entry) {
            return CheckboxListTile(
              enabled: !disabled,
              title: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              value: entry.value,
              onChanged: (bool? newValue) {
                if (newValue != null) {
                  onChanged[entry.key]!(newValue);
                }
              },
              activeColor: const Color(0xFF1976D2),
              checkColor: Colors.white,
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ),
      ],
    );
  }
}
