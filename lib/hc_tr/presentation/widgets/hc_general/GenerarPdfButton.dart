import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';
import 'package:h_c_1/hc_tr/presentation/utils/HistoriaClinicaPdfTemplate.dart';

class GenerarPdfButton extends ConsumerWidget {
  const GenerarPdfButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hcState = ref.watch(hcGeneralProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton.icon(
        onPressed: () async {
          final json = ref.read(hcGeneralProvider).createHcGeneral.toJson();
          HistoriaClinicaPdfTemplate.guardarYMostrarPdf(json, context, "");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        icon: const Icon(Icons.picture_as_pdf, size: 24),
        label: const Text(
          'Generar PDF',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Mostrar un diálogo de carga
  void _mostrarIndicadorCarga(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Procesando PDF...'),
              ],
            ),
          ),
        );
      },
    );
  }
}
