import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/presentation/providers/hc_ps_form_provider.dart';
import '../widgets/headerPS.dart';
import '../widgets/GenerarPdfButton.dart';

class HistoriaClinicaAdultPS extends ConsumerStatefulWidget {
  const HistoriaClinicaAdultPS({Key? key}) : super(key: key);

  @override
  _HistoriaClinicaAdultPSState createState() => _HistoriaClinicaAdultPSState();
}

class _HistoriaClinicaAdultPSState
    extends ConsumerState<HistoriaClinicaAdultPS> {
  bool _hasShownMessage = false;

  late TextEditingController cedulaController;
  late TextEditingController fechaEvaluacionController;
  late TextEditingController nombreCompletoController;
  late TextEditingController fechaNacimientoController;
  late TextEditingController telefonoController;
  late TextEditingController institucionController;
  late TextEditingController direccionController;
  late TextEditingController remisionController;
  late TextEditingController coberturaController;
  late TextEditingController observacionesController;
  late TextEditingController responsableController;
  late TextEditingController motivoConsultaController;
  late TextEditingController desencadenantesController;
  late TextEditingController antecedentesFamiliaresController;
  late TextEditingController pruebasAplicadasController;
  late TextEditingController impresionDiagnosticaController;
  late TextEditingController areasIntervencionController;
  late TextEditingController edadController;
  late TextEditingController estructuraFamiliarController;

  @override
  void initState() {
    super.initState();
    cedulaController = TextEditingController();
    fechaEvaluacionController = TextEditingController();
    nombreCompletoController = TextEditingController();
    fechaNacimientoController = TextEditingController();
    telefonoController = TextEditingController();
    institucionController = TextEditingController();
    direccionController = TextEditingController();
    remisionController = TextEditingController();
    coberturaController = TextEditingController();
    observacionesController = TextEditingController();
    responsableController = TextEditingController();
    motivoConsultaController = TextEditingController();
    desencadenantesController = TextEditingController();
    antecedentesFamiliaresController = TextEditingController();
    pruebasAplicadasController = TextEditingController();
    impresionDiagnosticaController = TextEditingController();
    areasIntervencionController = TextEditingController();
    edadController = TextEditingController();
    estructuraFamiliarController = TextEditingController();
  }

  @override
  void dispose() {
    cedulaController.dispose();
    fechaEvaluacionController.dispose();
    nombreCompletoController.dispose();
    fechaNacimientoController.dispose();
    telefonoController.dispose();
    institucionController.dispose();
    direccionController.dispose();
    remisionController.dispose();
    coberturaController.dispose();
    observacionesController.dispose();
    responsableController.dispose();
    motivoConsultaController.dispose();
    desencadenantesController.dispose();
    antecedentesFamiliaresController.dispose();
    pruebasAplicadasController.dispose();
    impresionDiagnosticaController.dispose();
    areasIntervencionController.dispose();
    edadController.dispose();
    estructuraFamiliarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcState = ref.watch(hcPsAdultFormProvider);
    final hcNotifier = ref.read(hcPsAdultFormProvider.notifier);

    // Agregar listener para mensajes de éxito y error
    ref.listen<HcFormAdultState?>(hcPsAdultFormProvider, (previous, next) {
      if (!_hasShownMessage) {
        if (next!.successMessage.isNotEmpty) {
          _hasShownMessage = true;
          _showSnackBar(context, next.successMessage, true);
          Future.delayed(const Duration(seconds: 2), () {
            ref.read(hcPsAdultFormProvider.notifier).clearSuccessMessage();
            _hasShownMessage = false;
          });
        } else if (next.errorMessage.isNotEmpty) {
          _hasShownMessage = true;
          _showSnackBar(context, next.errorMessage, false);
          Future.delayed(const Duration(seconds: 2), () {
            ref.read(hcPsAdultFormProvider.notifier).clearErrorMessage();
            _hasShownMessage = false;
          });
        }
      }
    });

    // Actualizar controladores con los valores del estado
    cedulaController.text = hcState.cedula;
    fechaEvaluacionController.text = hcState.createHcPsAdult.fechaEvalucion;
    nombreCompletoController.text = hcState.createHcPsAdult.nombreCompleto;
    fechaNacimientoController.text = hcState.createHcPsAdult.fechaNacimiento;
    telefonoController.text = hcState.createHcPsAdult.telefono;
    institucionController.text = hcState.createHcPsAdult.institucion;
    direccionController.text = hcState.createHcPsAdult.direccion;
    remisionController.text = hcState.createHcPsAdult.remision;
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
    edadController.text = hcState.createHcPsAdult.edad ?? '';
    estructuraFamiliarController.text =
        hcState.createHcPsAdult.estructuraFamiliar;

    // Determinar si los campos fijos deben ser solo lectura
    final readOnlyDatosFijos = hcState.tipo == 'Buscar/Editar';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text(
          'Historia Clínica de Adultos - Psicología',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          headerPSWidget(
            textoDinamico: 'HISTORIA CLÍNICA DE ADULTOS - PSICOLOGÍA',
          ),
          const SizedBox(height: 20),
          Card(
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
                    'Tipo de Registro',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Nuevo',
                        groupValue: hcState.tipo,
                        onChanged: (value) =>
                            hcNotifier.onTipoChanged(value ?? 'Nuevo'),
                        activeColor: const Color(0xFF1976D2),
                      ),
                      const Text('Nuevo', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 24),
                      Radio<String>(
                        value: 'Buscar/Editar',
                        groupValue: hcState.tipo,
                        onChanged: (value) =>
                            hcNotifier.onTipoChanged(value ?? 'Buscar/Editar'),
                        activeColor: const Color(0xFF1976D2),
                      ),
                      const Text('Buscar/Editar',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
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
                        child: _buildFormField(
                          label: 'Cédula',
                          controller: cedulaController,
                          onChanged: hcNotifier.onCedulaChanged,
                          disabled: false,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (hcState.tipo == 'Nuevo') {
                            hcNotifier.getPacienteByDni(cedulaController.text);
                          } else {
                            hcNotifier.onSearchHcPsAdult(cedulaController.text);
                          }
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
                  _buildFormField(
                    label: 'Nombre completo',
                    controller: nombreCompletoController,
                    onChanged: hcNotifier.setNombreCompleto,
                    disabled: readOnlyDatosFijos,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFormField(
                          label: 'Fecha de nacimiento (dd/mm/aaaa)',
                          controller: fechaNacimientoController,
                          onChanged: hcNotifier.setFechaNacimiento,
                          disabled: readOnlyDatosFijos,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFormField(
                          label: 'Edad',
                          controller: edadController,
                          onChanged: hcNotifier.setEdad,
                          disabled: readOnlyDatosFijos,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildFormField(
                    label: 'Teléfono',
                    controller: telefonoController,
                    onChanged: hcNotifier.setTelefono,
                    disabled: false,
                  ),
                  const SizedBox(height: 12),
                  _buildFormField(
                    label: 'Institución',
                    controller: institucionController,
                    onChanged: hcNotifier.setInstitucion,
                    disabled: false,
                  ),
                  const SizedBox(height: 12),
                  _buildFormField(
                    label: 'Dirección',
                    controller: direccionController,
                    onChanged: hcNotifier.setDireccion,
                    disabled: false,
                  ),
                  const SizedBox(height: 12),
                  _buildFormField(
                    label: 'Remisión',
                    controller: remisionController,
                    onChanged: hcNotifier.setRemision,
                    disabled: false,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFormField(
                          label: 'Fecha de evaluación (dd/mm/aaaa)',
                          controller: fechaEvaluacionController,
                          onChanged: hcNotifier.setFechaEvaluacion,
                          disabled: readOnlyDatosFijos,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFormField(
                          label: 'Responsable',
                          controller: responsableController,
                          onChanged: hcNotifier.setResponsable,
                          disabled: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildFormField(
                    label: 'Final de cobertura',
                    controller: coberturaController,
                    onChanged: hcNotifier.setCobertura,
                    disabled: false,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2.- Motivo de consulta',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1976D2))),
                  const SizedBox(height: 8),
                  _buildFormField(
                    label: 'Motivo de consulta',
                    controller: motivoConsultaController,
                    onChanged: hcNotifier.setMotivoConsulta,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('3.- Desencadenantes de motivo de consulta',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1976D2))),
                  const SizedBox(height: 8),
                  _buildFormField(
                    label: 'Desencadenantes de motivo de consulta',
                    controller: desencadenantesController,
                    onChanged: hcNotifier.setDesencadenantesMotivoConsulta,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('4.- Antecedentes familiares',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1976D2))),
                  const SizedBox(height: 8),
                  _buildFormField(
                    label: 'Antecedentes familiares',
                    controller: antecedentesFamiliaresController,
                    onChanged: hcNotifier.setAntecedenteFamiliares,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('5.- Antecedentes y estructura familiar',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1976D2))),
                  const SizedBox(height: 8),
                  _buildFormField(
                    label: 'Antecedentes y estructura familiar',
                    controller: estructuraFamiliarController,
                    onChanged: hcNotifier.setEstructuraFamiliar,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('6.- Pruebas aplicadas',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1976D2))),
                  const SizedBox(height: 8),
                  _buildFormField(
                    label: 'Pruebas aplicadas',
                    controller: pruebasAplicadasController,
                    onChanged: hcNotifier.setPruebasAplicadas,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('7.- Impresión diagnóstica',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1976D2))),
                  const SizedBox(height: 8),
                  _buildFormField(
                    label: 'Impresión diagnóstica',
                    controller: impresionDiagnosticaController,
                    onChanged: hcNotifier.setImpresionDiagnostica,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('8.- Áreas de intervención',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1976D2))),
                  const SizedBox(height: 8),
                  _buildFormField(
                    label: 'Áreas de intervención',
                    controller: areasIntervencionController,
                    onChanged: hcNotifier.setAreasIntervencion,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (hcState.tipo == 'Nuevo') {
            hcNotifier.onCreateHcPsAdult(context);
          } else {
            hcNotifier.onUpdateHcPsAdult(context);
          }
        },
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    bool disabled = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      enabled: !disabled,
      onChanged: disabled
          ? null
          : onChanged, // Solo pasa el callback si está habilitado
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF1976D2)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1976D2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1976D2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
        const SizedBox(height: 8),
        ...options.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: selectedValue,
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            activeColor: const Color(0xFF1976D2),
          );
        }).toList(),
      ],
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
