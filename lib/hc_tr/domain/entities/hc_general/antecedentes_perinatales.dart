import 'package:h_c_1/hc_tr/domain/entities/hc_general/al_nacer_necesito.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/al_nacer_presento.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/antecedentes_postnatales.dart';

class AntecedentesPerinatales {
  String duracionDeLaGestacion;
  String lugarDeAtencion;
  String tipoDeParto;
  String duracionDelParto;
  String presentacion;
  bool? lloroAlNacer;
  bool? sufrimientoFetal;
  AlNacerNecesito alNacerNecesito;
  AlNacerPresento alNacerPresento;
  String observaciones;
  AntecedentesPostnatales antecedentesPostnatales;

  AntecedentesPerinatales({
    required this.duracionDeLaGestacion,
    required this.lugarDeAtencion,
    required this.tipoDeParto,
    required this.duracionDelParto,
    required this.presentacion,
    this.lloroAlNacer,
    this.sufrimientoFetal,
    required this.alNacerNecesito,
    required this.alNacerPresento,
    required this.observaciones,
    required this.antecedentesPostnatales,
  });

  AntecedentesPerinatales copyWith({
    String? duracionDeLaGestacion,
    String? lugarDeAtencion,
    String? tipoDeParto,
    String? duracionDelParto,
    String? presentacion,
    bool? lloroAlNacer,
    bool? sufrimientoFetal,
    AlNacerNecesito? alNacerNecesito,
    AlNacerPresento? alNacerPresento,
    String? observaciones,
    AntecedentesPostnatales? antecedentesPostnatales,
  }) {
    return AntecedentesPerinatales(
      duracionDeLaGestacion:
          duracionDeLaGestacion ?? this.duracionDeLaGestacion,
      lugarDeAtencion: lugarDeAtencion ?? this.lugarDeAtencion,
      tipoDeParto: tipoDeParto ?? this.tipoDeParto,
      duracionDelParto: duracionDelParto ?? this.duracionDelParto,
      presentacion: presentacion ?? this.presentacion,
      lloroAlNacer: lloroAlNacer ?? this.lloroAlNacer,
      sufrimientoFetal: sufrimientoFetal ?? this.sufrimientoFetal,
      alNacerNecesito: alNacerNecesito ?? this.alNacerNecesito,
      alNacerPresento: alNacerPresento ?? this.alNacerPresento,
      observaciones: observaciones ?? this.observaciones,
      antecedentesPostnatales:
          antecedentesPostnatales ?? this.antecedentesPostnatales,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duracionDeLaGestacion': duracionDeLaGestacion,
      'lugarDeAtencion': lugarDeAtencion,
      'tipoDeParto': tipoDeParto,
      'duracionDelParto': duracionDelParto,
      'presentacion': presentacion,
      'lloroAlNacer': lloroAlNacer,
      'sufrimientoFetal': sufrimientoFetal,
      'alNacerNecesito': alNacerNecesito.toJson(),
      'alNacerPresento': alNacerPresento.toJson(),
      'observaciones': observaciones,
      'antecedentesPostnatales': antecedentesPostnatales.toJson(),
    };
  }

  factory AntecedentesPerinatales.fromJson(Map<String, dynamic> json) {
    return AntecedentesPerinatales(
      duracionDeLaGestacion: json['duracionDeLaGestacion'],
      lugarDeAtencion: json['lugarDeAtencion'],
      tipoDeParto: json['tipoDeParto'],
      duracionDelParto: json['duracionDelParto'],
      presentacion: json['presentacion'],
      lloroAlNacer: json['lloroAlNacer'] ?? true,
      sufrimientoFetal: json['sufrimientoFetal'] ?? true,
      alNacerNecesito: AlNacerNecesito.fromJson(json['alNacerNecesito']),
      alNacerPresento: AlNacerPresento.fromJson(json['alNacerPresento']),
      observaciones: json['observaciones'],
      antecedentesPostnatales:
          AntecedentesPostnatales.fromJson(json['antecedentesPostnatales']),
    );
  }
}
