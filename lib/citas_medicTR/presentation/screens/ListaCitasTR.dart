import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/DetalleCitaTR.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/HorarioCitasTR.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/ItemWidget_TR.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/NavigationButtonCT_TR.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/headerCT_TR.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/inidicacion_TR.dart';

class ListaCitasTR extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentState = ref.watch(appointmentProvider);
    final user = ref.watch(authProvider).user;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Área de ${user!.role == 'Therapy' ? 'Terapia' : 'Psicología'}',
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
          // Encabezado
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF1976D2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'LISTADO DE CITAS MÉDICAS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'SECCIÓN DE CITAS MÉDICAS',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Botón de horario
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HorarioCitasTr()),
                      ),
                      icon:
                          const Icon(Icons.calendar_today, color: Colors.white),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'HORARIO',
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

                  // Botón de actualizar
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ref
                            .read(appointmentProvider.notifier)
                            .listarCitas(estado: 'Pendiente');
                      },
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'ACTUALIZAR LISTA',
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

                  // Indicaciones
                  Container(
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
                    child: const IndicacionTrWidget(),
                  ),

                  const SizedBox(height: 16),

                  // Lista de citas
                  Expanded(
                    child: appointmentState.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF1976D2),
                            ),
                          )
                        : appointmentState.citas.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.event_busy,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No hay citas pendientes',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: appointmentState.citas.length,
                                itemBuilder: (context, index) {
                                  final cita = appointmentState.citas[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
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
                                    child: ItemTrWidget(
                                      item: {
                                        'area': cita.specialtyTherapy,
                                        'patient': cita.patient,
                                        'fecha': cita.date,
                                        'hora': cita.appointmentTime,
                                        'estado': cita.status,
                                      },
                                      onTap: () {
                                        ref
                                            .read(appointmentProvider.notifier)
                                            .seleccionarCita(cita);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DetalleCitaTr()),
                                        );
                                      },
                                      buttonText: 'Ver detalle de la cita',
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
