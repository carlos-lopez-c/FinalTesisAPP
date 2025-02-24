class CreateHcPsAdult {
  String? id;
  String patientId;
  String antecedenteFamiliares;
  String areasIntervecion;
  String cobertura;
  String curso;
  String desencadenantesMotivoConsulta;
  String direccion;
  String estructuraFamiliar;
  String fechaCreacion;
  String fechaEvalucion;
  String fechaNacimiento;
  String impresionDiagnostica;
  String institucion;
  String motivoConsulta;
  String nombreCompleto;
  String observaciones;
  String pruebasAplicadas;
  String remision;
  String responsable;
  String telefono;

  CreateHcPsAdult({
    this.id,
    required this.patientId,
    required this.antecedenteFamiliares,
    required this.areasIntervecion,
    required this.cobertura,
    required this.curso,
    required this.desencadenantesMotivoConsulta,
    required this.direccion,
    required this.estructuraFamiliar,
    required this.fechaCreacion,
    required this.fechaEvalucion,
    required this.fechaNacimiento,
    required this.impresionDiagnostica,
    required this.institucion,
    required this.motivoConsulta,
    required this.nombreCompleto,
    required this.observaciones,
    required this.pruebasAplicadas,
    required this.remision,
    required this.responsable,
    required this.telefono,
  });

  CreateHcPsAdult copyWith({
    String? id,
    String? patientId,
    String? antecedenteFamiliares,
    String? areasIntervecion,
    String? cobertura,
    String? curso,
    String? desencadenantesMotivoConsulta,
    String? direccion,
    String? estructuraFamiliar,
    String? fechaCreacion,
    String? fechaEvalucion,
    String? fechaNacimiento,
    String? impresionDiagnostica,
    String? institucion,
    String? motivoConsulta,
    String? nombreCompleto,
    String? observaciones,
    String? pruebasAplicadas,
    String? remision,
    String? responsable,
    String? telefono,
  }) {
    return CreateHcPsAdult(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      antecedenteFamiliares:
          antecedenteFamiliares ?? this.antecedenteFamiliares,
      areasIntervecion: areasIntervecion ?? this.areasIntervecion,
      cobertura: cobertura ?? this.cobertura,
      curso: curso ?? this.curso,
      desencadenantesMotivoConsulta:
          desencadenantesMotivoConsulta ?? this.desencadenantesMotivoConsulta,
      direccion: direccion ?? this.direccion,
      estructuraFamiliar: estructuraFamiliar ?? this.estructuraFamiliar,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaEvalucion: fechaEvalucion ?? this.fechaEvalucion,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      impresionDiagnostica: impresionDiagnostica ?? this.impresionDiagnostica,
      institucion: institucion ?? this.institucion,
      motivoConsulta: motivoConsulta ?? this.motivoConsulta,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      observaciones: observaciones ?? this.observaciones,
      pruebasAplicadas: pruebasAplicadas ?? this.pruebasAplicadas,
      remision: remision ?? this.remision,
      responsable: responsable ?? this.responsable,
      telefono: telefono ?? this.telefono,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'antecedenteFamiliares': antecedenteFamiliares,
      'areasIntervecion': areasIntervecion,
      'cobertura': cobertura,
      'curso': curso,
      'desencadenantesMotivoConsulta': desencadenantesMotivoConsulta,
      'direccion': direccion,
      'estructuraFamiliar': estructuraFamiliar,
      'fechaCreacion': fechaCreacion,
      'fechaEvalucion': fechaEvalucion,
      'fechaNacimiento': fechaNacimiento,
      'impresionDiagnostica': impresionDiagnostica,
      'institucion': institucion,
      'motivoConsulta': motivoConsulta,
      'nombreCompleto': nombreCompleto,
      'observaciones': observaciones,
      'pruebasAplicadas': pruebasAplicadas,
      'remision': remision,
      'responsable': responsable,
      'telefono': telefono,
    };
  }

  factory CreateHcPsAdult.fromJson(Map<String, dynamic> json) {
    try {
      // Verificar que los campos obligatorios no sean nulos
      if (json['patientId'] == null ||
          json['antecedenteFamiliares'] == null ||
          json['areasIntervecion'] == null ||
          json['cobertura'] == null ||
          json['curso'] == null ||
          json['desencadenantesMotivoConsulta'] == null ||
          json['direccion'] == null ||
          json['estructuraFamiliar'] == null ||
          json['fechaCreacion'] == null ||
          json['fechaEvalucion'] == null ||
          json['fechaNacimiento'] == null ||
          json['impresionDiagnostica'] == null ||
          json['institucion'] == null ||
          json['motivoConsulta'] == null ||
          json['nombreCompleto'] == null ||
          json['observaciones'] == null ||
          json['pruebasAplicadas'] == null ||
          json['remision'] == null ||
          json['responsable'] == null ||
          json['telefono'] == null) {
        throw Exception('Uno o más campos obligatorios son nulos');
      }

      return CreateHcPsAdult(
        id: json['id'],
        patientId: json['patientId'],
        antecedenteFamiliares: json['antecedenteFamiliares'],
        areasIntervecion: json['areasIntervecion'],
        cobertura: json['cobertura'],
        curso: json['curso'],
        desencadenantesMotivoConsulta: json['desencadenantesMotivoConsulta'],
        direccion: json['direccion'],
        estructuraFamiliar: json['estructuraFamiliar'],
        fechaCreacion: json['fechaCreacion'],
        fechaEvalucion: json['fechaEvalucion'],
        fechaNacimiento: json['fechaNacimiento'],
        impresionDiagnostica: json['impresionDiagnostica'],
        institucion: json['institucion'],
        motivoConsulta: json['motivoConsulta'],
        nombreCompleto: json['nombreCompleto'],
        observaciones: json['observaciones'],
        pruebasAplicadas: json['pruebasAplicadas'],
        remision: json['remision'],
        responsable: json['responsable'],
        telefono: json['telefono'],
      );
    } catch (e) {
      print('Error al convertir JSON a CreateHcPsicologica: $e');
      throw Exception('Error al convertir JSON a CreateHcPsicologica');
    }
  }
}
