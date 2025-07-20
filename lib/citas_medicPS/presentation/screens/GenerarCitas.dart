import 'package:flutter/material.dart';
import 'package:h_c_1/citas_medicPS/presentation/widgets/headerCT.dart';

class GenerarCitas extends StatefulWidget {
  @override
  _GenerarCitasState createState() => _GenerarCitasState();
}

class _GenerarCitasState extends State<GenerarCitas> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final ValueNotifier<String?> _selectedArea = ValueNotifier(null);
  final ValueNotifier<DateTime?> _selectedDate = ValueNotifier(null);
  final ValueNotifier<String?> _selectedTime = ValueNotifier(null);
  final ValueNotifier<String?> _searchMessage = ValueNotifier(null);

  final List<String> areas = [
    'Área 1',
    'Área 2',
    'Área 3',
    'Área 4',
    'Área 5',
    'Área 6',
    'Área 7',
    'Área 8'
  ];

  final List<String> patientNames = [
    'Juan Pérez',
    'María López',
    'Carlos García',
    'Ana Torres',
    'Luis Fernández'
  ];

  final ValueNotifier<List<String>> filteredPatients =
      ValueNotifier<List<String>>([]);

  @override
  void initState() {
    super.initState();
    filteredPatients.value = patientNames;
    // Establecer Psicología como área por defecto y fija
    _selectedArea.value = 'Psicología';
    print('🔹 Módulo PS: Área establecida como: ${_selectedArea.value}');
    print('🔹 Módulo PS: Inicializado correctamente');
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _diagnosisController.dispose();
    _searchController.dispose();
    _selectedArea.dispose();
    _selectedDate.dispose();
    _selectedTime.dispose();
    _searchMessage.dispose();
    filteredPatients.dispose();
    super.dispose();
  }

  void _clearSearchMessage() {
    _searchMessage.value = null;
  }

  void _searchPatients() {
    final searchTerm = _searchController.text.trim();

    if (searchTerm.isEmpty) {
      _searchMessage.value = null;
      filteredPatients.value = patientNames;
      return;
    }

    // Simular búsqueda por DNI (en este caso, buscar por nombre)
    // En una implementación real, aquí se haría la llamada a la API
    final foundPatients = patientNames
        .where((name) => name.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    if (foundPatients.isNotEmpty) {
      _searchMessage.value = 'Paciente encontrado';
      filteredPatients.value = foundPatients;
    } else {
      _searchMessage.value = 'No se encontró paciente con el DNI asociado';
      filteredPatients.value = [];
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      _selectedDate.value = pickedDate;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      _selectedTime.value = pickedTime.format(context);
    }
  }

  void _saveAppointment() {
    print('🔹 Módulo PS: Validando cita con área: ${_selectedArea.value}');
    if (_selectedArea.value != null &&
        _selectedDate.value != null &&
        _selectedTime.value != null &&
        _patientNameController.text.isNotEmpty &&
        _diagnosisController.text.isNotEmpty) {
      print(
          '✅ Cita creada: Área: ${_selectedArea.value}, Paciente: ${_patientNameController.text}, Diagnóstico: ${_diagnosisController.text}, Fecha: ${_selectedDate.value}, Hora: ${_selectedTime.value}');
    } else {
      print('❌ Por favor complete todos los campos.');
      print('   - Área: ${_selectedArea.value}');
      print('   - Fecha: ${_selectedDate.value}');
      print('   - Hora: ${_selectedTime.value}');
      print('   - Paciente: ${_patientNameController.text}');
      print('   - Diagnóstico: ${_diagnosisController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar una cita'),
      ),
      resizeToAvoidBottomInset:
          true, // Ajusta automáticamente cuando aparece el teclado
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderCTWidget(
                textoDinamico: '  AGENDACIÓN DE CITAS MÉDICAS - PSICOLOGÍA',
                textoCitasMedicas: '',
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _clearSearchMessage();
                        }
                      },
                      decoration:
                          InputDecoration(labelText: 'Buscar por cédula'),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _searchPatients,
                    child: Text('Buscar'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              AnimatedBuilder(
                animation: _searchMessage,
                builder: (context, _) {
                  if (_searchMessage.value == null) return SizedBox.shrink();

                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _searchMessage.value == 'Paciente encontrado'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _searchMessage.value == 'Paciente encontrado'
                            ? Colors.green
                            : Colors.red,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _searchMessage.value == 'Paciente encontrado'
                              ? Icons.check_circle
                              : Icons.error,
                          color: _searchMessage.value == 'Paciente encontrado'
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _searchMessage.value!,
                            style: TextStyle(
                              color:
                                  _searchMessage.value == 'Paciente encontrado'
                                      ? Colors.green
                                      : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: AnimatedBuilder(
                        animation: _selectedDate,
                        builder: (_, __) => Text(_selectedDate.value == null
                            ? 'Seleccionar Fecha'
                            : 'Fecha: ${_selectedDate.value}'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: AnimatedBuilder(
                        animation: _selectedTime,
                        builder: (_, __) => Text(_selectedTime.value == null
                            ? 'Seleccionar Hora'
                            : 'Hora: ${_selectedTime.value}'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: _patientNameController,
                decoration: InputDecoration(labelText: 'Nombre del Paciente'),
              ),
              TextField(
                controller: _diagnosisController,
                decoration: InputDecoration(labelText: 'Diagnóstico'),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Área (Módulo Psicología)',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(Icons.psychology, color: Colors.blue),
                  ),
                  controller: TextEditingController(text: 'Psicología'),
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAppointment,
                child: Text('Guardar Cita'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
