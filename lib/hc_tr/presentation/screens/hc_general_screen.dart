import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_provider.dart';
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

    // Listeners para mensajes de éxito y error
    ref.listen<HcGeneralFormState?>(hcGeneralProvider, (previous, next) {
      if (next!.successMessage.isNotEmpty) {
        _showSnackBar(context, next.successMessage, true);
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcGeneralProvider.notifier).clearSuccessMessage();
        });
      } else if (next.errorMessage.isNotEmpty) {
        _showSnackBar(context, next.errorMessage, false);
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(hcGeneralProvider.notifier).clearErrorMessage();
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text(
          'Historia Clínica General',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          headerTRWidget(
            textoDinamico: 'HISTORIA CLÍNICA GENERAL',
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildRadioButtonGroup(
                title: 'Tipo de Registro',
                options: ['Nuevo', 'Buscar/Editar'],
                selectedValue: hcState.tipo,
                onChanged: hcNotifier.onTipoChanged,
              ),
            ),
          ),
          const SizedBox(height: 16),
          DatosInformativosWidget(),
          _buildDivider(),
          MotivoConsultaWidget(),
          _buildDivider(),
          _buildSection('4.- ANTECEDENTES PERSONALES'),
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
                  AntecedentesPrenatalesWidget(),
                  _buildDivider(),
                  AntecedentesPerinatalesWidget(),
                  _buildDivider(),
                  MaxlineSection('Observaciones'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
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
                  AntecedentesPostnatalesWidget(),
                  _buildDivider(),
                  DesarrolloMotorFino(),
                  _buildDivider(),
                  EspecificacionesWidget(),
                  _buildDivider(),
                  HabitosPersonalesWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (hcState.tipo == 'Nuevo') {
            hcNotifier.onCreateHcGeneral(context);
          } else {
            hcNotifier.onUpdateHcGeneral(context);
          }
        },
        backgroundColor: const Color(0xFF1976D2),
        icon: const Icon(Icons.save, color: Colors.white),
        label: const Text(
          'Guardar',
          style: TextStyle(color: Colors.white),
        ),
      ),
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

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xFF1976D2),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFF1976D2),
      thickness: 0.5,
      height: 32,
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
        padding: const EdgeInsets.only(bottom: 16.0),
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
              Radio(
                value: option,
                groupValue: selectedValue,
                onChanged: (value) => onChanged(value as String),
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

Widget MaxlineSection(String label) {
  return TextFormField(
    maxLines: 5,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF1976D2)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFF1976D2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFF1976D2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
      ),
      errorStyle: const TextStyle(color: Colors.red),
    ),
    validator: (value) {
      return (value == null || value.isEmpty) ? 'Llenar el campo' : null;
    },
  );
}

Widget InlineCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF1976D2),
      ),
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    ],
  );
}
