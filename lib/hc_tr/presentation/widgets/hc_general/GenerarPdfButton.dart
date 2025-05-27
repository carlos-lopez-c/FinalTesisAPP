import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';
import 'package:h_c_1/hc_tr/presentation/utils/HistoriaClinicaPdfTemplate.dart';

class GenerarPdfButton extends ConsumerWidget {
  const GenerarPdfButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hcState = ref.watch(hcGeneralProvider);

    return FloatingActionButton.extended(
      onPressed: () {
        _mostrarOpcionesPdf(context);
      },
      icon: const Icon(Icons.picture_as_pdf),
      label: const Text('Generar PDF'),
      backgroundColor: Colors.red,
    );
  }

  void _mostrarOpcionesPdf(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Usar un contexto específico para el diálogo
        return AlertDialog(
          title: const Text('Opciones de PDF'),
          content: const Text('¿Qué desea hacer con la Historia Clínica?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext)
                    .pop(); // Usar el contexto del diálogo
                // Vista previa del PDF
                HistoriaClinicaPdfTemplate.mostrarVistaPreviaPdf(context);
              },
              child: const Text('Vista Previa'),
            ),
            TextButton(
              onPressed: () async {
                // Guardar referencia al BuildContext antes de cerrarlo
                final scaffoldContext = context;
                Navigator.of(dialogContext)
                    .pop(); // Usar el contexto del diálogo

                try {
                  // Mostrar indicador de carga
                  _mostrarIndicadorCarga(scaffoldContext);

                  // Guardar el PDF en el dispositivo usando la función mejorada
                  final resultado =
                      await HistoriaClinicaPdfTemplate.guardarPdfPlantilla();

                  // Cerrar indicador de carga
                  if (scaffoldContext.mounted) {
                    Navigator.of(scaffoldContext).pop();
                  }

                  // Mostrar resultado
                  if (resultado != null && scaffoldContext.mounted) {
                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      SnackBar(
                        content: Text(resultado),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (scaffoldContext.mounted) {
                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      const SnackBar(
                        content: Text('No se pudo guardar el PDF'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  // Si hay un error, mostrar mensaje de error
                  print('Error al procesar PDF: $e');
                  if (scaffoldContext.mounted) {
                    // Cerrar diálogo de carga si está abierto
                    try {
                      Navigator.of(scaffoldContext).pop();
                    } catch (e) {
                      // Ignorar si no hay diálogo abierto
                    }

                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () async {
                final scaffoldContext = context;
                Navigator.of(dialogContext)
                    .pop(); // Usar el contexto del diálogo

                try {
                  // Mostrar indicador de carga
                  _mostrarIndicadorCarga(scaffoldContext);

                  // Compartir el PDF
                  final resultado =
                      await HistoriaClinicaPdfTemplate.compartirPdfPlantilla();

                  // Cerrar indicador de carga
                  if (scaffoldContext.mounted) {
                    Navigator.of(scaffoldContext).pop();
                  }

                  // Mostrar resultado solo si no se compartió
                  if (!resultado && scaffoldContext.mounted) {
                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      const SnackBar(
                        content: Text('No se pudo compartir el PDF'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  // Si hay un error, mostrar mensaje de error
                  print('Error al compartir PDF: $e');
                  if (scaffoldContext.mounted) {
                    // Cerrar diálogo de carga si está abierto
                    try {
                      Navigator.of(scaffoldContext).pop();
                    } catch (e) {
                      // Ignorar si no hay diálogo abierto
                    }

                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Compartir'),
            ),
          ],
        );
      },
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
