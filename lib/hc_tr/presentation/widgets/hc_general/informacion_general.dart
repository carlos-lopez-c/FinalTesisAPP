import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';
import 'package:intl/intl.dart';

class DatosInformativosWidget extends ConsumerStatefulWidget {
  const DatosInformativosWidget({super.key});

  @override
  ConsumerState<DatosInformativosWidget> createState() =>
      _DatosInformativosWidgetState();
}

class _DatosInformativosWidgetState
    extends ConsumerState<DatosInformativosWidget> {
  late TextEditingController _cedulaController;
  late TextEditingController _nombreCompletoController;
  late TextEditingController _escolaridadController;
  late TextEditingController _nombreInstitucionController;
  late TextEditingController _fechaNacimientoController;
  late TextEditingController _fechaEntrevistaController;
  late TextEditingController _domicilioController;
  late TextEditingController _emailController;
  late TextEditingController _telefonoController;
  late TextEditingController _entrevistadoPorController;
  late TextEditingController _remitidoPorController;
  late TextEditingController _edadController;

  @override
  void initState() {
    super.initState();

    _cedulaController = TextEditingController();
    _nombreCompletoController = TextEditingController();
    _escolaridadController = TextEditingController();
    _nombreInstitucionController = TextEditingController();
    _fechaNacimientoController = TextEditingController();
    _fechaEntrevistaController = TextEditingController();
    _domicilioController = TextEditingController();
    _emailController = TextEditingController();
    _telefonoController = TextEditingController();
    _entrevistadoPorController = TextEditingController();
    _remitidoPorController = TextEditingController();
    _edadController = TextEditingController();
  }

  @override
  void dispose() {
    _cedulaController.dispose();
    _nombreCompletoController.dispose();
    _escolaridadController.dispose();
    _fechaNacimientoController.dispose();
    _fechaEntrevistaController.dispose();
    _nombreInstitucionController.dispose();
    _domicilioController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _entrevistadoPorController.dispose();
    _remitidoPorController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcNotifier = ref.watch(hcGeneralProvider.notifier);
    final hcState = ref.watch(hcGeneralProvider);

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
    _nombreCompletoController.text = hcState.createHcGeneral.nombreCompleto;
    _escolaridadController.text = hcState.createHcGeneral.escolaridad;
    _nombreInstitucionController.text =
        hcState.createHcGeneral.nombreDeInstitucion;
    _fechaNacimientoController.text =
        hcState.createHcGeneral.fechaNacimiento.isEmpty
            ? ''
            : DateFormat('dd/MM/yyyy')
                .format(_tryParseDate(hcState.createHcGeneral.fechaNacimiento));
    _fechaEntrevistaController.text = DateFormat('dd/MM/yyyy')
        .format(_tryParseDate(hcState.createHcGeneral.fechaEntrevista));
    _domicilioController.text = hcState.createHcGeneral.domicilio;
    _emailController.text = hcState.createHcGeneral.email;
    _telefonoController.text = hcState.createHcGeneral.telefono;
    _entrevistadoPorController.text = hcState.createHcGeneral.entrevistadoPor;
    _remitidoPorController.text = hcState.createHcGeneral.remitidoPor;
    _edadController.text = hcState.edad.toString();

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
              '1.- DATOS INFORMATIVOS',
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
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    if (hcState.tipo == 'Nuevo') {
                      hcNotifier.getPacienteByDni(hcState.cedula);
                    } else {
                      hcNotifier.onSearchHcGeneral(hcState.cedula);
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
            _buildTextField(
              disabled: true,
              label: 'Fecha de la entrevista',
              controller: _fechaEntrevistaController,
              value: hcState.createHcGeneral.fechaEntrevista != null &&
                      hcState.createHcGeneral.fechaEntrevista!.isNotEmpty
                  ? DateFormat('dd/MM/yyyy').format(
                      _tryParseDate(hcState.createHcGeneral.fechaEntrevista))
                  : '',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              disabled: true,
              label: 'Nombre completo',
              controller: _nombreCompletoController,
              onChanged: hcNotifier.onNombreCompletoChanged,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    disabled: true,
                    controller: _fechaNacimientoController,
                    label: 'Fecha de Nacimiento',
                    value: hcState.createHcGeneral.fechaNacimiento != null &&
                            hcState.createHcGeneral.fechaNacimiento!.isNotEmpty
                        ? DateFormat('dd/MM/yyyy').format(_tryParseDate(
                            hcState.createHcGeneral.fechaNacimiento))
                        : '',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _edadController,
                    disabled: true,
                    label: 'Edad',
                    value: hcState.edad.toString(),
                    onChanged: null,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildRadioButtonGroup(
              disabled: true,
              title: 'Sexo',
              options: ['Masculino', 'Femenino', 'Otro'],
              selectedValue: hcState.createHcGeneral.sexo,
              onChanged: hcNotifier.onSexoChanged,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Escolaridad',
              controller: _escolaridadController,
              onChanged: hcNotifier.onEscolaridadChanged,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Nombre de la Institución',
              controller: _nombreInstitucionController,
              onChanged: hcNotifier.onNombreDeInstitucionChanged,
            ),
            const SizedBox(height: 12),
            _buildRadioButtonGroup(
              title: 'Tipo de Institución',
              options: ['Particular', 'Fiscal', 'Municipal', 'Fiscomisional'],
              selectedValue: hcState.createHcGeneral.tipoDeInstitucion,
              onChanged: hcNotifier.onTipoDeInstitucionChanged,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Domicilio',
              controller: _domicilioController,
              onChanged: hcNotifier.onDomicilioChanged,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              onChanged: hcNotifier.onEmailChanged,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Teléfono',
              controller: _telefonoController,
              onChanged: hcNotifier.onTelefonoChanged,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Entrevistado por',
              controller: _entrevistadoPorController,
              onChanged: hcNotifier.onEntrevistadoPorChanged,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Remitido por',
              controller: _remitidoPorController,
              onChanged: hcNotifier.onRemitidoPorChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    String? value,
    Function(String)? onChanged,
    TextInputType? keyboardType,
    bool disabled = false,
    bool readOnly = false,
  }) {
    return TextFormField(
      enabled: !disabled,
      controller: controller,
      initialValue: controller == null ? value ?? '' : null,
      onChanged: onChanged,
      keyboardType: keyboardType,
      readOnly: readOnly,
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

  Widget _buildDateField({
    required BuildContext context,
    required String label,
    required DateTime? value,
    required Function(DateTime?) onChanged,
  }) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF1976D2),
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: InputDecorator(
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
          suffixIcon:
              const Icon(Icons.calendar_today, color: Color(0xFF1976D2)),
        ),
        child: Text(
          value != null
              ? DateFormat('dd/MM/yyyy').format(value)
              : 'Seleccionar fecha',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup({
    required String title,
    bool disabled = false,
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Color(0xFF1976D2),
            ),
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
                  onChanged: disabled
                      ? null
                      : (value) {
                          onChanged(value as String);
                        }, // Cambiar a bool?
                  activeColor: const Color(0xFF1976D2),
                ),
                Text(
                  option,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
