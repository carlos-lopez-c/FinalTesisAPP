import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';
import 'package:h_c_1/hc_tr/presentation/providers/state/hc_general_state.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_general/antecedentes_perinatales.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_general/antecedentes_postnatales.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_general/antecedentes_prenatales.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_general/desarrollo_motor_fino.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_general/especificaciones.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_general/habitos_personales.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_general/informacion_general.dart';
import 'package:h_c_1/hc_tr/presentation/widgets/hc_general/motivo_consulta.dart';
import '/hc_tr/presentation/widgets/headerTR.dart';

class HcTrGeneral extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hcNotifier = ref.watch(hcGeneralProvider.notifier);
    final hcState = ref.watch(hcGeneralProvider);
    ref.listen<HcGeneralFormState?>(hcGeneralProvider, (previous, next) {
      if (next!.successMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage),
            backgroundColor: Colors.green.shade300,
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcGeneralProvider.notifier).clearSuccessMessage();
        });
      } else if (next.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red.shade300,
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcGeneralProvider.notifier).clearErrorMessage();
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Area de Terapias',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          headerTRWidget(
            textoDinamico: 'HISTORIA CLÍNICA GENERAL',
          ),
          const SizedBox(height: 20),
          Center(
              child: _buildRadioButtonGroup(
            title: '',
            options: ['Nuevo', 'Buscar'],
            selectedValue: hcState.tipo,
            onChanged: hcNotifier.onTipoChanged,
          )),
          DatosInformativosWidget(),
          Divider(),
          MotivoConsultaWidget(),
          Divider(),
          _buildSection('4.- ANTECEDENTES PERSONALES'),
          AntecedentesPrenatalesWidget(),
          AntecedentesPerinatalesWidget(),
          MaxlineSection('Obersevaciones.................................'),
          Divider(),
          AntecedentesPostnatalesWidget(),
          Divider(),
          DesarrolloMotorFino(),
          Divider(),
          EspecificacionesWidget(),
          Divider(),
          HabitosPersonalesWidget()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Enviar datos al servidor
          if (hcState.tipo == 'Nuevo') {
            print("Creando historia clinica");
            hcNotifier.onCreateHcGeneral();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  //WIDGETS DE LA PAGINA

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget MaxlineSection(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: 5, // Aumenta el tamaño de la caja de texto
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorStyle: const TextStyle(
            color: Colors.red, // Mensaje de error en rojo
          ),
        ),
        validator: (MaxLinevalue) {
          return (MaxLinevalue == null || MaxLinevalue.isEmpty)
              ? 'Llenar el campo'
              : null;
        },
      ),
    );
  }
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

Widget InlineCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
      ),
      Text(title),
    ],
  );
}
