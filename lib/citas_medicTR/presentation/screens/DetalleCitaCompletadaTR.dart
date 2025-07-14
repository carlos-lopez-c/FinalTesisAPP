import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_provider.dart';
import 'package:intl/intl.dart';

class DetalleCitaCompletadaTR extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cita = ref.watch(appointmentProvider).citaSeleccionada;

    if (cita == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: Text(
            'Detalle de Cita',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Text('No hay información de la cita'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Detalle de Cita Completada',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con estado completado
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
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'CITA COMPLETADA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Esta cita ya fue atendida',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Información del paciente
                  _buildInfoCard(
                    'Información del Paciente',
                    Icons.person,
                    [
                      _buildInfoRow('Nombre', cita.patient),
                      _buildInfoRow('ID Paciente', cita.patientId),
                      if (cita.emailPatient.isNotEmpty)
                        _buildInfoRow('Email', cita.emailPatient),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Información de la cita
                  _buildInfoCard(
                    'Información de la Cita',
                    Icons.medical_services,
                    [
                      _buildInfoRow('Especialidad', cita.specialtyTherapy),
                      _buildInfoRow('Fecha', _formatDate(cita.date)),
                      _buildInfoRow('Hora', cita.appointmentTime),
                      _buildInfoRow('Estado', cita.status),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Información médica
                  _buildInfoCard(
                    'Información Médica',
                    Icons.health_and_safety,
                    [
                      _buildInfoRow('Seguro Médico', cita.medicalInsurance),
                      if (cita.diagnosis.isNotEmpty)
                        _buildInfoRow('Diagnóstico', cita.diagnosis),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Información del doctor
                  _buildInfoCard(
                    'Información del Doctor',
                    Icons.medical_information,
                    [
                      _buildInfoRow('Doctor', cita.doctor),
                      _buildInfoRow('ID Doctor', cita.doctorId),
                    ],
                  ),

                  SizedBox(height: 32),

                  // Botón de regresar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => context.pop(),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'REGRESAR AL HISTORIAL',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, List<Widget> children) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF1976D2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Color(0xFF1976D2),
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
