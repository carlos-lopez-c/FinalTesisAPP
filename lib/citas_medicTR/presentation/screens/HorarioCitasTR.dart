import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/GenerarCitasTR.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/NavigationButtonCT_TR.dart';
import 'package:h_c_1/citas_medicTR/presentation/widgets/headerCT_TR.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HorarioCitasTr extends ConsumerStatefulWidget {
  @override
  _HorarioCitasTrState createState() => _HorarioCitasTrState();
}

class _HorarioCitasTrState extends ConsumerState<HorarioCitasTr> {
  @override
  void initState() {
    super.initState();
    // Cargar las citas con estado "Agendado" al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(appointmentProvider.notifier)
          .getAppointmentsByStatusAndMedicID("Agendado");
    });
  }

  void _editarCita(BuildContext context, Appointments cita) {
    TextEditingController areaController =
        TextEditingController(text: cita.specialtyTherapy);
    TextEditingController horaController =
        TextEditingController(text: cita.appointmentTime);
    DateTime? selectedDate = DateFormat('MMMM d, y', 'en_US').parse(cita.date);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Cita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: areaController,
                decoration: InputDecoration(labelText: 'Área'),
              ),
              TextField(
                controller: horaController,
                decoration: InputDecoration(labelText: 'Hora'),
              ),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
                child: Text('Seleccionar Fecha'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // cita['area'] = areaController.text;
                // cita['hora'] = horaController.text;
                // cita['fecha'] = selectedDate ?? cita['fecha'];
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentProvider);
    final notifier = ref.read(appointmentProvider.notifier);

    final selectedDate = appointmentState.calendarioCitaSeleccionada;

    return Scaffold(
      appBar: AppBar(
        title: Text('Horario de Citas'),
      ),
      body: Column(
        children: [
          HeaderctTrWidget(
            textoDinamico: '  HORARIO DE CITAS MÉDICAS',
            textoCitasMedicas: '                    HORARIO',
          ),
          const SizedBox(height: 20),
          SizedBox(height: 15),
          NavigationTrButton(
            navigationRoute: (context) => GenerarCitasTr(),
            buttonText: 'AGENDAR UNA CITA',
          ),
          SizedBox(height: 20),
          Divider(),
          TableCalendar(
            availableGestures: AvailableGestures.all,
            locale: "es_EC",
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: selectedDate,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              notifier.onDateSelected(selectedDay);
            },
            eventLoader: (day) {
              // Verificar si hay citas agendadas para este día
              return appointmentState.citasAgendadas.where((cita) {
                try {
                  // Convertir la fecha de la cita a DateTime
                  final citaDate =
                      DateFormat('MMMM d, y', 'en_US').parse(cita.date);
                  return isSameDay(day, citaDate);
                } catch (_) {
                  return false;
                }
              }).toList();
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              // Estilo para los días con eventos (citas agendadas)
              markerDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // Verificar si hay citas agendadas para este día
                final citas = appointmentState.citasAgendadas.where((cita) {
                  try {
                    final citaDate = DateFormat('yyyy-MM-dd').parse(cita.date);

                    return isSameDay(day, citaDate);
                  } catch (e) {
                    print("Error al comparar fechas: $e");
                    return false;
                  }
                }).toList();
                // Pintar de verde si hay citas agendadas para este día

                Color? backgroundColor;
                if (citas.isNotEmpty) {
                  backgroundColor = Colors.green; // Días con citas agendadas
                }
                return Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: backgroundColor != null
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Expanded(
            child: appointmentState.loading
                ? Center(
                    child: CircularProgressIndicator()) // 🔄 Indicador de carga
                : Column(
                    children: [
                      Text(
                        "Citas para el día seleccionado",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (appointmentState.citasDelDia.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            itemCount: appointmentState.citasDelDia.length,
                            itemBuilder: (context, index) {
                              final cita = appointmentState.citasDelDia[index];
                              return Card(
                                margin: EdgeInsets.all(10),
                                elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Especialidad: ${cita.specialtyTherapy}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Fecha: ${cita.date}"),
                                      Text("Hora: ${cita.appointmentTime}"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (appointmentState.citasDelDia.isEmpty)
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "No hay citas para este día.",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
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
