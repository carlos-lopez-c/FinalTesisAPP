import 'package:h_c_1/hc_tr/domain/entities/hc_general/antecedentes_perinatales.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/antecedentes_personales.dart';

class CreateHcGeneral {
  String? id;
  String patientId;
  String fechaEntrevista;
  String nombreCompleto;
  String fechaNacimiento;
  String sexo;
  String escolaridad;
  String nombreDeInstitucion;
  String tipoDeInstitucion;
  String domicilio;
  String email;
  String telefono;
  String entrevistadoPor;
  String remitidoPor;
  String motivoDeConsulta;
  String caracterizacionDelProblema;
  String historiaEscolar;

  AntecedentesPersonales antecedentesPersonales;
  AntecedentesPerinatales antecedentesPerinatales;

  CreateHcGeneral({
    this.id,
    required this.patientId,
    required this.fechaEntrevista,
    required this.nombreCompleto,
    required this.fechaNacimiento,
    required this.sexo,
    required this.escolaridad,
    required this.nombreDeInstitucion,
    required this.tipoDeInstitucion,
    required this.domicilio,
    required this.email,
    required this.telefono,
    required this.entrevistadoPor,
    required this.remitidoPor,
    required this.motivoDeConsulta,
    required this.caracterizacionDelProblema,
    required this.historiaEscolar,
    required this.antecedentesPersonales,
    required this.antecedentesPerinatales,
  });

  CreateHcGeneral copyWith({
    String? id,
    String? patientId,
    String? fechaEntrevista,
    String? nombreCompleto,
    String? fechaNacimiento,
    String? sexo,
    String? escolaridad,
    String? nombreDeInstitucion,
    String? tipoDeInstitucion,
    String? domicilio,
    String? email,
    String? telefono,
    String? entrevistadoPor,
    String? remitidoPor,
    String? motivoDeConsulta,
    String? caracterizacionDelProblema,
    String? historiaEscolar,
    AntecedentesPersonales? antecedentesPersonales,
    AntecedentesPerinatales? antecedentesPerinatales,
  }) {
    return CreateHcGeneral(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      fechaEntrevista: fechaEntrevista ?? this.fechaEntrevista,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      sexo: sexo ?? this.sexo,
      escolaridad: escolaridad ?? this.escolaridad,
      nombreDeInstitucion: nombreDeInstitucion ?? this.nombreDeInstitucion,
      tipoDeInstitucion: tipoDeInstitucion ?? this.tipoDeInstitucion,
      domicilio: domicilio ?? this.domicilio,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      entrevistadoPor: entrevistadoPor ?? this.entrevistadoPor,
      remitidoPor: remitidoPor ?? this.remitidoPor,
      motivoDeConsulta: motivoDeConsulta ?? this.motivoDeConsulta,
      caracterizacionDelProblema:
          caracterizacionDelProblema ?? this.caracterizacionDelProblema,
      historiaEscolar: historiaEscolar ?? this.historiaEscolar,
      antecedentesPersonales:
          antecedentesPersonales ?? this.antecedentesPersonales,
      antecedentesPerinatales:
          antecedentesPerinatales ?? this.antecedentesPerinatales,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'fechaEntrevista': fechaEntrevista,
      'nombreCompleto': nombreCompleto,
      'fechaNacimiento': fechaNacimiento,
      'sexo': sexo,
      'escolaridad': escolaridad,
      'nombreDeInstitucion': nombreDeInstitucion,
      'tipoDeInstitucion': tipoDeInstitucion,
      'domicilio': domicilio,
      'email': email,
      'telefono': telefono,
      'entrevistadoPor': entrevistadoPor,
      'remitidoPor': remitidoPor,
      'motivoDeConsulta': motivoDeConsulta,
      'caracterizacionDelProblema': caracterizacionDelProblema,
      'historiaEscolar': historiaEscolar,
      'antecedentesPersonales': antecedentesPersonales.toJson(),
      'antecedentesPerinatales': antecedentesPerinatales.toJson(),
    };
  }

  factory CreateHcGeneral.fromJson(Map<String, dynamic> json) {
    try {
      // Verificar que los campos obligatorios no sean nulos
      if (json['patientId'] == null ||
          json['fechaEntrevista'] == null ||
          json['nombreCompleto'] == null ||
          json['fechaNacimiento'] == null ||
          json['sexo'] == null ||
          json['escolaridad'] == null ||
          json['nombreDeInstitucion'] == null ||
          json['tipoDeInstitucion'] == null ||
          json['domicilio'] == null ||
          json['email'] == null ||
          json['telefono'] == null ||
          json['entrevistadoPor'] == null ||
          json['remitidoPor'] == null ||
          json['motivoDeConsulta'] == null ||
          json['caracterizacionDelProblema'] == null ||
          json['historiaEscolar'] == null ||
          json['antecedentesPersonales'] == null ||
          json['antecedentesPerinatales'] == null) {
        throw Exception('Uno o más campos obligatorios son nulos');
      }

      return CreateHcGeneral(
        id: json['id'],
        patientId: json['patientId'],
        fechaEntrevista: json['fechaEntrevista'],
        nombreCompleto: json['nombreCompleto'],
        fechaNacimiento: json['fechaNacimiento'],
        sexo: json['sexo'],
        escolaridad: json['escolaridad'],
        nombreDeInstitucion: json['nombreDeInstitucion'],
        tipoDeInstitucion: json['tipoDeInstitucion'],
        domicilio: json['domicilio'],
        email: json['email'],
        telefono: json['telefono'],
        entrevistadoPor: json['entrevistadoPor'],
        remitidoPor: json['remitidoPor'],
        motivoDeConsulta: json['motivoDeConsulta'],
        caracterizacionDelProblema: json['caracterizacionDelProblema'],
        historiaEscolar: json['historiaEscolar'],
        antecedentesPersonales:
            AntecedentesPersonales.fromJson(json['antecedentesPersonales']),
        antecedentesPerinatales:
            AntecedentesPerinatales.fromJson(json['antecedentesPerinatales']),
      );
    } catch (e) {
      print('Error al convertir JSON a CreateHcGeneral: $e');
      throw Exception('Error al convertir JSON a CreateHcGeneral');
    }
  }
}
