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
      appBar: AppBar(title: Text('Área de ${user!.role}')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          HeaderctTrWidget(
            textoDinamico: 'LISTADO DE CITAS MÉDICAS',
            textoCitasMedicas: 'SECCIÓN DE CITAS MÉDICAS',
          ),
          const SizedBox(height: 20),
          NavigationTrButton(
            navigationRoute: (context) => HorarioCitasTr(),
            buttonText: 'HORARIO',
          ),
          const SizedBox(height: 20),
          IconButton(
              onPressed: () {
                ref
                    .read(appointmentProvider.notifier)
                    .listarCitas(estado: 'Pendiente');
              },
              icon: Icon(Icons.refresh)),
          Divider(),
          IndicacionTrWidget(),
          Divider(),
          Expanded(
            child: appointmentState.loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: appointmentState.citas.length,
                    itemBuilder: (context, index) {
                      final cita = appointmentState.citas[index];

                      return ItemTrWidget(
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
                            MaterialPageRoute(builder: (_) => DetalleCitaTr()),
                          );
                        },
                        buttonText: 'Ver detalle de la cita',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
