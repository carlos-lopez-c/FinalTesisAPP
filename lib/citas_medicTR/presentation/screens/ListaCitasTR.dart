import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/DetalleCitaTR.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/HorarioCitasTR.dart';

class ListaCitasTR extends ConsumerStatefulWidget {
  @override
  _ListaCitasTRState createState() => _ListaCitasTRState();
}

class _ListaCitasTRState extends ConsumerState<ListaCitasTR> {
  bool _hasShownMessage = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final pendientesAsync = ref.watch(appointmentPendientesProvider);

    // Agregar listener para mensajes de éxito y error
    ref.listen<AppointmentState>(appointmentProvider, (previous, next) {
      if (!_hasShownMessage) {
        if (next.successMessage.isNotEmpty && !next.esBusquedaPorCedula) {
          _hasShownMessage = true;
          _showSnackBar(context, next.successMessage, true);
          Future.delayed(const Duration(seconds: 2), () {
            ref.read(appointmentProvider.notifier).clearSuccess();
            _hasShownMessage = false;
          });
        } else if (next.errorMessage.isNotEmpty && !next.esBusquedaPorCedula) {
          _hasShownMessage = true;
          _showSnackBar(context, next.errorMessage, false);
          Future.delayed(const Duration(seconds: 2), () {
            ref.read(appointmentProvider.notifier).clearError();
            _hasShownMessage = false;
          });
        }
      }
    });

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
  width: double.infinity, // ← Asegura ancho completo
  padding: const EdgeInsets.all(20),
  decoration: const BoxDecoration(
    color: Color(0xFF1976D2),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(24),
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, // ← Expande el Column
    children: [
      const Text(
        'LISTADO DE CITAS MÉDICAS',
        textAlign: TextAlign.center, // ← Centra este texto también (opcional)
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'En esta página solo se mostrarán las citas pendientes',
        textAlign: TextAlign.center, // ← Centrado directo (alternativa a Align)
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
                  
                  const SizedBox(height: 16),

                  // Lista de citas en tiempo real
                  Expanded(
                    child: pendientesAsync.when(
                      data: (citas) {
                        if (citas.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.event_busy,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No hay citas pendientes',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Las citas pendientes aparecerán aquí',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
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
                            itemCount: citas.length,
                            itemBuilder: (context, index) {
                              final cita = citas[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFF1976D2).withOpacity(0.2),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
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
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF1976D2)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.medical_services,
                                                  color: Color(0xFF1976D2),
                                                  size: 24,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cita.specialtyTherapy,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF1976D2),
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      cita.patient,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _getStatusColor(
                                                          cita.status)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  cita.status,
                                                  style: TextStyle(
                                                    color: _getStatusColor(
                                                        cita.status),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              _buildInfoItem(
                                                Icons.calendar_today,
                                                cita.date,
                                                Color(0xFF1976D2),
                                              ),
                                              SizedBox(width: 16),
                                              _buildInfoItem(
                                                Icons.access_time,
                                                cita.appointmentTime,
                                                Color(0xFF1976D2),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Container(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                ref
                                                    .read(appointmentProvider
                                                        .notifier)
                                                    .seleccionarCita(cita);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          DetalleCitaTr()),
                                                );
                                              },
                                              icon: Icon(Icons.visibility,
                                                  size: 20),
                                              label: Text('Ver detalle'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFF1976D2),
                                                foregroundColor: Colors.white,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      loading: () => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Color(0xFF1976D2),
                              strokeWidth: 3,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Cargando citas...',
                              style: TextStyle(
                                color: Color(0xFF1976D2),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      error: (e, _) => Center(
                        child: Text('Error al cargar citas: $e'),
                      ),
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

  Widget _buildInfoItem(IconData icon, String text, Color color) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pendiente':
        return Colors.orange;
      case 'agendado':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      case 'completado':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showSnackBar(BuildContext context, String message, bool isSuccess) {
    print('este es el snacbar que tambien se muestra2');
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
}
