import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';

class EspecificacionesWidget extends ConsumerStatefulWidget {
  const EspecificacionesWidget({super.key});

  @override
  _EspecificacionesWidgetState createState() => _EspecificacionesWidgetState();
}

class _EspecificacionesWidgetState
    extends ConsumerState<EspecificacionesWidget> {
  late TextEditingController intensionComunicativaController;
  late TextEditingController traumatismoController;
  late TextEditingController infeccionesController;
  late TextEditingController reaccionesVacunasController;
  late TextEditingController desnutricionObesidadController;
  late TextEditingController cirugiasController;
  late TextEditingController convulsionesController;
  late TextEditingController medicacionController;
  late TextEditingController sindromesController;
  late TextEditingController observacionesController;
  late TextEditingController diagnosticStudiesController;

  @override
  void initState() {
    super.initState();
    intensionComunicativaController = TextEditingController();
    traumatismoController = TextEditingController();
    infeccionesController = TextEditingController();
    reaccionesVacunasController = TextEditingController();
    desnutricionObesidadController = TextEditingController();
    cirugiasController = TextEditingController();
    convulsionesController = TextEditingController();
    medicacionController = TextEditingController();
    sindromesController = TextEditingController();
    observacionesController = TextEditingController();
    diagnosticStudiesController = TextEditingController();
  }

  @override
  void dispose() {
    intensionComunicativaController.dispose();
    traumatismoController.dispose();
    infeccionesController.dispose();
    reaccionesVacunasController.dispose();
    desnutricionObesidadController.dispose();
    cirugiasController.dispose();
    convulsionesController.dispose();
    medicacionController.dispose();
    sindromesController.dispose();
    observacionesController.dispose();
    diagnosticStudiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hcState = ref.watch(hcGeneralProvider);
    final hcNotifier = ref.read(hcGeneralProvider.notifier);

    // Actualizar los controladores cuando el estado cambia
    intensionComunicativaController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .especificaciones
        .intensionComunicativaHospitalizaciones;
    traumatismoController.text = hcState.createHcGeneral.antecedentesPerinatales
        .antecedentesPostnatales.especificaciones.traumatismo;
    infeccionesController.text = hcState.createHcGeneral.antecedentesPerinatales
        .antecedentesPostnatales.especificaciones.infecciones;
    reaccionesVacunasController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .especificaciones
        .reaccionesPeculiaresVacunas;
    desnutricionObesidadController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .especificaciones
        .desnutricionOObesidad;
    cirugiasController.text = hcState.createHcGeneral.antecedentesPerinatales
        .antecedentesPostnatales.especificaciones.cirugias;
    convulsionesController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .especificaciones
        .convulsiones;
    medicacionController.text = hcState.createHcGeneral.antecedentesPerinatales
        .antecedentesPostnatales.especificaciones.medicacion;
    sindromesController.text = hcState.createHcGeneral.antecedentesPerinatales
        .antecedentesPostnatales.especificaciones.sindromes;
    observacionesController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .especificaciones
        .observaciones;
    diagnosticStudiesController.text = hcState
        .createHcGeneral
        .antecedentesPerinatales
        .antecedentesPostnatales
        .especificaciones
        .diagnosticStudies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection('ESPECIFICACIONES'),
        _buildMultilineFormField(
          label: 'Intensión comunicativa',
          controller: intensionComunicativaController,
          onChanged: hcNotifier.onIntensionComunicativaHospitalizacionesChanged,
        ),
        _buildMultilineFormField(
          label: 'Traumatismo',
          controller: traumatismoController,
          onChanged: hcNotifier.onEspecificacionesTraumatismoChanged,
        ),
        _buildMultilineFormField(
          label: 'Infecciones, alergias, otitis, farin......',
          controller: infeccionesController,
          onChanged: hcNotifier.onEspecificacionesInfeccionesChanged,
        ),
        _buildMultilineFormField(
          label: 'Reacciones peculiares vacunas',
          controller: reaccionesVacunasController,
          onChanged:
              hcNotifier.onEspecificacionesReaccionesPeculiaresVacunasChanged,
        ),
        _buildMultilineFormField(
          label: 'Desnutrición/Obesidad',
          controller: desnutricionObesidadController,
          onChanged: hcNotifier.onEspecificacionesDesnutricionOObesidadChanged,
        ),
        _buildMultilineFormField(
          label: 'Cirugías',
          controller: cirugiasController,
          onChanged: hcNotifier.onEspecificacionesCirugiasChanged,
        ),
        _buildMultilineFormField(
          label: 'Convulsiones fabriles o epilepsia.....',
          controller: convulsionesController,
          onChanged: hcNotifier.onEspecificacionesConvulcionesChanged,
        ),
        _buildMultilineFormField(
          label: 'Medicación',
          controller: medicacionController,
          onChanged: hcNotifier.onEspecificacionesMedicacionChanged,
        ),
        _buildMultilineFormField(
          label: 'Síndromes',
          controller: sindromesController,
          onChanged: hcNotifier.onEspecificacionesSindromesChanged,
        ),
        _buildMultilineFormField(
          label: 'Observaciones',
          controller: observacionesController,
          onChanged: hcNotifier.onEspecificacionesObservacionesChanged,
        ),
        _buildMultilineFormField(
          label: 'EEG, TAC, RM......',
          controller: diagnosticStudiesController,
          onChanged: hcNotifier.onEspecificacionesDiagnosticStudiesChanged,
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

  // 🔹 Campo de texto multilínea conectado al estado
  Widget _buildMultilineFormField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLines: 5, // Permite múltiples líneas para respuestas detalladas
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
}
