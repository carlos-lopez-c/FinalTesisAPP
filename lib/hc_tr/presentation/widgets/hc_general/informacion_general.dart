import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';

class DatosInformativosWidget extends ConsumerStatefulWidget {
  const DatosInformativosWidget({Key? key}) : super(key: key);

  @override
  _DatosInformativosWidgetState createState() =>
      _DatosInformativosWidgetState();
}

class _DatosInformativosWidgetState
    extends ConsumerState<DatosInformativosWidget> {
  late TextEditingController cedulaController;
  late TextEditingController fechaEntrevistaController;
  late TextEditingController nombreCompletoController;
  late TextEditingController fechaNacimientoController;
  late TextEditingController escolaridadController;
  late TextEditingController nombreInstitucionController;
  late TextEditingController domicilioController;
  late TextEditingController emailController;
  late TextEditingController telefonoController;
  late TextEditingController entrevistadoPorController;
  late TextEditingController remitidoPorController;
  late TextEditingController edadController;
  @override
  void initState() {
    super.initState();
    cedulaController = TextEditingController();
    fechaEntrevistaController = TextEditingController();
    nombreCompletoController = TextEditingController();
    fechaNacimientoController = TextEditingController();
    escolaridadController = TextEditingController();
    nombreInstitucionController = TextEditingController();
    domicilioController = TextEditingController();
    emailController = TextEditingController();
    telefonoController = TextEditingController();
    entrevistadoPorController = TextEditingController();
    remitidoPorController = TextEditingController();
    edadController = TextEditingController();
  }

  @override
  void dispose() {
    cedulaController.dispose();
    fechaEntrevistaController.dispose();
    nombreCompletoController.dispose();
    fechaNacimientoController.dispose();
    escolaridadController.dispose();
    nombreInstitucionController.dispose();
    domicilioController.dispose();
    emailController.dispose();
    telefonoController.dispose();
    entrevistadoPorController.dispose();
    remitidoPorController.dispose();
    edadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcState = ref.watch(hcGeneralProvider);
    final hcNotifier = ref.read(hcGeneralProvider.notifier);

    // Actualizar los controladores cuando el estado cambia
    cedulaController.text = hcState.cedula;
    fechaEntrevistaController.text = hcState.createHcGeneral.fechaEntrevista;
    nombreCompletoController.text = hcState.createHcGeneral.nombreCompleto;
    fechaNacimientoController.text = hcState.createHcGeneral.fechaNacimiento;
    escolaridadController.text = hcState.createHcGeneral.escolaridad;
    nombreInstitucionController.text =
        hcState.createHcGeneral.nombreDeInstitucion;
    domicilioController.text = hcState.createHcGeneral.domicilio;
    emailController.text = hcState.createHcGeneral.email;
    telefonoController.text = hcState.createHcGeneral.telefono;
    entrevistadoPorController.text = hcState.createHcGeneral.entrevistadoPor;
    remitidoPorController.text = hcState.createHcGeneral.remitidoPor;
    edadController.text = hcState.edad.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection('1.- DATOS INFORMATIVOS'),
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
                  hcNotifier.onSearchHcGeneral(hcState.cedula);
                }
              },
              child: const Text('Buscar'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildFormField(
          label: 'Fecha de la entrevista (dd/mm/aaaa)',
          controller: fechaEntrevistaController,
         
        ),
        _buildFormField(
          label: 'Nombre completo',
          disabled: true,
          controller: nombreCompletoController,
          onChanged: hcNotifier.onNombreCompletoChanged,
        ),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                disabled: true,
                label: 'Fecha de Nacimiento (dd/mm/aaaa)',
                controller: fechaNacimientoController,
                onChanged: hcNotifier.onFechaNacimientoChanged,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildFormField(
                label: 'Edad',
                disabled: true,
                controller: edadController,
              ),
            ),
          ],
        ),
        _buildRadioButtonGroup(
          title: 'Sexo',
          options: ['Masculino', 'Femenino', 'Otro'],
          selectedValue: hcState.createHcGeneral.sexo,
          onChanged: hcNotifier.onSexoChanged,
        ),
        _buildFormField(
          label: 'Escolaridad',
          controller: escolaridadController,
          onChanged: hcNotifier.onEscolaridadChanged,
        ),
        _buildFormField(
          label: 'Nombre de la Institución',
          controller: nombreInstitucionController,
          onChanged: hcNotifier.onNombreDeInstitucionChanged,
        ),
        const Divider(),
        _buildRadioButtonGroup(
          title: 'Tipo de Institución',
          options: ['Particular', 'Fiscal', 'Municipal', 'Fiscomisional'],
          selectedValue: hcState.createHcGeneral.tipoDeInstitucion,
          onChanged: hcNotifier.onTipoDeInstitucionChanged,
        ),
        const Divider(),
        _buildFormField(
          label: 'Domicilio',
          controller: domicilioController,
          onChanged: hcNotifier.onDomicilioChanged,
        ),
        _buildFormField(
          label: 'Email',
          controller: emailController,
          onChanged: hcNotifier.onEmailChanged,
        ),
        _buildFormField(
          label: 'Teléfono',
          controller: telefonoController,
          onChanged: hcNotifier.onTelefonoChanged,
        ),
        _buildFormField(
          label: 'Entrevistado por',
          controller: entrevistadoPorController,
          onChanged: hcNotifier.onEntrevistadoPorChanged,
        ),
        _buildFormField(
          label: 'Remitido por',
          controller: remitidoPorController,
          onChanged: hcNotifier.onRemitidoPorChanged,
        ),
      ],
    );
  }

  // 🔹 Función para generar un campo de formulario conectado al estado
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    bool? disabled = false,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        enabled: !disabled!,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorStyle: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  // 🔹 Función para generar un grupo de botones de radio conectado al estado
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

  // 🔹 Sección con título estilizado
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
