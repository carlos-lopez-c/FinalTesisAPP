class AntecedentesTerapeuticos {
  bool? haRecibidoTratamientoMedicoPorProblemasDeLaVoz;
  bool? seHaRealizadoExamenes;
  bool? haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz;
  bool? haRecibidoTecnicaVocal;
  bool? aplicaLaTecnicaVocal;

  AntecedentesTerapeuticos({
    this.haRecibidoTratamientoMedicoPorProblemasDeLaVoz,
    this.seHaRealizadoExamenes,
    this.haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz,
    this.haRecibidoTecnicaVocal,
    this.aplicaLaTecnicaVocal,
  });

  AntecedentesTerapeuticos copyWith({
    bool? haRecibidoTratamientoMedicoPorProblemasDeLaVoz,
    bool? seHaRealizadoExamenes,
    bool? haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz,
    bool? haRecibidoTecnicaVocal,
    bool? aplicaLaTecnicaVocal,
  }) {
    return AntecedentesTerapeuticos(
      haRecibidoTratamientoMedicoPorProblemasDeLaVoz:
          haRecibidoTratamientoMedicoPorProblemasDeLaVoz ??
              this.haRecibidoTratamientoMedicoPorProblemasDeLaVoz,
      seHaRealizadoExamenes:
          seHaRealizadoExamenes ?? this.seHaRealizadoExamenes,
      haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz:
          haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz ??
              this.haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz,
      haRecibidoTecnicaVocal:
          haRecibidoTecnicaVocal ?? this.haRecibidoTecnicaVocal,
      aplicaLaTecnicaVocal: aplicaLaTecnicaVocal ?? this.aplicaLaTecnicaVocal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "haRecibidoTratamientoMedicoPorProblemasDeLaVoz":
          haRecibidoTratamientoMedicoPorProblemasDeLaVoz,
      "seHaRealizadoExamenes": seHaRealizadoExamenes,
      "haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz":
          haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz,
      "haRecibidoTecnicaVocal": haRecibidoTecnicaVocal,
      "aplicaLaTecnicaVocal": aplicaLaTecnicaVocal,
    };
  }

  factory AntecedentesTerapeuticos.fromJson(Map<String, dynamic> json) {
    return AntecedentesTerapeuticos(
      haRecibidoTratamientoMedicoPorProblemasDeLaVoz:
          json["haRecibidoTratamientoMedicoPorProblemasDeLaVoz"],
      seHaRealizadoExamenes: json["seHaRealizadoExamenes"],
      haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz:
          json["haRecibidoTratamientoFonoaudiologicoPorProblemasDeVoz"],
      haRecibidoTecnicaVocal: json["haRecibidoTecnicaVocal"],
      aplicaLaTecnicaVocal: json["aplicaLaTecnicaVocal"],
    );
  }
}
