import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/presentation/providers/hc_ps_form_nino_provider.dart';

class HistoriaClinicaWidget extends ConsumerStatefulWidget {
  const HistoriaClinicaWidget({super.key});

  @override
  ConsumerState<HistoriaClinicaWidget> createState() =>
      _HistoriaClinicaWidgetState();
}

class _HistoriaClinicaWidgetState extends ConsumerState<HistoriaClinicaWidget> {
  late TextEditingController _observacionesController;
  late TextEditingController _motivoConsultaController;
  late TextEditingController _desencadenantesController;
  late TextEditingController _datosEmbarazoPartoController;
  late TextEditingController _datosPsicomotorController;
  late TextEditingController _desarrolloLenguajeController;
  late TextEditingController _desarrolloIntelectualController;
  late TextEditingController _desarrolloSocioAfectivoController;
  late TextEditingController _antecedentesFamiliaresController;
  late TextEditingController _estructuraFamiliarController;
  late TextEditingController _pruebasAplicadasController;
  late TextEditingController _impresionDiagnosticaController;
  late TextEditingController _areasIntervencionController;

  @override
  void initState() {
    super.initState();

    _observacionesController = TextEditingController();
    _motivoConsultaController = TextEditingController();
    _desencadenantesController = TextEditingController();
    _datosEmbarazoPartoController = TextEditingController();
    _datosPsicomotorController = TextEditingController();
    _desarrolloLenguajeController = TextEditingController();
    _desarrolloIntelectualController = TextEditingController();
    _desarrolloSocioAfectivoController = TextEditingController();
    _antecedentesFamiliaresController = TextEditingController();
    _estructuraFamiliarController = TextEditingController();
    _pruebasAplicadasController = TextEditingController();
    _impresionDiagnosticaController = TextEditingController();
    _areasIntervencionController = TextEditingController();
  }

