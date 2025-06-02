import 'package:h_c_1/hc_tr/domain/entities/hc_voice/abuso_verbal.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/antecedentes_morbido.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/antecedentes_terapeuticos.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/factores_externos.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/habitos_generales.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/historia_clinica.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/mal_uso_verbal.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/sintomalogia.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/uso_laboral_profesional_de_la_voz.dart';

class CreateHcVoice {
  String? id;
  String patientId;
  String nombreCompleto;
  String fechaNacimiento;
  String estadoCivil;
  String ocupacionActual;
  String direccion;
  String derivadoPor;
  String razonDeDerivacion;
  String diagnosticoORL;
  String telefonoDeContacto;
  String fechaDeEvaluacion;
  HistoriaClinica historiaClinica;
  Sintomologia sintomologia;
  AntecedentesMorbidos antecedentesMorbidos;
  AntecedentesTerapeuticos antecedentesTerapeuticos;
  AbusoVocal abusoVocal;
  MalUsoVocal malUsoVocal;
  FactoresExternos factoresExternos;
  HabitosGenerales habitosGenerales;
  UsoLaboralProfesionalDeLaVoz usoLaboralProfesionalDeLaVoz;

  CreateHcVoice({
    this.id,
    required this.patientId,
    required this.nombreCompleto,
    required this.fechaNacimiento,
    required this.estadoCivil,
    required this.ocupacionActual,
    required this.direccion,
    required this.derivadoPor,
    required this.razonDeDerivacion,
    required this.diagnosticoORL,
    required this.telefonoDeContacto,
    required this.fechaDeEvaluacion,
    required this.historiaClinica,
    required this.sintomologia,
    required this.antecedentesMorbidos,
    required this.antecedentesTerapeuticos,
    required this.abusoVocal,
    required this.malUsoVocal,
    required this.factoresExternos,
    required this.habitosGenerales,
    required this.usoLaboralProfesionalDeLaVoz,
  });

  CreateHcVoice copyWith({
    String? id,
    String? patientId,
    String? nombreCompleto,
    String? fechaNacimiento,
    String? estadoCivil,
    String? ocupacionActual,
    String? direccion,
    String? derivadoPor,
    String? razonDeDerivacion,
    String? diagnosticoORL,
    String? telefonoDeContacto,
    String? fechaDeEvaluacion,
    HistoriaClinica? historiaClinica,
    Sintomologia? sintomologia,
    AntecedentesMorbidos? antecedentesMorbidos,
    AntecedentesTerapeuticos? antecedentesTerapeuticos,
    AbusoVocal? abusoVocal,
    MalUsoVocal? malUsoVocal,
    FactoresExternos? factoresExternos,
    HabitosGenerales? habitosGenerales,
    UsoLaboralProfesionalDeLaVoz? usoLaboralProfesionalDeLaVoz,
  }) {
    return CreateHcVoice(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      estadoCivil: estadoCivil ?? this.estadoCivil,
      ocupacionActual: ocupacionActual ?? this.ocupacionActual,
      direccion: direccion ?? this.direccion,
      derivadoPor: derivadoPor ?? this.derivadoPor,
      razonDeDerivacion: razonDeDerivacion ?? this.razonDeDerivacion,
      diagnosticoORL: diagnosticoORL ?? this.diagnosticoORL,
      telefonoDeContacto: telefonoDeContacto ?? this.telefonoDeContacto,
      fechaDeEvaluacion: fechaDeEvaluacion ?? this.fechaDeEvaluacion,
      historiaClinica: historiaClinica ?? this.historiaClinica,
      sintomologia: sintomologia ?? this.sintomologia,
      antecedentesMorbidos: antecedentesMorbidos ?? this.antecedentesMorbidos,
      antecedentesTerapeuticos:
          antecedentesTerapeuticos ?? this.antecedentesTerapeuticos,
      abusoVocal: abusoVocal ?? this.abusoVocal,
      malUsoVocal: malUsoVocal ?? this.malUsoVocal,
      factoresExternos: factoresExternos ?? this.factoresExternos,
      habitosGenerales: habitosGenerales ?? this.habitosGenerales,
      usoLaboralProfesionalDeLaVoz:
          usoLaboralProfesionalDeLaVoz ?? this.usoLaboralProfesionalDeLaVoz,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "patientId": patientId,
      "nombreCompleto": nombreCompleto,
      "fechaNacimiento": fechaNacimiento,
      "estadoCivil": estadoCivil,
      "ocupacionActual": ocupacionActual,
      "direccion": direccion,
      "derivadoPor": derivadoPor,
      "razonDeDerivacion": razonDeDerivacion,
      "diagnosticoORL": diagnosticoORL,
      "telefonoDeContacto": telefonoDeContacto,
      "fechaDeEvaluacion": fechaDeEvaluacion,
      "historiaClinica": historiaClinica.toJson(),
      "sintomologia": sintomologia.toJson(),
      "antecendentesMorbidos": antecedentesMorbidos.toJson(),
      "antecedentesTerapeuticos": antecedentesTerapeuticos.toJson(),
      "abusoVocal": abusoVocal.toJson(),
      "malUsoVocal": malUsoVocal.toJson(),
      "factoresExternos": factoresExternos.toJson(),
      "habitosGenerales": habitosGenerales.toJson(),
      "usoLaboralProfesionalDeLaVoz": usoLaboralProfesionalDeLaVoz.toJson(),
    };
  }

  factory CreateHcVoice.fromJson(Map<String, dynamic> json) {
    return CreateHcVoice(
      id: json["id"],
      patientId: json["patientId"],
      nombreCompleto: json["nombreCompleto"],
      fechaNacimiento: json["fechaNacimiento"],
      estadoCivil: json["estadoCivil"],
      ocupacionActual: json["ocupacionActual"],
      direccion: json["direccion"],
      derivadoPor: json["derivadoPor"],
      razonDeDerivacion: json["razonDeDerivacion"],
      diagnosticoORL: json["diagnosticoORL"],
      telefonoDeContacto: json["telefonoDeContacto"],
      fechaDeEvaluacion: json["fechaDeEvaluacion"],
      historiaClinica: HistoriaClinica.fromJson(json["historiaClinica"]),
      sintomologia: Sintomologia.fromJson(json["sintomologia"]),
      antecedentesMorbidos:
          AntecedentesMorbidos.fromJson(json["antecendentesMorbidos"]),
      antecedentesTerapeuticos:
          AntecedentesTerapeuticos.fromJson(json["antecedentesTerapeuticos"]),
      abusoVocal: AbusoVocal.fromJson(json["abusoVocal"]),
      malUsoVocal: MalUsoVocal.fromJson(json["malUsoVocal"]),
      factoresExternos: FactoresExternos.fromJson(json["factoresExternos"]),
      habitosGenerales: HabitosGenerales.fromJson(json["habitosGenerales"]),
      usoLaboralProfesionalDeLaVoz: UsoLaboralProfesionalDeLaVoz.fromJson(
          json["usoLaboralProfesionalDeLaVoz"]),
    );
  }
}
