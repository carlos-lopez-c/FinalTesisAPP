import 'package:h_c_1/hc_tr/domain/entities/hc_adult/eficiencia.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/independencia_autonomia.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/proceso_alimentacion.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/salud_bocal.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/seguridad.dart';

class CreateHcAdultEntity {
  final String? id;
  final String? patientId;
  final String? nombreCompleto;
  final String? fechaEvalucion;
  final String? lateralidad;
  final IndependenciaAutonomia independenciaAutonomia;
  final Eficiencia eficiencia;
  final Seguridad seguridad;
  final ProcesoDeAlimentacion procesoDeAlimentacion;
  final SaludBocal saludBocal;

  CreateHcAdultEntity({
    this.id,
    this.patientId,
    this.nombreCompleto,
    this.fechaEvalucion,
    this.lateralidad,
    required this.independenciaAutonomia,
    required this.eficiencia,
    required this.seguridad,
    required this.procesoDeAlimentacion,
    required this.saludBocal,
  });

  CreateHcAdultEntity copyWith({
    String? id,
    String? patientId,
    String? nombreCompleto,
    String? fechaEvalucion,
    String? lateralidad,
    IndependenciaAutonomia? independenciaAutonomia,
    Eficiencia? eficiencia,
    Seguridad? seguridad,
    ProcesoDeAlimentacion? procesoDeAlimentacion,
    SaludBocal? saludBocal,
  }) {
    return CreateHcAdultEntity(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      fechaEvalucion: fechaEvalucion ?? this.fechaEvalucion,
      lateralidad: lateralidad ?? this.lateralidad,
      independenciaAutonomia:
          independenciaAutonomia ?? this.independenciaAutonomia,
      eficiencia: eficiencia ?? this.eficiencia,
      seguridad: seguridad ?? this.seguridad,
      procesoDeAlimentacion:
          procesoDeAlimentacion ?? this.procesoDeAlimentacion,
      saludBocal: saludBocal ?? this.saludBocal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'nombreCompleto': nombreCompleto,
      'fechaEvalucion': fechaEvalucion,
      'lateralidad': lateralidad,
      'independenciaAutonomia': independenciaAutonomia.toJson(),
      'eficiencia': eficiencia.toJson(),
      'seguridad': seguridad.toJson(),
      'procesoDeAlimentacion': procesoDeAlimentacion.toJson(),
      'saludBocal': saludBocal.toJson(),
    };
  }

  factory CreateHcAdultEntity.fromJson(Map<String, dynamic> json,
      {String? id}) {
    try {
      // Verificar que los campos obligatorios no sean nulos
      if (json['independenciaAutonomia'] == null ||
          json['eficiencia'] == null ||
          json['seguridad'] == null ||
          json['procesoDeAlimentacion'] == null ||
          json['saludBocal'] == null) {
        throw Exception('Uno o más campos obligatorios son nulos');
      }

      return CreateHcAdultEntity(
        id: id ?? json['id'], // Use the provided 'id' or fallback to json['id']
        patientId: json['patientId'],
        nombreCompleto: json['nombreCompleto'],
        fechaEvalucion: json['fechaEvalucion'],
        lateralidad: json['lateralidad'],
        independenciaAutonomia:
            IndependenciaAutonomia.fromJson(json['independenciaAutonomia']),
        eficiencia: Eficiencia.fromJson(json['eficiencia']),
        seguridad: Seguridad.fromJson(json['seguridad']),
        procesoDeAlimentacion:
            ProcesoDeAlimentacion.fromJson(json['procesoDeAlimentacion']),
        saludBocal: SaludBocal.fromJson(json['saludBocal']),
      );
    } catch (e) {
      print('Error al convertir JSON a CreateHcAdultEntity: $e');
      throw Exception('Error al convertir JSON a CreateHcAdultEntity');
    }
  }
}
