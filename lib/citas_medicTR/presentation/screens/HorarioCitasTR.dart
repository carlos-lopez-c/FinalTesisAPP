import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_c_1/citas_medicTR/presentation/providers/appointments_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/GenerarCitasTR.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/DetalleCitaTR.dart';

class HorarioCitasTr extends ConsumerStatefulWidget {
  @override
  _HorarioCitasTrState createState() => _HorarioCitasTrState();
}

class _HorarioCitasTrState extends ConsumerState<HorarioCitasTr> {
  bool _hasShownMessage = false;

  @override
  void initState() {
    super.initState();
    // Cargar las citas con estado "Agendado" al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(appointmentProvider.notifier)
          .getAppointmentsByStatusAndMedicID("Agendado");
      // Cargar las citas del día actual al iniciar la pantalla
      ref
          .read(appointmentProvider.notifier)
          .getAppointmentsByDate(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentProvider);
    final notifier = ref.read(appointmentProvider.notifier);

    // Agregar listener para mensajes de éxito y error
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

    final selectedDate = appointmentState.calendarioCitaSeleccionada;

    return Scaffold(
      backgroundColor: Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Horario de Citas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
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
                    'HORARIO DE CITAS MÉDICAS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'GESTIÓN DE CITAS',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 16),
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GenerarCitasTr()),
                          ),
                          icon: Icon(Icons.add_circle, color: Colors.white),
                          label: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'AGENDAR UNA CITA',
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



                       Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton.icon(
                      onPressed: () => context.push('/historial-citas'),
                      icon: const Icon(Icons.history, color: Colors.white),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'HISTORIAL DE CITAS',
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
                        child: TableCalendar(
                          availableGestures: AvailableGestures.all,
                          locale: "es_EC",
                          firstDay: DateTime.utc(2025, 1, 1),
                          lastDay: DateTime.utc(2025, 12, 31),
                          focusedDay: selectedDate,
                          selectedDayPredicate: (day) =>
                              isSameDay(day, selectedDate),
                          onDaySelected: (selectedDay, focusedDay) {
                            notifier.onDateSelected(selectedDay);
                          },
                          eventLoader: (day) {
                            return appointmentState.citasAgendadas
                                .where((cita) {
                              try {
                                final citaDate =
                                    DateFormat('yyyy-MM-dd').parse(cita.date);
                                return isSameDay(day, citaDate);
                              } catch (_) {
                                return false;
                              }
                            }).toList();
                          },
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Color(0xFF1976D2),
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Color(0xFF1976D2).withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            markerDecoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            outsideDaysVisible: false,
                            weekendTextStyle: TextStyle(color: Colors.red),
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: TextStyle(
                              color: Color(0xFF1976D2),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            leftChevronIcon: Icon(Icons.chevron_left,
                                color: Color(0xFF1976D2)),
                            rightChevronIcon: Icon(Icons.chevron_right,
                                color: Color(0xFF1976D2)),
                          ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Citas para el día seleccionado",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1976D2),
                                ),
                              ),
                            ),
                            if (appointmentState.loading)
                              Container(
                                height: 200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                              )
                            else if (appointmentState.citasDelDia.isNotEmpty)
                              Container(
                                height: 200,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(16),
                                  itemCount:
                                      appointmentState.citasDelDia.length,
                                  itemBuilder: (context, index) {
                                    final cita =
                                        appointmentState.citasDelDia[index];
                                    return GestureDetector(
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
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          leading: Icon(Icons.medical_services,
                                              color: Color(0xFF1976D2)),
                                          title: Text(
                                            cita.specialtyTherapy,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1976D2),
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Fecha: ${cita.date}"),
                                              Text(
                                                  "Hora: ${cita.appointmentTime}"),
                                            ],
                                          ),
                                          trailing: Icon(Icons.edit,
                                              color: Color(0xFF1976D2)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            else
                              Container(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.event_busy,
                                        size: 64,
                                        color: Colors.grey[400],
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        "No hay citas para este día",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, bool isSuccess) {
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
