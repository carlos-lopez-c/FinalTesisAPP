import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/presentation/providers/hc_ps_form_nino_provider.dart';
import 'package:intl/intl.dart';

class DatosPersonalesWidget extends ConsumerStatefulWidget {
  const DatosPersonalesWidget({super.key});

  @override
  ConsumerState<DatosPersonalesWidget> createState() =>
      _DatosPersonalesWidgetState();
}

class _DatosPersonalesWidgetState extends ConsumerState<DatosPersonalesWidget> {
  late TextEditingController _cedulaController;
  late TextEditingController _nombreCompletoController;
  late TextEditingController _fechaNacimientoController;
  late TextEditingController _edadController;
  late TextEditingController _cursoEscolarController;
  late TextEditingController _institucionController;
  late TextEditingController _nombrePapaController;
  late TextEditingController _nombreMamaController;
  late TextEditingController _direccionController;
  late TextEditingController _telefonoController;
  late TextEditingController _remisionController;
  late TextEditingController _fechaEvaluacionController;
  late TextEditingController _responsableController;
  late TextEditingController _coberturaController;

  @override
  void initState() {
    super.initState();

    _cedulaController = TextEditingController();
    _nombreCompletoController = TextEditingController();
    _fechaNacimientoController = TextEditingController();
    _edadController = TextEditingController();
    _cursoEscolarController = TextEditingController();
    _institucionController = TextEditingController();
    _nombrePapaController = TextEditingController();
    _nombreMamaController = TextEditingController();
    _direccionController = TextEditingController();
    _telefonoController = TextEditingController();
    _remisionController = TextEditingController();
    _fechaEvaluacionController = TextEditingController();
    _responsableController = TextEditingController();
    _coberturaController = TextEditingController();
  }

  @override
  void dispose() {
    _cedulaController.dispose();
    _nombreCompletoController.dispose();
    _fechaNacimientoController.dispose();
    _edadController.dispose();
    _cursoEscolarController.dispose();
    _institucionController.dispose();
    _nombrePapaController.dispose();
    _nombreMamaController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _remisionController.dispose();
    _fechaEvaluacionController.dispose();
    _responsableController.dispose();
    _coberturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcNotifier = ref.watch(hcPsNinoFormProvider.notifier);
    final hcState = ref.watch(hcPsNinoFormProvider);

    DateTime _tryParseDate(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) return DateTime.now();
      try {
        return DateFormat('yyyy-MM-dd').parse(dateStr);
      } catch (_) {
        return DateTime.now();
      }
    }

    // Actualizar los controladores cuando cambia el estado
    _cedulaController.text = hcState.cedula;
    _nombreCompletoController.text = hcState.createHcPsNino.nombreCompleto;
    _fechaNacimientoController.text =
        hcState.createHcPsNino.fechaNacimiento.isEmpty
            ? ''
            : DateFormat('dd/MM/yyyy')
                .format(_tryParseDate(hcState.createHcPsNino.fechaNacimiento));
    _edadController.text = hcState.createHcPsNino.edad;
    _cursoEscolarController.text = hcState.createHcPsNino.cursoEscolar;
    _institucionController.text = hcState.createHcPsNino.institucion;
    _nombrePapaController.text = hcState.createHcPsNino.nombrePapa;
    _nombreMamaController.text = hcState.createHcPsNino.nombreMama;
    _direccionController.text = hcState.createHcPsNino.direccion;
    _telefonoController.text = hcState.createHcPsNino.telefono;
    _remisionController.text = hcState.createHcPsNino.remision;
    _fechaEvaluacionController.text =
        hcState.createHcPsNino.fechaEvaluacion.isEmpty
            ? DateFormat('dd/MM/yyyy').format(DateTime.now())
            : DateFormat('dd/MM/yyyy')
                .format(_tryParseDate(hcState.createHcPsNino.fechaEvaluacion));
    _responsableController.text = hcState.createHcPsNino.responsable;
    _coberturaController.text = hcState.createHcPsNino.cobertura;

    // --- CAMPOS SOLO LECTURA EN BUSCAR/EDITAR ---
    final readOnlyDatosFijos = hcState.tipo == 'Buscar/Editar';

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
            const Text(
              '1.- DATOS PERSONALES',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Cédula',
                    controller: _cedulaController,
                    onChanged: hcNotifier.onCedulaChanged,
                    keyboardType: TextInputType.number,
                    readOnly: false,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    await hcNotifier.onBuscarPorCedula();
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Nombre completo',
              controller: _nombreCompletoController,
              onChanged: hcNotifier.onNombreCompletoChanged,
              readOnly: readOnlyDatosFijos,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _fechaNacimientoController,
                    label: 'Fecha de Nacimiento',
                    onChanged: hcNotifier.onFechaNacimientoChanged,
                    readOnly: readOnlyDatosFijos,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _edadController,
                    label: 'Edad',
                    onChanged: hcNotifier.onEdadChanged,
                    keyboardType: TextInputType.number,
                    readOnly: readOnlyDatosFijos,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Curso Escolar Actual',
              controller: _cursoEscolarController,
              onChanged: hcNotifier.onCursoEscolarChanged,
              readOnly: false,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Institución',
              controller: _institucionController,
              onChanged: hcNotifier.onInstitucionChanged,
              readOnly: false,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Nombre del Papá',
                    controller: _nombrePapaController,
                    onChanged: hcNotifier.onNombrePapaChanged,
                    readOnly: false,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    label: 'Nombre de la Mamá',
                    controller: _nombreMamaController,
                    onChanged: hcNotifier.onNombreMamaChanged,
                    readOnly: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Dirección',
              controller: _direccionController,
              onChanged: hcNotifier.onDireccionChanged,
              readOnly: false,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Teléfono',
              controller: _telefonoController,
              onChanged: hcNotifier.onTelefonoChanged,
              keyboardType: TextInputType.phone,
              readOnly: false,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Remisión',
              controller: _remisionController,
              onChanged: hcNotifier.onRemisionChanged,
              readOnly: false,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Fecha de Evaluación',
                    controller: _fechaEvaluacionController,
                    onChanged: hcNotifier.onFechaEvaluacionChanged,
                    readOnly: readOnlyDatosFijos,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    label: 'Responsable',
                    controller: _responsableController,
                    onChanged: hcNotifier.onResponsableChanged,
                    readOnly: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Final de cobertura',
              controller: _coberturaController,
              onChanged: hcNotifier.onCoberturaChanged,
              readOnly: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    Function(String)? onChanged,
    TextInputType? keyboardType,
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
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: (value) {
        return (value == null || value.isEmpty) ? 'Llenar el campo' : null;
      },
    );
  }
}
