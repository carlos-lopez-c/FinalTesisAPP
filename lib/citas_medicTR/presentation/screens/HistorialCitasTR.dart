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
  final TextEditingController _cedulaController = TextEditingController();
  bool _hasShownMessage = false;

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
  void dispose() {
    _cedulaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentProvider);
    final user = ref.watch(authProvider).user;

    // Escuchar cambios en el estado para mostrar mensajes
    ref.listen<AppointmentState>(appointmentProvider, (previous, next) {
      if (!_hasShownMessage) {
        if (next.successMessage.isNotEmpty) {
          _hasShownMessage = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.successMessage),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          // Limpiar mensaje después de mostrarlo
          Future.delayed(const Duration(seconds: 2), () {
            ref.read(appointmentProvider.notifier).clearSuccess();
            _hasShownMessage = false;
          });
        }

        if (next.errorMessage.isNotEmpty) {
          _hasShownMessage = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          // Limpiar mensaje después de mostrarlo
          Future.delayed(const Duration(seconds: 3), () {
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
                  // Buscador por cédula
                  _buildBuscadorCedula(appointmentState),

                  const SizedBox(height: 16),

                  // Información del filtro
                  HistorialInfoCard(
                    esBusquedaPorCedula: appointmentState.esBusquedaPorCedula,
                    cedulaBusqueda: appointmentState.cedulaBusqueda,
                    cantidadCitas: appointmentState.citasAgendadas.length,
                  ),

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

  Widget _buildBuscadorCedula(AppointmentState appointmentState) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: const Color(0xFF1976D2),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Buscar por cédula',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1976D2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cedulaController,
                    onChanged: (value) {
                      ref
                          .read(appointmentProvider.notifier)
                          .onCedulaBusquedaChanged(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Ingrese la cédula del paciente',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Color(0xFF1976D2), width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: appointmentState.loading
                      ? null
                      : () {
                          if (_cedulaController.text.trim().isNotEmpty) {
                            ref
                                .read(appointmentProvider.notifier)
                                .buscarCitasPorCedula(
                                    _cedulaController.text.trim());
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Buscar'),
                ),
                const SizedBox(width: 8),
                if (appointmentState.esBusquedaPorCedula)
                  ElevatedButton(
                    onPressed: appointmentState.loading
                        ? null
                        : () {
                            _cedulaController.clear();
                            ref
                                .read(appointmentProvider.notifier)
                                .limpiarBusqueda();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Limpiar'),
                  ),
              ],
            ),
            if (appointmentState.esBusquedaPorCedula &&
                appointmentState.paciente != null)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.blue[700], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Paciente: ${appointmentState.paciente!.firstname} ${appointmentState.paciente!.lastname}',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
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
    final appointmentState = ref.watch(appointmentProvider);

    if (appointmentState.esBusquedaPorCedula) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No se encontraron citas',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No hay citas registradas para este paciente',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _cedulaController.clear();
                ref.read(appointmentProvider.notifier).limpiarBusqueda();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ver todo el historial'),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No hay citas completadas',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
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
