import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_provider.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_form_provider.dart';
import 'package:intl/intl.dart';

class DetalleCitaTr extends ConsumerStatefulWidget {
  @override
  _DetalleCitaTrState createState() => _DetalleCitaTrState();
}

class _DetalleCitaTrState extends ConsumerState<DetalleCitaTr> {
  late TextEditingController _horaController;
  late TextEditingController _fechaController;
  late TextEditingController _pacienteController;
  late TextEditingController _diagnosisController;
  late TextEditingController _doctorController;
  late TextEditingController _medicalInsuranceController;
  late TextEditingController _statusController;
  late Appointments _currentCita;
  bool _hasShownMessage = false;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final cita = ref.read(appointmentProvider).citaSeleccionada;
    if (cita == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return;
    }

    _currentCita = cita;
    _horaController = TextEditingController(text: _currentCita.appointmentTime);
    _fechaController = TextEditingController(text: _currentCita.date);
    _pacienteController = TextEditingController(text: _currentCita.patient);
    _diagnosisController = TextEditingController(text: _currentCita.diagnosis);
    _doctorController = TextEditingController(text: _currentCita.doctor);
    _medicalInsuranceController =
        TextEditingController(text: _currentCita.medicalInsurance);
    _statusController = TextEditingController(text: _currentCita.status);

    try {
      _selectedDate = DateFormat('yyyy-MM-dd').parse(_currentCita.date);
    } catch (e) {
      print("Error al analizar la fecha: $e");
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _horaController.dispose();
    _fechaController.dispose();
    _pacienteController.dispose();
    _diagnosisController.dispose();
    _doctorController.dispose();
    _medicalInsuranceController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cita = ref.watch(appointmentProvider).citaSeleccionada;
    final appointmentState = ref.watch(appointmentProvider);

    ref.listen<AppointmentState>(appointmentProvider, (previous, next) {
      if (!_hasShownMessage) {
        if (next.successMessage.isNotEmpty) {
          _hasShownMessage = true;
          _showSnackBar(context, next.successMessage, true);
          Future.delayed(const Duration(seconds: 2), () {
            ref.read(appointmentProvider.notifier).clearSuccess();
            _hasShownMessage = false;
          });
        } else if (next.errorMessage.isNotEmpty) {
          _hasShownMessage = true;
          _showSnackBar(context, next.errorMessage, false);
          Future.delayed(const Duration(seconds: 2), () {
            ref.read(appointmentProvider.notifier).clearError();
            _hasShownMessage = false;
          });
        }
      }
    });

    if (cita == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Detalle de Cita")),
        body: Center(child: Text("No hay información de la cita")),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Detalle de Cita',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Información General',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildReadOnlyTextField(
                      _pacienteController, 'Paciente', Icons.person),
                  SizedBox(height: 16),
                  _buildReadOnlyTextField(
                      _doctorController, 'Doctor', Icons.medical_services),
                  SizedBox(height: 16),
                  _buildReadOnlyTextField(
                      _diagnosisController, 'Diagnóstico', Icons.notes),
                  SizedBox(height: 16),
                  _buildReadOnlyTextField(_medicalInsuranceController,
                      'Seguro Médico', Icons.local_hospital),
                  SizedBox(height: 16),
                  _buildReadOnlyTextField(
                      _statusController, 'Estado', Icons.info),
                  SizedBox(height: 16),
                  _buildReadOnlyText('Área Terapéutica', cita.specialtyTherapy,
                      Icons.category),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Editar Fecha y Hora',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _fechaController,
                    decoration: InputDecoration(
                      labelText: 'Fecha',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon:
                          Icon(Icons.calendar_today, color: Color(0xFF1976D2)),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                          _fechaController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _horaController,
                    decoration: InputDecoration(
                      labelText: 'Hora',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon:
                          Icon(Icons.access_time, color: Color(0xFF1976D2)),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            DateFormat('HH:mm').parse(_horaController.text)),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _horaController.text = pickedTime.format(context);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cambiar Estado de Cita',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _statusController.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: Icon(Icons.check_circle_outline,
                          color: Color(0xFF1976D2)),
                      labelText: 'Estado',
                    ),
                    items:
                        ["Pendiente", "Agendado", "Completado"].map((estado) {
                      return DropdownMenuItem(
                          value: estado, child: Text(estado));
                    }).toList(),
                    onChanged: (nuevoEstado) {
                      if (nuevoEstado != null) {
                        setState(() {
                          _statusController.text = nuevoEstado;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final updatedCita = _currentCita.copyWith(
                    appointmentTime: _horaController.text,
                    date: _fechaController.text,
                    status: _statusController.text,
                  );
                  final notifierForm =
                      ref.read(appointmentFormProvider.notifier);
                  await notifierForm.updateAppointment(updatedCita, context);
                  // Refresh appointments in HorarioCitasTR after update
                  ref
                      .read(appointmentProvider.notifier)
                      .getAppointmentsByStatusAndMedicID("Agendado");
                  Navigator.pop(context);
                },
                icon: Icon(Icons.save, color: Colors.white),
                label: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'GUARDAR CAMBIOS',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2),
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
    );
  }

  Widget _buildReadOnlyTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon, color: Color(0xFF1976D2)),
      ),
      readOnly: true,
    );
  }

  Widget _buildReadOnlyText(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF1976D2)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, bool isSuccess) {
    print('este es el snacbar que tambien se muestra');
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
