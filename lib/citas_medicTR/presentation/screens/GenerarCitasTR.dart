import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_form_provider.dart';
import 'package:intl/intl.dart';

class GenerarCitasTr extends ConsumerStatefulWidget {
  @override
  _GenerarCitasTrState createState() => _GenerarCitasTrState();
}

class _GenerarCitasTrState extends ConsumerState<GenerarCitasTr> {
  final TextEditingController _nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appointmentFormState = ref.watch(appointmentFormProvider);
    final notifier = ref.read(appointmentFormProvider.notifier);

    // 🔹 Actualiza el controlador cuando el paciente cambia
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (appointmentFormState.patientEntity != null) {
        _nombreController.text =
            '${appointmentFormState.patientEntity!.firstname} ${appointmentFormState.patientEntity!.lastname}';
      } else {
        _nombreController.text = '';
      }
    });

    return Scaffold(
      backgroundColor: Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Agendar una cita',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF1976D2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'AGENDACIÓN DE CITAS MÉDICAS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'REGISTRO DE NUEVA CITA',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Buscar Paciente por DNI
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
                          'Buscar Paciente',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: notifier.onCedulaChanged,
                                decoration: InputDecoration(
                                  labelText: 'Cédula del paciente',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  prefixIcon: Icon(Icons.search,
                                      color: Color(0xFF1976D2)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                notifier.getPacienteByDni(
                                    appointmentFormState.cedula);
                              },
                              icon: Icon(Icons.search, color: Colors.white),
                              label: Text('Buscar',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1976D2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Información del Paciente
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
                          'Información del Paciente',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _nombreController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Nombre del Paciente',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon:
                                Icon(Icons.person, color: Color(0xFF1976D2)),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          onChanged: notifier.onDiagnosisChanged,
                          decoration: InputDecoration(
                            labelText: 'Diagnóstico',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.medical_services,
                                color: Color(0xFF1976D2)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Área y Fecha/Hora
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
                          'Detalles de la Cita',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: appointmentFormState.specialtyTherapyId,
                          hint: Text('Seleccione un Área'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon:
                                Icon(Icons.category, color: Color(0xFF1976D2)),
                          ),
                          items: appointmentFormState.areas.map((area) {
                            return DropdownMenuItem(
                              value: area.id,
                              child: Text(area.name),
                            );
                          }).toList(),
                          onChanged: (value) => notifier.onAreaChanged(value!),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                  );
                                  if (selectedDate != null)
                                    notifier.onDateChanged(selectedDate);
                                },
                                icon: Icon(Icons.calendar_today,
                                    color: Colors.white),
                                label: Text(
                                  appointmentFormState.selectedDate == null
                                      ? 'Seleccionar Fecha'
                                      : 'Fecha: ${DateFormat('yyyy-MM-dd').format(appointmentFormState.selectedDate!)}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF1976D2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (selectedTime != null) {
                                    notifier.onTimeChanged(
                                        selectedTime.format(context));
                                  }
                                },
                                icon: Icon(Icons.access_time,
                                    color: Colors.white),
                                label: Text(
                                  appointmentFormState.selectedTime == null
                                      ? 'Seleccionar Hora'
                                      : 'Hora: ${appointmentFormState.selectedTime}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF1976D2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Botón Guardar
                  Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        notifier.saveAppointment();
                      },
                      icon: Icon(Icons.save, color: Colors.white),
                      label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'GUARDAR CITA',
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
          ],
        ),
      ),
    );
  }
}
