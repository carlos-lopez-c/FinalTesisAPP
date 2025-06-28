import 'package:flutter/material.dart';
import '../widgets/headerPS.dart';
import 'search_hc_ps_ninos.dart';

class HistoriaClinicaNinoPS extends StatefulWidget {
  @override
  _HistoriaClinicaNinoPSState createState() => _HistoriaClinicaNinoPSState();
}

class _HistoriaClinicaNinoPSState extends State<HistoriaClinicaNinoPS> {
  final _formKey = GlobalKey<FormState>();
  String tipo = 'Nuevo';
  final TextEditingController cedulaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text(
          'Historia Clínica de Niños',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              headerPSWidget(
                textoDinamico: 'HISTORIA CLÍNICA DE NIÑOS',
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
                      Center(child: _buildRadioButtonGroup()),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: cedulaController,
                              decoration: const InputDecoration(
                                labelText: 'Buscar por cédula',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (tipo == 'Nuevo') {
                                // Aquí iría la lógica de buscar paciente por cédula
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BusquedaPsN()),
                                );
                              }
                            },
                            child: const Text('Buscar'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      if (tipo == 'Nuevo') ...[
                        _buildSection('1.- DATOS PERSONALES:'),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormField(
                                label: 'Nombres y Apellidos',
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildFormField(
                                      label: 'Fecha de Nacimiento',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: _buildFormField(
                                      label: 'Edad',
                                    ),
                                  ),
                                ],
                              ),
                              _buildFormField(
                                label: 'Curso Escolar Actual',
                              ),
                              _buildFormField(
                                label: 'Institución',
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildFormField(
                                      label: 'Nombre del Papá',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: _buildFormField(
                                      label: 'Nombre de la Mamá',
                                    ),
                                  ),
                                ],
                              ),
                              _buildFormField(
                                label: 'Dirección',
                              ),
                              _buildFormField(
                                label: 'Teléfono',
                              ),
                              _buildFormField(
                                label: 'Remisión',
                              ),
                              _buildFormField(
                                label: 'Fecha de Evaluación',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRadioButton('Nuevo'),
        const SizedBox(width: 20),
        _buildRadioButton('Buscar'),
      ],
    );
  }

  Widget _buildRadioButton(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: tipo,
          onChanged: (String? newValue) {
            setState(() {
              tipo = newValue!;
            });
          },
          activeColor: const Color(0xFF1976D2),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Color(0xFF1976D2),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor llene este campo';
          }
          return null;
        },
      ),
    );
  }
}
