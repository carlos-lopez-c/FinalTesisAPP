import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';

class AntecedentesPostnatalesWidget extends ConsumerWidget {
  const AntecedentesPostnatalesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hcState = ref.watch(hcGeneralProvider);
    final hcNotifier = ref.read(hcGeneralProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection('4.3. ANTECEDENTES POSTNATALES'),

        // ✅ Alimentación
        _buildInlineCheckboxGroup(
          title: "Alimentación:",
          disabled: hcState.status == 'Editado' ? true : false,
          options: ["Materna", "Artificial", "Maticación"],
          selectedValues: [
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.alimentacion.materna ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.alimentacion.artificial ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.alimentacion.maticacion ??
                false,
          ],
          onChangedList: [
            hcNotifier.onAlimentacionMaternaChanged,
            hcNotifier.onAlimentacionArtificialChanged,
            hcNotifier.onAlimentacionMaticacionChanged,
          ],
        ),
        const Divider(),

        // ✅ Desarrollo Motor Grueso
        _buildInlineCheckboxGroup(
          disabled: hcState.status == 'Editado' ? true : false,
          title: "Desarrollo motor grueso:",
          options: [
            "Control céfalico",
            "Gateo",
            "Marcha",
            "Sedeestación",
            "Sincinesias",
            "Sube y baja gradas",
            "Rotación de pies",
          ],
          selectedValues: [
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .desarrolloMotorGrueso
                    .controlCefalico ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.desarrolloMotorGrueso.gateo ??
                false,
            hcState.createHcGeneral.antecedentesPerinatales
                    .antecedentesPostnatales.desarrolloMotorGrueso.marcha ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .desarrolloMotorGrueso
                    .sedestacion ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .desarrolloMotorGrueso
                    .sincinesias ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .desarrolloMotorGrueso
                    .subeBajaGradas ??
                false,
            hcState
                    .createHcGeneral
                    .antecedentesPerinatales
                    .antecedentesPostnatales
                    .desarrolloMotorGrueso
                    .rotacionPies ??
                false,
          ],
          onChangedList: [
            hcNotifier.onControlCefalicoChanged,
            hcNotifier.onGateoChanged,
            hcNotifier.onMarchaChanged,
            hcNotifier.onSedestacionChanged,
            hcNotifier.onSincinesiasChanged,
            hcNotifier.onSubeBajaGradasChanged,
            hcNotifier.onRotacionPiesChanged,
          ],
        ),
        const Divider(),

        // ✅ Sección de Reflejos Primitivos
        Center(child: _buildSection('REFLEJOS PRIMITIVOS')),
        Container(
          height: 3.0,
          width: 100.0,
          color: const Color.fromARGB(112, 75, 107, 176),
        ),

        _buildRadioButtonGroupBool(
          disabled: hcState.status == 'Editado' ? true : false,
          title: "Palmar - Plantar",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.reflejosPrimitivos.palmar,
          onChanged: hcNotifier.onPalmarChanged,
        ),
        _buildRadioButtonGroupBool(
            disabled: hcState.status == 'Editado' ? true : false,
            title: "Moro",
            options: ["SI", "NO"],
            selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos.moro,
            onChanged: (value) => hcNotifier.onMoroChanged(value)),
        _buildRadioButtonGroupBool(
            disabled: hcState.status == 'Editado' ? true : false,
            title: "Presión",
            options: ["SI", "NO"],
            selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos.presion,
            onChanged: hcNotifier.onPresionChanged),
        _buildRadioButtonGroupBool(
            disabled: hcState.status == 'Editado' ? true : false,
            title: "De búsqueda",
            options: ["SI", "NO"],
            selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos.deBusqueda,
            onChanged: (value) => hcNotifier.onDeBusquedaChanged(value)),
        _buildRadioButtonGroupBool(
            disabled: hcState.status == 'Editado' ? true : false,
            title: "Banbiski",
            options: ["SI", "NO"],
            selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos.banbiski,
            onChanged: (value) => hcNotifier.onBanbiskiChanged(value)),
      ],
    );
  }

  // 🔹 Sección con título estilizado
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
    );
  }

  // 🔹 Grupo de checkbox en línea
  Widget _buildInlineCheckboxGroup({
    bool disabled = false,
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
                  onChanged: disabled
                      ? null
                      : (value) {
                          onChangedList[index](value!);
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

  // 🔹 Grupo de botones de radio

  Widget _buildRadioButtonGroupBool({
    required String title,
    required List<String> options,
    bool disabled = false,
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
                  onChanged: disabled
                      ? null
                      : (value) {
                          onChanged(value);
                        }, // Cambiar a bool?
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
