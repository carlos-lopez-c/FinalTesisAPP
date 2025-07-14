class CreateHcPsNino {
  String? id;
  String patientId;
  String nombreCompleto;
  String fechaNacimiento;
  String edad;
  String cursoEscolar;
  String institucion;
  String nombrePapa;
  String nombreMama;
  String direccion;
  String telefono;
  String remision;
  String fechaEvaluacion;
  String responsable;
  String observaciones;
  String motivoConsulta;
  String desencadenantesMotivoConsulta;
  String datosEmbarazoParto;
  String datosPsicomotor;
  String desarrolloLenguaje;
  String desarrolloIntelectual;
  String desarrolloSocioAfectivo;
  String antecedentesFamiliares;
  String estructuraFamiliar;
  String pruebasAplicadas;
  String impresionDiagnostica;
  String areasIntervencion;
  String cobertura;

  CreateHcPsNino({
    this.id,
    required this.patientId,
    required this.nombreCompleto,
    required this.fechaNacimiento,
    required this.edad,
    required this.cursoEscolar,
    required this.institucion,
    required this.nombrePapa,
    required this.nombreMama,
    required this.direccion,
    required this.telefono,
    required this.remision,
    required this.fechaEvaluacion,
    required this.responsable,
    required this.cobertura,
    required this.observaciones,
    required this.motivoConsulta,
    required this.desencadenantesMotivoConsulta,
    required this.datosEmbarazoParto,
    required this.datosPsicomotor,
    required this.desarrolloLenguaje,
    required this.desarrolloIntelectual,
    required this.desarrolloSocioAfectivo,
    required this.antecedentesFamiliares,
    required this.estructuraFamiliar,
    required this.pruebasAplicadas,
    required this.impresionDiagnostica,
    required this.areasIntervencion,
  });

  CreateHcPsNino copyWith({
    String? id,
    String? patientId,
    String? nombreCompleto,
    String? fechaNacimiento,
    String? edad,
    String? cursoEscolar,
    String? institucion,
    String? nombrePapa,
    String? nombreMama,
    String? direccion,
    String? telefono,
    String? remision,
    String? fechaEvaluacion,
    String? responsable,
    String? observaciones,
    String? motivoConsulta,
    String? desencadenantesMotivoConsulta,
    String? datosEmbarazoParto,
    String? datosPsicomotor,
    String? desarrolloLenguaje,
    String? desarrolloIntelectual,
    String? desarrolloSocioAfectivo,
    String? antecedentesFamiliares,
    String? estructuraFamiliar,
    String? pruebasAplicadas,
    String? impresionDiagnostica,
    String? areasIntervencion,
    String? cobertura,
  }) {
    return CreateHcPsNino(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      edad: edad ?? this.edad,
      cursoEscolar: cursoEscolar ?? this.cursoEscolar,
      institucion: institucion ?? this.institucion,
      nombrePapa: nombrePapa ?? this.nombrePapa,
      nombreMama: nombreMama ?? this.nombreMama,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      remision: remision ?? this.remision,
      fechaEvaluacion: fechaEvaluacion ?? this.fechaEvaluacion,
      responsable: responsable ?? this.responsable,
      observaciones: observaciones ?? this.observaciones,
      motivoConsulta: motivoConsulta ?? this.motivoConsulta,
      desencadenantesMotivoConsulta:
          desencadenantesMotivoConsulta ?? this.desencadenantesMotivoConsulta,
      datosEmbarazoParto: datosEmbarazoParto ?? this.datosEmbarazoParto,
      datosPsicomotor: datosPsicomotor ?? this.datosPsicomotor,
      desarrolloLenguaje: desarrolloLenguaje ?? this.desarrolloLenguaje,
      desarrolloIntelectual:
          desarrolloIntelectual ?? this.desarrolloIntelectual,
      desarrolloSocioAfectivo:
          desarrolloSocioAfectivo ?? this.desarrolloSocioAfectivo,
      antecedentesFamiliares:
          antecedentesFamiliares ?? this.antecedentesFamiliares,
      estructuraFamiliar: estructuraFamiliar ?? this.estructuraFamiliar,
      pruebasAplicadas: pruebasAplicadas ?? this.pruebasAplicadas,
      impresionDiagnostica: impresionDiagnostica ?? this.impresionDiagnostica,
      areasIntervencion: areasIntervencion ?? this.areasIntervencion,
      cobertura: cobertura ?? this.cobertura ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'nombreCompleto': nombreCompleto,
      'fechaNacimiento': fechaNacimiento,
      'edad': edad,
      'cursoEscolar': cursoEscolar,
      'institucion': institucion,
      'nombrePapa': nombrePapa,
      'nombreMama': nombreMama,
      'direccion': direccion,
      'telefono': telefono,
      'remision': remision,
      'fechaEvaluacion': fechaEvaluacion,
      'responsable': responsable,
      'observaciones': observaciones,
      'motivoConsulta': motivoConsulta,
      'desencadenantesMotivoConsulta': desencadenantesMotivoConsulta,
      'datosEmbarazoParto': datosEmbarazoParto,
      'datosPsicomotor': datosPsicomotor,
      'desarrolloLenguaje': desarrolloLenguaje,
      'desarrolloIntelectual': desarrolloIntelectual,
      'desarrolloSocioAfectivo': desarrolloSocioAfectivo,
      'antecedentesFamiliares': antecedentesFamiliares,
      'estructuraFamiliar': estructuraFamiliar,
      'pruebasAplicadas': pruebasAplicadas,
      'impresionDiagnostica': impresionDiagnostica,
      'areasIntervencion': areasIntervencion,
      'cobertura': cobertura,
    };
  }

  factory CreateHcPsNino.fromJson(Map<String, dynamic> json) {
    return CreateHcPsNino(
      id: json['id'],
      patientId: json['patientId'],
      nombreCompleto: json['nombreCompleto'],
      fechaNacimiento: json['fechaNacimiento'],
      edad: json['edad'],
      cursoEscolar: json['cursoEscolar'],
      institucion: json['institucion'],
      nombrePapa: json['nombrePapa'],
      nombreMama: json['nombreMama'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      remision: json['remision'],
      fechaEvaluacion: json['fechaEvaluacion'],
      responsable: json['responsable'],
      observaciones: json['observaciones'],
      motivoConsulta: json['motivoConsulta'],
      desencadenantesMotivoConsulta: json['desencadenantesMotivoConsulta'],
      datosEmbarazoParto: json['datosEmbarazoParto'],
      datosPsicomotor: json['datosPsicomotor'],
      desarrolloLenguaje: json['desarrolloLenguaje'],
      desarrolloIntelectual: json['desarrolloIntelectual'],
      desarrolloSocioAfectivo: json['desarrolloSocioAfectivo'],
      antecedentesFamiliares: json['antecedentesFamiliares'],
      estructuraFamiliar: json['estructuraFamiliar'],
      pruebasAplicadas: json['pruebasAplicadas'],
      impresionDiagnostica: json['impresionDiagnostica'],
      areasIntervencion: json['areasIntervencion'],
      cobertura: json['cobertura'] ?? '',
    );
  }
}
