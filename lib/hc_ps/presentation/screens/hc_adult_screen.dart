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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text(
          'Historia Clínica Psicológica Adultos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            headerPSWidget(
                textoDinamico: 'HISTORIA CLÍNICA PSICOLÓGICA ADULTOS'),
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
                      'Tipo de registro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Radio buttons
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Nuevo',
                              groupValue: hcState.tipo,
                              onChanged: (value) =>
                                  hcNotifier.onTipoChanged(value ?? 'Nuevo'),
                              activeColor: const Color(0xFF1976D2),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            const SizedBox(width: 4),
                            const Text('Nuevo'),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Buscar',
                              groupValue: hcState.tipo,
                              onChanged: (value) =>
                                  hcNotifier.onTipoChanged(value ?? 'Buscar'),
                              activeColor: const Color(0xFF1976D2),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            const SizedBox(width: 4),
                            const Text('Buscar'),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Campo de búsqueda
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: cedulaController,
                            onChanged: hcNotifier.onCedulaChanged,
                            decoration: const InputDecoration(
                              labelText: 'Buscar por cédula',
                              labelStyle: TextStyle(color: Color(0xFF1976D2)),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: Color(0xFF1976D2)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: Color(0xFF1976D2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: Color(0xFF1976D2), width: 2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (hcState.tipo == 'Nuevo') {
                              print(
                                  '🔹Holaaa Buscando paciente por DNI: ${hcState.cedula}');
                              hcNotifier.getPacienteByDni(hcState.cedula);
                            } else {
                              hcNotifier.onSearchHcPsAdult(hcState.cedula);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1976D2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Buscar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                      '1.- Datos personales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      disabled: true,
                      controller: nombreCompletoController,
                      label: 'Nombre completo',
                      onChanged: hcNotifier.setNombreCompleto,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: hcState.status == 'Editado' ? true : false,
                      label: 'Fecha de nacimiento (dd/mm/aaaa)',
                      controller: fechaNacimientoController,
                      onChanged: hcNotifier.setFechaNacimiento,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: hcState.status == 'Editado' ? true : false,
                      label: 'Teléfono',
                      controller: telefonoController,
                      onChanged: hcNotifier.setTelefono,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: hcState.status == 'Editado' ? true : false,
                      label: 'Institución',
                      controller: institucionController,
                      onChanged: hcNotifier.setInstitucion,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: hcState.status == 'Editado' ? true : false,
                      label: 'Dirección',
                      controller: direccionController,
                      onChanged: hcNotifier.setDireccion,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: hcState.status == 'Editado' ? true : false,
                      label: 'Remisión',
                      controller: remisionController,
                      onChanged: hcNotifier.setRemision,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: true,
                      label: 'Fecha de evaluación (dd/mm/aaaa)',
                      controller: fechaEvaluacionController,
                      onChanged: hcNotifier.setFechaEvaluacion,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: hcState.status == 'Editado' ? true : false,
                      label: 'Final de cobertura',
                      controller: coberturaController,
                      onChanged: hcNotifier.setCobertura,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: hcState.status == 'Editado' ? true : false,
                      label: 'Observaciones',
                      controller: observacionesController,
                      onChanged: hcNotifier.setObservaciones,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      disabled: hcState.status == 'Editado' ? true : false,
                      label: 'Responsable',
                      controller: responsableController,
                      onChanged: hcNotifier.setResponsable,
                    ),
                  ],
                ),
              ),
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
                      '2.- Motivo de consulta',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Describa el motivo de la consulta',
                      controller: motivoConsultaController,
                      onChanged: hcNotifier.setMotivoConsulta,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
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
                      '3.- Desencadenantes del motivo de consulta',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Describa los desencadenantes',
                      controller: desencadenantesController,
                      onChanged: hcNotifier.setDesencadenantesMotivoConsulta,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
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
                      '4.- Antecedentes familiares',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Describa los antecedentes familiares',
                      controller: antecedentesFamiliaresController,
                      onChanged: hcNotifier.setAntecedenteFamiliares,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
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
                      '5.- Pruebas aplicadas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Describa las pruebas aplicadas',
                      controller: pruebasAplicadasController,
                      onChanged: hcNotifier.setPruebasAplicadas,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
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
                      '6.- Impresión diagnóstica',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Describa la impresión diagnóstica',
                      controller: impresionDiagnosticaController,
                      onChanged: hcNotifier.setImpresionDiagnostica,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
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
                      '7.- Áreas de intervención',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Describa las áreas de intervención',
                      controller: areasIntervencionController,
                      onChanged: hcNotifier.setAreasIntervencion,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const GenerarPdfButton(),
          ],
        ),
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
