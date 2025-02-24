import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/presentation/providers/hc_ps_form_provider.dart';
import '../widgets/headerPS.dart';

class HistoriaClinicaAdultPS extends ConsumerStatefulWidget {
  @override
  _HistoriaClinicaAdultPSState createState() => _HistoriaClinicaAdultPSState();
}

class _HistoriaClinicaAdultPSState
    extends ConsumerState<HistoriaClinicaAdultPS> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController cedulaController;
  late TextEditingController nombreCompletoController;
  late TextEditingController fechaNacimientoController;
  late TextEditingController telefonoController;
  late TextEditingController institucionController;
  late TextEditingController direccionController;
  late TextEditingController remisionController;
  late TextEditingController fechaEvaluacionController;
  late TextEditingController coberturaController;
  late TextEditingController observacionesController;
  late TextEditingController responsableController;
  late TextEditingController motivoConsultaController;
  late TextEditingController desencadenantesController;
  late TextEditingController antecedentesFamiliaresController;
  late TextEditingController pruebasAplicadasController;
  late TextEditingController impresionDiagnosticaController;
  late TextEditingController areasIntervencionController;

  @override
  void initState() {
    super.initState();
    cedulaController = TextEditingController();
    nombreCompletoController = TextEditingController();
    fechaNacimientoController = TextEditingController();
    telefonoController = TextEditingController();
    institucionController = TextEditingController();
    direccionController = TextEditingController();
    remisionController = TextEditingController();
    fechaEvaluacionController = TextEditingController();
    coberturaController = TextEditingController();
    observacionesController = TextEditingController();
    responsableController = TextEditingController();
    motivoConsultaController = TextEditingController();
    desencadenantesController = TextEditingController();
    antecedentesFamiliaresController = TextEditingController();
    pruebasAplicadasController = TextEditingController();
    impresionDiagnosticaController = TextEditingController();
    areasIntervencionController = TextEditingController();
  }

  @override
  void dispose() {
    cedulaController.dispose();
    nombreCompletoController.dispose();
    fechaNacimientoController.dispose();
    telefonoController.dispose();
    institucionController.dispose();
    direccionController.dispose();
    remisionController.dispose();
    fechaEvaluacionController.dispose();
    coberturaController.dispose();
    observacionesController.dispose();
    responsableController.dispose();
    motivoConsultaController.dispose();
    desencadenantesController.dispose();
    antecedentesFamiliaresController.dispose();
    pruebasAplicadasController.dispose();
    impresionDiagnosticaController.dispose();
    areasIntervencionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcState = ref.watch(hcPsAdultFormProvider);
    final hcNotifier = ref.read(hcPsAdultFormProvider.notifier);

    // Actualizar los controladores con los valores del estado
    cedulaController.text = hcState.cedula;
    nombreCompletoController.text = hcState.createHcPsAdult.nombreCompleto;
    fechaNacimientoController.text = hcState.createHcPsAdult.fechaNacimiento;
    telefonoController.text = hcState.createHcPsAdult.telefono;
    institucionController.text = hcState.createHcPsAdult.institucion;
    direccionController.text = hcState.createHcPsAdult.direccion;
    remisionController.text = hcState.createHcPsAdult.remision;
    fechaEvaluacionController.text = hcState.createHcPsAdult.fechaEvalucion;
    coberturaController.text = hcState.createHcPsAdult.cobertura;
    observacionesController.text = hcState.createHcPsAdult.observaciones;
    responsableController.text = hcState.createHcPsAdult.responsable;
    motivoConsultaController.text = hcState.createHcPsAdult.motivoConsulta;
    desencadenantesController.text =
        hcState.createHcPsAdult.desencadenantesMotivoConsulta;
    antecedentesFamiliaresController.text =
        hcState.createHcPsAdult.antecedenteFamiliares;
    pruebasAplicadasController.text = hcState.createHcPsAdult.pruebasAplicadas;
    impresionDiagnosticaController.text =
        hcState.createHcPsAdult.impresionDiagnostica;
    areasIntervencionController.text = hcState.createHcPsAdult.areasIntervecion;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Área de Psicología'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              headerPSWidget(
                textoDinamico: 'HISTORIA CLÍNICA DE ADULTOS',
              ),
              const SizedBox(height: 20),
              Center(
                  child: _buildRadioButtonGroup(
                title: '',
                options: ['Nuevo', 'Buscar'],
                selectedValue: hcState.tipo,
                onChanged: hcNotifier.onTipoChanged,
              )),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cedulaController,
                      onChanged: hcNotifier.onCedulaChanged,
                      decoration:
                          const InputDecoration(labelText: 'Buscar por cédula'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (hcState.tipo == 'Nuevo') {
                        hcNotifier.getPacienteByDni(hcState.cedula);
                      } else {
                        hcNotifier.onSearchHcPsAdult(hcState.cedula);
                      }
                    },
                    child: const Text('Buscar'),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              _buildSection('1.- DATOS PERSONALES:'),
              _buildFormField(
                label: 'Nombres y Apellidos',
                controller: nombreCompletoController,
                onChanged: hcNotifier.setNombreCompleto,
                validator: (value) => _validateRequired(value),
              ),
              _buildFormField(
                label: 'Fecha de Nacimiento (AAAA-MM-DD)',
                controller: fechaNacimientoController,
                onChanged: (value) => hcNotifier.setFechaNacimiento,
                validator: (value) => _validateDate(value),
              ),
              _buildFormField(
                label: 'Teléfono',
                controller: telefonoController,
                onChanged: hcNotifier.setTelefono,
                keyboardType: TextInputType.phone,
                validator: (value) => _validatePhone(value),
              ),
              _buildFormField(
                label: 'Institución',
                controller: institucionController,
                onChanged: hcNotifier.setInstitucion,
                validator: (value) => _validateRequired(value),
              ),
              _buildFormField(
                label: 'Dirección',
                controller: direccionController,
                onChanged: hcNotifier.setDireccion,
                validator: (value) => _validateRequired(value),
              ),
              _buildFormField(
                label: 'Remisión',
                controller: remisionController,
                onChanged: hcNotifier.setRemision,
                validator: (value) => _validateRequired(value),
              ),
              _buildFormField(
                label: 'Fecha de Evaluación (AAAA-MM-DD)',
                controller: fechaEvaluacionController,
                onChanged: (value) => hcNotifier.setFechaEvaluacion,
                validator: (value) => _validateDate(value),
              ),
              _buildFormField(
                label: 'Final de Cobertura',
                controller: coberturaController,
                onChanged: hcNotifier.setCobertura,
                validator: (value) => _validateRequired(value),
              ),
              _buildFormField(
                label: 'Observaciones',
                controller: observacionesController,
                onChanged: hcNotifier.setObservaciones,
                maxLines: 3,
                validator: (value) => _validateRequired(value),
              ),
              _buildFormField(
                label: 'Responsable',
                controller: responsableController,
                onChanged: hcNotifier.setResponsable,
                validator: (value) => _validateRequired(value),
              ),
              const SizedBox(height: 20),
              _buildSection('2.- MOTIVO DE CONSULTA:'),
              _buildFormField(
                label: 'Describa el motivo de la consulta',
                controller: motivoConsultaController,
                onChanged: hcNotifier.setMotivoConsulta,
                maxLines: 3,
                validator: (value) => _validateRequired(value),
              ),
              const SizedBox(height: 20),
              _buildSection('3.- DESENCADENANTES DE MOTIVO DE CONSULTA:'),
              _buildFormField(
                label: 'Describa los desencadenantes',
                controller: desencadenantesController,
                onChanged: hcNotifier.setDesencadenantesMotivoConsulta,
                maxLines: 3,
                validator: (value) => _validateRequired(value),
              ),
              const SizedBox(height: 20),
              _buildSection('4.- ANTECEDENTES FAMILIARES:'),
              _buildFormField(
                label: 'Describa los antecedentes familiares',
                controller: antecedentesFamiliaresController,
                onChanged: hcNotifier.setAntecedenteFamiliares,
                maxLines: 4,
                validator: (value) => _validateRequired(value),
              ),
              const SizedBox(height: 20),
              _buildSection('5.- PRUEBAS APLICADAS:'),
              _buildFormField(
                label: 'Describa las pruebas aplicadas',
                controller: pruebasAplicadasController,
                onChanged: hcNotifier.setPruebasAplicadas,
                maxLines: 3,
                validator: (value) => _validateRequired(value),
              ),
              const SizedBox(height: 20),
              _buildSection('6.- IMPRESIÓN DIAGNÓSTICA:'),
              _buildFormField(
                label: 'Describa la impresión diagnóstica',
                controller: impresionDiagnosticaController,
                onChanged: hcNotifier.setImpresionDiagnostica,
                maxLines: 3,
                validator: (value) => _validateRequired(value),
              ),
              const SizedBox(height: 20),
              _buildSection('7.- ÁREAS DE INTERVENCIÓN:'),
              _buildFormField(
                label: 'Describa las áreas de intervención',
                controller: areasIntervencionController,
                onChanged: hcNotifier.setAreasIntervencion,
                maxLines: 3,
                validator: (value) => _validateRequired(value),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (hcState.tipo == 'Nuevo') {
              hcNotifier.onCreateHcPsAdult(context);
            } else if (hcState.tipo == 'Buscar') {
              hcNotifier.onUpdateHcPsAdult(context);
            }
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  // 🔹 Sección con título estilizado
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
    );
  }

  Widget _buildRadioButtonGroup({
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ),
        Wrap(
          spacing: 20.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.start,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: option,
                  groupValue: selectedValue,
                  onChanged: (value) => onChanged(value as String),
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  // 🔹 Campo de texto conectado al estado
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  String? _validateRequired(String? value) =>
      (value == null || value.isEmpty) ? 'Este campo es obligatorio' : null;

  String? _validateDate(String? value) =>
      DateTime.tryParse(value ?? '') == null ? 'Fecha inválida' : null;

  String? _validatePhone(String? value) =>
      (value == null || value.length < 7) ? 'Número inválido' : null;
}