  @override
  void dispose() {
    _observacionesController.dispose();
    _motivoConsultaController.dispose();
    _desencadenantesController.dispose();
    _datosEmbarazoPartoController.dispose();
    _datosPsicomotorController.dispose();
    _desarrolloLenguajeController.dispose();
    _desarrolloIntelectualController.dispose();
    _desarrolloSocioAfectivoController.dispose();
    _antecedentesFamiliaresController.dispose();
    _estructuraFamiliarController.dispose();
    _pruebasAplicadasController.dispose();
    _impresionDiagnosticaController.dispose();
    _areasIntervencionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcNotifier = ref.watch(hcPsNinoFormProvider.notifier);
    final hcState = ref.watch(hcPsNinoFormProvider);

    // Actualizar los controladores cuando cambia el estado
    _observacionesController.text = hcState.createHcPsNino.observaciones;
    _motivoConsultaController.text = hcState.createHcPsNino.motivoConsulta;
    _desencadenantesController.text =
        hcState.createHcPsNino.desencadenantesMotivoConsulta;
    _datosEmbarazoPartoController.text =
        hcState.createHcPsNino.datosEmbarazoParto;
    _datosPsicomotorController.text = hcState.createHcPsNino.datosPsicomotor;
    _desarrolloLenguajeController.text =
        hcState.createHcPsNino.desarrolloLenguaje;
    _desarrolloIntelectualController.text =
        hcState.createHcPsNino.desarrolloIntelectual;
    _desarrolloSocioAfectivoController.text =
        hcState.createHcPsNino.desarrolloSocioAfectivo;
    _antecedentesFamiliaresController.text =
        hcState.createHcPsNino.antecedentesFamiliares;
    _estructuraFamiliarController.text =
        hcState.createHcPsNino.estructuraFamiliar;
    _pruebasAplicadasController.text = hcState.createHcPsNino.pruebasAplicadas;
    _impresionDiagnosticaController.text =
        hcState.createHcPsNino.impresionDiagnostica;
    _areasIntervencionController.text =
        hcState.createHcPsNino.areasIntervencion;

    final readOnly = hcState.tipo == 'Buscar';

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
            // Sección 2
            const Text('2.- Motivo de consulta',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1976D2))),
            const SizedBox(height: 8),
            _buildTextField(
              label: 'Motivo de consulta',
              controller: _motivoConsultaController,
              onChanged: hcNotifier.onMotivoConsultaChanged,
              maxLines: 4,
              readOnly: readOnly,
            ),
            const SizedBox(height: 20),
            // Sección 3
            const Text('3.- Desencadenantes de motivo de consulta',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1976D2))),
            const SizedBox(height: 8),
            _buildTextField(
              label: 'Desencadenantes de motivo de consulta',
              controller: _desencadenantesController,
              onChanged: hcNotifier.onDesencadenantesChanged,
              maxLines: 4,
              readOnly: readOnly,
            ),
            const SizedBox(height: 20),
            // Sección 4
            const Text('4.- Antecedentes familiares',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1976D2))),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Datos de embarazo y parto',
                controller: _datosEmbarazoPartoController,
                onChanged: hcNotifier.onDatosEmbarazoPartoChanged,
                maxLines: 3,
                readOnly: readOnly),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Desarrollo psicomotor',
                controller: _datosPsicomotorController,
                onChanged: hcNotifier.onDatosPsicomotorChanged,
                maxLines: 3,
                readOnly: readOnly),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Desarrollo del lenguaje',
                controller: _desarrolloLenguajeController,
                onChanged: hcNotifier.onDesarrolloLenguajeChanged,
                maxLines: 3,
                readOnly: readOnly),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Desarrollo intelectual',
                controller: _desarrolloIntelectualController,
                onChanged: hcNotifier.onDesarrolloIntelectualChanged,
                maxLines: 3,
                readOnly: readOnly),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Desarrollo socio-afectivo',
                controller: _desarrolloSocioAfectivoController,
                onChanged: hcNotifier.onDesarrolloSocioAfectivoChanged,
                maxLines: 3,
                readOnly: readOnly),
            const SizedBox(height: 20),
            // Sección 5
            const Text('5.- Antecedentes y estructura familiar',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1976D2))),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Antecedentes y estructura familiar',
                controller: _estructuraFamiliarController,
                onChanged: hcNotifier.onEstructuraFamiliarChanged,
                maxLines: 3,
                readOnly: readOnly),
            const SizedBox(height: 20),
            // Sección 6
            const Text('6.- Pruebas aplicadas',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1976D2))),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Pruebas aplicadas',
                controller: _pruebasAplicadasController,
                onChanged: hcNotifier.onPruebasAplicadasChanged,
                maxLines: 3,
                readOnly: readOnly),
            const SizedBox(height: 20),
            // Sección 7
            const Text('7.- Impresión diagnóstica',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1976D2))),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Impresión diagnóstica',
                controller: _impresionDiagnosticaController,
                onChanged: hcNotifier.onImpresionDiagnosticaChanged,
                maxLines: 3,
                readOnly: readOnly),
            const SizedBox(height: 20),
            // Sección 8
            const Text('8.- Áreas de intervención',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1976D2))),
            const SizedBox(height: 8),
            _buildTextField(
                label: 'Áreas de intervención',
                controller: _areasIntervencionController,
                onChanged: hcNotifier.onAreasIntervencionChanged,
                maxLines: 3,
                readOnly: readOnly),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    Function(String)? onChanged,
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF1976D2)),
        filled: true,
        fillColor: readOnly ? Colors.grey.shade100 : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF1976D2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF1976D2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
        errorStyle: const TextStyle(color: Colors.red),
      ),
      onChanged: onChanged,
      maxLines: maxLines,
      readOnly: readOnly,
      validator: (value) {
        return (value == null || value.isEmpty) ? 'Llenar el campo' : null;
      },
    );
  }
}
