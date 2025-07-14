import 'package:flutter/material.dart';

class HistorialInfoCard extends StatelessWidget {
  final bool esBusquedaPorCedula;
  final String? cedulaBusqueda;
  final int cantidadCitas;

  const HistorialInfoCard({
    super.key,
    this.esBusquedaPorCedula = false,
    this.cedulaBusqueda,
    this.cantidadCitas = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            esBusquedaPorCedula ? Icons.search : Icons.check_circle,
            color: esBusquedaPorCedula ? Colors.blue : Colors.green,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  esBusquedaPorCedula
                      ? 'Búsqueda por cédula: $cedulaBusqueda'
                      : 'Mostrando citas completadas',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                Text(
                  esBusquedaPorCedula
                      ? 'Se encontraron $cantidadCitas citas para este paciente'
                      : 'Solo se muestran las citas que han sido atendidas',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
