import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';

class MotivoConsultaWidget extends ConsumerWidget {
  const MotivoConsultaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hcState = ref.watch(hcGeneralProvider);
    final hcNotifier = ref.read(hcGeneralProvider.notifier);

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
              '2.- MOTIVO DE CONSULTA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 16),
            _buildMultilineFormField(
              label: 'Motivo de consulta',
              initialValue: hcState.createHcGeneral.motivoDeConsulta,
              onChanged: hcNotifier.onMotivoDeConsultaChanged,
            ),
            const SizedBox(height: 24),
            const Text(
              '3.- CARACTERIZACIÓN DEL PROBLEMA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 16),
            _buildMultilineFormField(
              label: 'Descripción del problema',
              initialValue: hcState.createHcGeneral.caracterizacionDelProblema,
              onChanged: hcNotifier.onCaracterizacionDelProblemaChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultilineFormField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
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
}
