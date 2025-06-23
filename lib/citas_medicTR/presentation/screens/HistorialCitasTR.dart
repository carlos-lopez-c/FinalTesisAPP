import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/historial_cita_item.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/historial_header.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/historial_info_card.dart';

class HistorialCitasTR extends ConsumerStatefulWidget {
  @override
  ConsumerState<HistorialCitasTR> createState() => _HistorialCitasTRState();
}

class _HistorialCitasTRState extends ConsumerState<HistorialCitasTR> {
  @override
  void initState() {
    super.initState();
    // Cargar las citas completadas solo una vez al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(appointmentProvider.notifier)
          .getAppointmentsByStatusAndMedicID("Completado");
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentProvider);
    final user = ref.watch(authProvider).user;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Historial de Citas',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Header
          const HistorialHeader(),

          // Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Información del filtro
                  const HistorialInfoCard(),

                  const SizedBox(height: 16),

                  // Botón de actualizar
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ref
                            .read(appointmentProvider.notifier)
                            .getAppointmentsByStatusAndMedicID("Completado");
                      },
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'ACTUALIZAR HISTORIAL',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),

                  // Lista de citas
                  Expanded(
                    child: appointmentState.loading
                        ? _buildLoadingState()
                        : appointmentState.citasAgendadas.isEmpty
                            ? _buildEmptyState()
                            : _buildCitasList(context, ref, appointmentState),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF1976D2),
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          Text(
            'Cargando historial...',
            style: TextStyle(
              color: Color(0xFF1976D2),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No hay citas completadas',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Las citas completadas aparecerán aquí',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCitasList(
      BuildContext context, WidgetRef ref, AppointmentState appointmentState) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: appointmentState.citasAgendadas.length,
        itemBuilder: (context, index) {
          final cita = appointmentState.citasAgendadas[index];
          return HistorialCitaItem(
            cita: cita,
            onTap: () {
              ref.read(appointmentProvider.notifier).seleccionarCita(cita);
              context.push('/detalle-cita-completada');
            },
          );
        },
      ),
    );
  }
}
