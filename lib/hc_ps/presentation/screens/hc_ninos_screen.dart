import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/presentation/providers/hc_ps_form_nino_provider.dart';
import 'package:h_c_1/hc_ps/presentation/widgets/hc_ps_nino/datos_personales.dart';
import 'package:h_c_1/hc_ps/presentation/widgets/hc_ps_nino/historia_clinica.dart';
import 'package:h_c_1/hc_ps/presentation/widgets/headerPS.dart';

class HistoriaClinicaNinoPS extends ConsumerWidget {
  const HistoriaClinicaNinoPS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hcNotifier = ref.watch(hcPsNinoFormProvider.notifier);
    final hcState = ref.watch(hcPsNinoFormProvider);

    // Listeners para mensajes de éxito y error
    ref.listen<HcFormNinoState?>(hcPsNinoFormProvider, (previous, next) {
      if (next!.successMessage.isNotEmpty) {
        _showSnackBar(context, next.successMessage, true);
        Future.delayed(const Duration(seconds: 3), () {
          ref.read(hcPsNinoFormProvider.notifier).clearSuccessMessage();
        });
      } else if (next.errorMessage.isNotEmpty) {
        _showSnackBar(context, next.errorMessage, false);
        Future.delayed(const Duration(seconds: 3), () {
          ref.read(hcPsNinoFormProvider.notifier).clearErrorMessage();
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text(
          'Historia Clínica de Niños - Psicología',
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
          headerPSWidget(
            textoDinamico: 'HISTORIA CLÍNICA DE NIÑOS - PSICOLOGÍA',
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

          // Mostrar mensaje de advertencia si existe historia clínica en modo nuevo
          if (hcState.tipo == 'Nuevo' && hcState.historiaExiste)
            Card(
              elevation: 2,
              color: Colors.orange.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.orange.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Ya existe una historia clínica para esta cédula. Cambie a modo "Buscar/Editar" para verla.',
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 16),
          DatosPersonalesWidget(),
          const SizedBox(height: 16),
          HistoriaClinicaWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: hcState.loading
            ? null
            : () {
                if (hcState.tipo == 'Nuevo') {
                  hcNotifier.onCreateHcPsNino(context);
                } else {
                  hcNotifier.onUpdateHcPsNino(context);
                }
              },
        backgroundColor: const Color(0xFF1976D2),
        icon: hcState.loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Icon(Icons.save, color: Colors.white),
        label: Text(
          hcState.loading ? 'Guardando...' : 'Guardar',
          style: const TextStyle(color: Colors.white),
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
        duration: const Duration(seconds: 3),
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
