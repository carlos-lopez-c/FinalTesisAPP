import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/presentation/providers/hc_form_general_provider.dart';
import '/hc_tr/presentation/widgets/headerBusqueda.dart';

class SearchHcTrGeneral extends ConsumerWidget { 
  
  const SearchHcTrGeneral({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {  
    final hcGeneralProviderNotifier = ref.watch(hcGeneralProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Area de Terapias',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          headerSHTRWidget(
            textoDinamico: 'historia clinica general ',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Campo de búsqueda
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Buscar paciente...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Botón de búsqueda
              ElevatedButton(
                onPressed: () {
                  // Lógica para realizar la búsqueda
                  print('Buscar paciente');
                },
                child: const Text('Buscar'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection('1.- DATOS INFORMATIVOS'),
    _buildDatePickerField('Fecha de la entrevista', context, hcGeneralProviderNotifier),
          _buildFormField('Evaluador'),
          _buildFormField('Nombre completo'),
          Row(
            children: [
              Expanded(child: _buildFormField('Fecha de Nacimiento')),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Edad: XX',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          _buildRadioButtonGroup('Sexo', ['Masculino', 'Femenino', 'Otro']),
          _buildFormField('Escolaridad'),
          _buildFormField('Nombre de la Institución'),
          Divider(),
          _buildRadioButtonGroup('Tipo de Institucion',
              ['Particular', 'Fiscal', 'Municipal', 'Fiscomisional']),
          Divider(),
          _buildFormField('Domicilio'),
          _buildFormField('Email'),
          _buildFormField('Teléfono'),
          _buildFormField('Entrevistado por'),
          _buildFormField('Remitido por'),
          Divider(),
          _buildSection('2.- MOTIVO DE CONSULTA'),
          MaxlineSection('Motivo de consulta'),
          Divider(),
          _buildSection('3.- CARACTERIZACIÓN DEL PROBLEMA'),
          MaxlineSection('Descripción del problema'),
          Divider(),
          _buildSection('4.- ANTECEDENTES PERSONALES'),
          _buildSection('      4.1. ANTECEDENTES PRENATALES'),
          _buildCheckboxList('Deseado / Planificado', false),
          _buildCheckboxList('Automedicación', false),
          _buildCheckboxList('Depresión', false),
          _buildCheckboxList('Estrés', false),
          _buildCheckboxList('Ansiedad', false),
          _buildCheckboxList('Traumatismo', false),
          _buildCheckboxList('Radiaciones', false),
          _buildCheckboxList('Medicina', false),
          _buildCheckboxList('Riesgos de aborto', false),
          _buildCheckboxList('Maltrato físico', false),
          _buildCheckboxList('Matrato psicológico', false),
          _buildCheckboxList('Consumo de drogas', false),
          _buildCheckboxList('Consumo de alcohol', false),
          _buildCheckboxList('Consumo de tabaco', false),
          _buildCheckboxList('Hipertensión', false),
          _buildCheckboxList('Dieta balanceada', false),
          _buildSection('      4.2. ANTECEDENTES PERINATALES'),
          InlineCheckboxGroup(
            "Tipo de parto:",
            [
              {"title": "Normal", "value": false, "onChanged": (val) {}},
              {"title": "Fórceps", "value": false, "onChanged": (val) {}},
              {"title": "Cesárea", "value": false, "onChanged": (val) {}},
            ],
          ),
          Divider(),
          InlineCheckboxGroup(
            "Duración del parto:",
            [
              {"title": "Breve", "value": false, "onChanged": (val) {}},
              {"title": "Normal", "value": false, "onChanged": (val) {}},
              {"title": "Prolongado", "value": false, "onChanged": (val) {}},
            ],
          ),
          Divider(),
          InlineCheckboxGroup(
            "Presentación:",
            [
              {"title": "Cefálico", "value": false, "onChanged": (val) {}},
              {"title": "Podálico", "value": false, "onChanged": (val) {}},
              {"title": "Tranverso", "value": false, "onChanged": (val) {}},
            ],
          ),
          Divider(),
          _buildRadioButtonGroup('Lloro al nacer', ['SI', 'NO']),
          Divider(),
          _buildRadioButtonGroup('Sufrimiento fetal', ['SI', 'NO']),
          Divider(),
          InlineCheckboxGroup(
            "Al nacer necesito:",
            [
              {"title": "Oxigeno", "value": false, "onChanged": (val) {}},
              {"title": "Incubadora", "value": false, "onChanged": (val) {}},
            ],
          ),
          _buildFormField('Tiempo'),
          Divider(),
          InlineCheckboxGroup(
            "Al nacer presento:",
            [
              {"title": "Cianosis", "value": false, "onChanged": (val) {}},
              {"title": "Ictericia", "value": false, "onChanged": (val) {}},
              {"title": "Malformacion", "value": false, "onChanged": (val) {}},
              {
                "title": "Circulación del cordón en el cuello",
                "value": false,
                "onChanged": (val) {}
              },
              {
                "title": "Sufrimiento fetal",
                "value": false,
                "onChanged": (val) {}
              },
            ],
          ),
          _buildFormField('Peso'),
          _buildFormField('Talla'),
          _buildFormField('Perímetro cefálico'),
          _buildFormField('Apgar'),
          Divider(),
          _buildSection('Observaciones'),
          MaxlineSection('Obersevaciones.................................'),
          Divider(),
          _buildSection('4.3. ANTECEDENTES POSTNATALES'),
          InlineCheckboxGroup(
            "Alimentación:",
            [
              {"title": "Materna", "value": false, "onChanged": (val) {}},
              {"title": "Artificial", "value": false, "onChanged": (val) {}},
              {"title": "Maticación", "value": false, "onChanged": (val) {}},
            ],
          ),
          Divider(),
          InlineCheckboxGroup(
            "Dearrollo motor grueso:",
            [
              {
                "title": "Control céfalico",
                "value": false,
                "onChanged": (val) {}
              },
              {"title": "Gateo", "value": false, "onChanged": (val) {}},
              {"title": "Marcha", "value": false, "onChanged": (val) {}},
              {"title": "Sedeestación", "value": false, "onChanged": (val) {}},
              {"title": "Sincinesias", "value": false, "onChanged": (val) {}},
              {
                "title": "Sube y baja gradas",
                "value": false,
                "onChanged": (val) {}
              },
              {
                "title": "Rotación de pies",
                "value": false,
                "onChanged": (val) {}
              },
            ],
          ),
          Divider(),
          Center(
            child: _buildSection('REFLEJOS PRIMITIVOS'),
          ),
          Container(
            height: 3.0, // Ajusta el grosor vertical del divisor
            width:
                100.0, // Ajusta el ancho horizontal del divisor, o usa double.infinity para ocupar todo el espacio disponible
            color: const Color.fromARGB(112, 75, 107, 176), // Color del divisor
          ),
          _buildRadioButtonGroup('Palmar - Plantar', ['SI', 'NO']),
          _buildRadioButtonGroup('Moro', ['SI', 'NO']),
          _buildRadioButtonGroup('Presión', ['SI', 'NO']),
          _buildRadioButtonGroup('De búsqueda', ['SI', 'NO']),
          _buildRadioButtonGroup('Banbiski', ['SI', 'NO']),
          Divider(),
          Center(
            child: _buildSection('DESARROLLO MOTOR FINO'),
          ),
          Container(
            height: 3.0, // Ajusta el grosor vertical del divisor
            width:
                100.0, // Ajusta el ancho horizontal del divisor, o usa double.infinity para ocupar todo el espacio disponible
            color: const Color.fromARGB(112, 75, 107, 176), // Color del divisor
          ),
          _buildRadioButtonGroup('Pinza digital', ['SI', 'NO']),
          _buildRadioButtonGroup('Garabateo', ['SI', 'NO']),
          _buildRadioButtonGroup('Sostener objetos', ['SI', 'NO']),
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
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Problemas alimenticios:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Garabato:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Tics motores:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Tics vocales:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Conductas problemáticas:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Sonrisa social:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Movimientos estereotipados:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup(
              "Manipula permanentemente un objeto:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Balanceos:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Juego repetitivo:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Tendencia a rutinas:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Camina sin sentido:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Problemas de sueño:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Reitera temas favoritos:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Camina en puntitas:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Irritabilidad:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup(
              "Manipula permanentemente algo:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup(
              "Inicia y mantiene conversación:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Ecolalia:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Conocimiento de algún tema:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Lenguaje literal:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Mira a los ojos:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup(
              "Otros sistemas de comunicación:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Selectivo en la comida:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Intención comunicativa:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Interés restringido:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Angustia sin causa:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup(
              "Preferencia por algún alimento:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Sonidos extraños:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Habla como adulto:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Frío para hablar:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Pensamiento obsesivo:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Cambio de carácter extremo:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Ingenuo:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Torpeza motriz:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Frío emocional:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Pocos amigos:", ["SI", "NO"]),
          const SizedBox(height: 10),
          _buildRadioButtonGroup("Juego imaginativo:", ["SI", "NO"]),
          Divider(),
          _buildSection('ESPECIFICACIONES'),
          MaxlineSection('Intensión comunicativa'),
          MaxlineSection('Traumatismo'),
          MaxlineSection('Infecciones, alergias, otitis, farin......'),
          MaxlineSection('Reacciones peculiares vacunas'),
          MaxlineSection('Desnutrición/Obesidad'),
          MaxlineSection('Cirugías'),
          MaxlineSection('Convulsiones fabriles o epilepsia.....'),
          MaxlineSection('Medicación'),
          MaxlineSection('Sindromes'),
          MaxlineSection('Observaciones'),
          MaxlineSection('EE, TAC, RM......'),
          Divider(),
          _buildSection('5.- HÁBITOS PERSONALES'),
          InlineCheckboxGroup(
            "          Reacción ante las dificultades",
            [
              {"title": "Berrinches", "value": false, "onChanged": (val) {}},
              {"title": "Insulta", "value": false, "onChanged": (val) {}},
              {"title": "Llora", "value": false, "onChanged": (val) {}},
              {"title": "Grita", "value": false, "onChanged": (val) {}},
              {"title": "Agrede", "value": false, "onChanged": (val) {}},
              {"title": "Se encierra", "value": false, "onChanged": (val) {}},
              {"title": "Pide ayuda", "value": false, "onChanged": (val) {}},
              {
                "title": "Pega a los padres",
                "value": false,
                "onChanged": (val) {}
              },
            ],
          ),
          Divider(),
          _buildSection('Aptitudes e intereses escolares'),
          MaxlineSection('Describa...........'),
          Divider(),
          _buildSection('Rendimiento general en escolaridad'),
          MaxlineSection('Describa...........'),
          Divider(),
          InlineCheckboxGroup(
            "          Comportamiento general",
            [
              {"title": "Agresivo", "value": false, "onChanged": (val) {}},
              {"title": "Pasivo", "value": false, "onChanged": (val) {}},
              {"title": "Destructor", "value": false, "onChanged": (val) {}},
              {"title": "Social", "value": false, "onChanged": (val) {}},
              {"title": "Hipercinetico", "value": false, "onChanged": (val) {}},
              {"title": "Empatia", "value": false, "onChanged": (val) {}},
              {
                "title": "Intereses peculiares",
                "value": false,
                "onChanged": (val) {}
              },
              {
                "title": "Interes por interacción",
                "value": false,
                "onChanged": (val) {}
              },
            ],
          ),
          Divider(),
          _buildSection('ASPECTOS DE SOCIALIZACIÓN'),
          InlineCheckboxGroup(
            "       Socialización",
            [
              {"title": "Mayores", "value": false, "onChanged": (val) {}},
              {"title": "Menores", "value": false, "onChanged": (val) {}},
              {
                "title": "Socializacion con familia",
                "value": false,
                "onChanged": (val) {}
              },
              {
                "title": "Reaccion conpersonas extrañas",
                "value": false,
                "onChanged": (val) {}
              },
              {"title": "Todos", "value": false, "onChanged": (val) {}},
            ],
          ),
          Divider(),
          InlineCheckboxGroup(
            "       Aspectos cognitivos",
            [
              {
                "title": "Logra concentrarse 5 min",
                "value": false,
                "onChanged": (val) {}
              },
              {
                "title": "Reconoce partes del cuerpo",
                "value": false,
                "onChanged": (val) {}
              },
              {
                "title": "Asocia objetos",
                "value": false,
                "onChanged": (val) {}
              },
              {
                "title": "Reconoce a sus familiares",
                "value": false,
                "onChanged": (val) {}
              },
              {
                "title": "Reconoce colores basicos",
                "value": false,
                "onChanged": (val) {}
              },
            ],
          ),
          Divider(),
          _buildSection('DATOS FAMILIARES'),
          InlineCheckboxGroup(
            "       Tipo de hogar",
            [
              {"title": "Nuclear", "value": false, "onChanged": (val) {}},
              {"title": "Monoparental", "value": false, "onChanged": (val) {}},
              {"title": "Funcional", "value": false, "onChanged": (val) {}},
              {"title": "Reconstituida", "value": false, "onChanged": (val) {}},
              {"title": "Disfuncional", "value": false, "onChanged": (val) {}},
              {"title": "Extensa", "value": false, "onChanged": (val) {}},
            ],
          ),
          Divider(),
          _buildSection('¿Quién vive en la casa?'),
          MaxlineSection('Describa quien vive en la casa'),
          Divider(),
          InlineCheckboxGroup(
            "       INTEGRACIÓN SENSORIAL",
            [
              {"title": "Vista", "value": false, "onChanged": (val) {}},
              {"title": "Oido", "value": false, "onChanged": (val) {}},
              {"title": "Tacto", "value": false, "onChanged": (val) {}},
              {
                "title": "Gusto y olfato",
                "value": false,
                "onChanged": (val) {}
              },
            ],
          ),
        ],
      ),
    );
  }

  //WIDGETS DE LA PAGINA

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFormField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget MaxlineSection(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: 5, // Aumenta el tamaño de la caja de texto
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup(String title, List<String> options) {
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
            ),
          ),
        ),
        Wrap(
          spacing: 20.0, // Espacio horizontal entre opciones
          runSpacing:
              10.0, // Espacio vertical cuando se ajusta a la siguiente línea
          alignment: WrapAlignment.start,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: option,
                  groupValue: null, // Aquí se configurará el valor del grupo
                  onChanged: (value) {},
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCheckboxList(String title, bool value) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: (bool? newValue) {},
    );
  }
}

Widget InlineCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
      ),
      Text(title),
    ],
  );
}

Widget InlineCheckboxGroup(
    String groupTitle, List<Map<String, dynamic>> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        groupTitle,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Wrap(
        spacing: 16.0,
        children: items.map((item) {
          return InlineCheckbox(
            item['title'],
            item['value'],
            item['onChanged'],
          );
        }).toList(),
      ),
    ],
  );
}

TextEditingController _dateController = TextEditingController();

Widget _buildDatePickerField(String label, BuildContext context, HcGeneralFormNotifier provider) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      readOnly: true,
      controller: TextEditingController(text: provider.state.createHcGeneral.fechaEntrevista),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          provider.onFechaEntrevistaChanged(pickedDate);
        }
      },
    ),
  );
}
