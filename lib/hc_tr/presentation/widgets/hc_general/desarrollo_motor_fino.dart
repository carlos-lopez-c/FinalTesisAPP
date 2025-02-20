import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';

class DesarrolloMotorFino extends ConsumerWidget {
  const DesarrolloMotorFino({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hcState = ref.watch(hcGeneralProvider);
    final hcNotifier = ref.read(hcGeneralProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: _buildSection('DESARROLLO MOTOR FINO'),
        ),
        Container(
          height: 3.0, // Ajusta el grosor vertical del divisor
          width:
              100.0, // Ajusta el ancho horizontal del divisor, o usa double.infinity para ocupar todo el espacio disponible
          color: const Color.fromARGB(112, 75, 107, 176), // Color del divisor
        ),

        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Pinza digital",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.pinzaDigital,
          onChanged: hcNotifier.onPinzaDigitalChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Garabateo",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.garabateo,
          onChanged: hcNotifier.onGarabateoChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Sostener objetos",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.sostenerObjetos,
          onChanged: hcNotifier.onSostenerObjetosChanged,
        ),

        SizedBox(height: 10),
        Container(
          color: Colors.yellow,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: const Text(
            'TEA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),

        _buildRadioButtonGroupBool(
          title: "Problemas alimenticios",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .problemasAlimenticios,
          onChanged: hcNotifier.onProblemasAlimenticiosChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Garabato",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.garabato,
          onChanged: hcNotifier.onGarabatoChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Tics motores",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.ticsMotores,
          onChanged: hcNotifier.onTicsMotoresChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Tics vocales",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.ticsVocales,
          onChanged: hcNotifier.onTicsVocalesChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Conductas problemáticas",
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .conductasProblematicas,
          onChanged: hcNotifier.onConductasProblematicasChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Sonrisa social",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.sonrisaSocial,
          onChanged: hcNotifier.onSonrisaSocialChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Movimientos estereotipados",
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .movimientosEstereotipados,
          onChanged: hcNotifier.onMovimientosEstereotipadosChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Manipula permanentemente un objeto",
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .manipulaPermanentementeUnObjeto,
          onChanged: hcNotifier.onManipulaPermanentementeUnObjetoChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Balanceos",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.balanceos,
          onChanged: hcNotifier.onBalanceosChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Juego repetitivo",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.juegoRepetitivo,
          onChanged: hcNotifier.onJuegoRepetitivoChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Tendencia a rutinas",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.tendenciaARutinas,
          onChanged: hcNotifier.onTendenciaARutinasChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Camina sin sentido",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.caminaSinSentido,
          onChanged: hcNotifier.onCaminaSinSentidoChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Problemas de sueño",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.problemaDeSueno,
          onChanged: hcNotifier.onProblemaDeSuenoChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Reitera temas favoritos",
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .reiteraTemasFavoritos,
          onChanged: hcNotifier.onReiteraTemasFavoritosChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Camina en puntitas",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.caminaEnPuntitas,
          onChanged: hcNotifier.onCaminaEnPuntitasChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Irritabilidad",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.irritabilidad,
          onChanged: hcNotifier.onIrritabilidadChanged,
        ),
        _buildRadioButtonGroupBool(
          title: "Manipula permanentemente algo:",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .manipulaPermanentementeAlgo,
          onChanged: hcNotifier.onManipulaPermanentementeAlgoChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Inicia y mantiene conversación:",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .iniciaYMantieneConversaciones,
          onChanged: hcNotifier.onIniciaYMantieneConversacionesChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Ecolalia:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.ecolalia,
          onChanged: hcNotifier.onEcolaliaChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Conocimiento de algún tema:",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .conocimientoDeAlgunTema,
          onChanged: hcNotifier.onConocimientoDeAlgunTemaChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Lenguaje literal:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.lenguajeLiteral,
          onChanged: hcNotifier.onLenguajeLiteralChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Mira a los ojos:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.miraALosOjos,
          onChanged: hcNotifier.onMiraALosOjosChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Otros sistemas de comunicación:",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .otrosSistemasDeComunicacion,
          onChanged: hcNotifier.onOtrosSistemasDeComunicacionChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Selectivo en la comida:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.selectivoEnLaComida,
          onChanged: hcNotifier.onSelectivoEnLaComidaChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Intención comunicativa:",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .intencionComunicativa,
          onChanged: hcNotifier.onIntencionComunicativaChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Interés restringido:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.interesRestringido,
          onChanged: hcNotifier.onInteresRestringidoChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Angustia sin causa:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.angustiaSinCausa,
          onChanged: hcNotifier.onAngustiaSinCausaChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Preferencia por algún alimento:",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .preferenciaPorAlgunAlimento,
          onChanged: hcNotifier.onPreferenciaPorAlgunAlimentoChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Sonidos extraños:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.sonidosExtranos,
          onChanged: hcNotifier.onSonidosExtranosChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Habla como adulto:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.hablaComoAdulto,
          onChanged: hcNotifier.onHablaComoAdultoChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Frío para hablar:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.frioParaHablar,
          onChanged: hcNotifier.onFrioParaHablarChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Pensamiento obsesivo:",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .pensamientosObsesivos,
          onChanged: hcNotifier.onPensamientosObsesivosChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Cambio de carácter extremo:",
          options: ["SI", "NO"],
          selectedValue: hcState
              .createHcGeneral
              .antecedentesPerinatales
              .antecedentesPostnatales
              .desarrolloMotorFino
              .cambioDeCaracterExtremo,
          onChanged: hcNotifier.onCambioDeCaracterExtremoChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Ingenuo:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.ingenuo,
          onChanged: hcNotifier.onIngenuoChanged,
        ),
        const SizedBox(height: 10),
        _buildRadioButtonGroupBool(
          title: "Torpeza motriz:",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.torpezaMotriz,
          onChanged: hcNotifier.onTorpezaMotrizChanged,
        ),

        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Frío emocional",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.frioEmocional,
          onChanged: hcNotifier.onFrioEmocionalChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Pocos amigos",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.pocosAmigos,
          onChanged: hcNotifier.onPocosAmigosChanged,
        ),
        _buildRadioButtonGroupBool(
          options: ["SI", "NO"],
          title: "Juego imaginativo",
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.desarrolloMotorFino.juegoImaginativo,
          onChanged: hcNotifier.onJuegoImaginativoChanged,
        ),

        // ✅ Sección de Reflejos Primitivos
        Center(child: _buildSection('REFLEJOS PRIMITIVOS')),
        Container(
          height: 3.0,
          width: 100.0,
          color: const Color.fromARGB(112, 75, 107, 176),
        ),

        _buildRadioButtonGroupBool(
          title: "Palmar - Plantar",
          options: ["SI", "NO"],
          selectedValue: hcState.createHcGeneral.antecedentesPerinatales
              .antecedentesPostnatales.reflejosPrimitivos.palmar,
          onChanged: hcNotifier.onPalmarChanged,
        ),
        _buildRadioButtonGroupBool(
            title: "Moro",
            options: ["SI", "NO"],
            selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos.moro,
            onChanged: (value) => hcNotifier.onMoroChanged(value)),
        _buildRadioButtonGroupBool(
            title: "Presión",
            options: ["SI", "NO"],
            selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos.presion,
            onChanged: hcNotifier.onPresionChanged),
        _buildRadioButtonGroupBool(
            title: "De búsqueda",
            options: ["SI", "NO"],
            selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos.deBusqueda,
            onChanged: (value) => hcNotifier.onDeBusquedaChanged(value)),
        _buildRadioButtonGroupBool(
            title: "Banbiski",
            options: ["SI", "NO"],
            selectedValue: hcState.createHcGeneral.antecedentesPerinatales
                .antecedentesPostnatales.reflejosPrimitivos.banbiski,
            onChanged: (value) => hcNotifier.onBanbiskiChanged(value)),
      ],
    );
  }

  // 🔹 Sección con título estilizado
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
    );
  }

  // 🔹 Grupo de checkbox en línea
  Widget _buildInlineCheckboxGroup({
    required String title,
    required List<String> options,
    required List<bool> selectedValues,
    required List<Function(bool)> onChangedList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        Wrap(
          spacing: 10.0,
          children: List.generate(options.length, (index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: selectedValues[index],
                  onChanged: (value) {
                    if (value != null) {
                      onChangedList[index](value);
                    }
                  },
                ),
                Text(options[index]),
              ],
            );
          }),
        ),
      ],
    );
  }

  // 🔹 Grupo de botones de radio

  Widget _buildRadioButtonGroupBool({
    required String title,
    required List<String> options,
    required bool? selectedValue,
    required Function(bool) onChanged,
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
                  value: option == "SI",
                  groupValue: selectedValue,
                  onChanged: (value) => onChanged(value as bool),
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
