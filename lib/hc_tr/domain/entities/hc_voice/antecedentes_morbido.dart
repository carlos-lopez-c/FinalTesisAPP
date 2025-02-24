class AntecedentesMorbidos {
  String problemasDeVozEnSuFamilia;
  String presentaAlgunaEnfermedad;
  bool? sufreDeEstres;
  String lasEmocionesDananSuVoz;
  String medicamentosQueToma;
  String accidentesOenfermedadesGravesQueHayaTenido;
  String haSidoIntervenidoQuirurgicamente;
  String haSidoEntubado;
  String haConsultadoConOtrosProfesionales;

  AntecedentesMorbidos({
    required this.problemasDeVozEnSuFamilia,
    required this.presentaAlgunaEnfermedad,
    this.sufreDeEstres,
    required this.lasEmocionesDananSuVoz,
    required this.medicamentosQueToma,
    required this.accidentesOenfermedadesGravesQueHayaTenido,
    required this.haSidoIntervenidoQuirurgicamente,
    required this.haSidoEntubado,
    required this.haConsultadoConOtrosProfesionales,
  });

  AntecedentesMorbidos copyWith({
    String? problemasDeVozEnSuFamilia,
    String? presentaAlgunaEnfermedad,
    bool? sufreDeEstres,
    String? lasEmocionesDananSuVoz,
    String? medicamentosQueToma,
    String? accidentesOenfermedadesGravesQueHayaTenido,
    String? haSidoIntervenidoQuirurgicamente,
    String? haSidoEntubado,
    String? haConsultadoConOtrosProfesionales,
  }) {
    return AntecedentesMorbidos(
      problemasDeVozEnSuFamilia:
          problemasDeVozEnSuFamilia ?? this.problemasDeVozEnSuFamilia,
      presentaAlgunaEnfermedad:
          presentaAlgunaEnfermedad ?? this.presentaAlgunaEnfermedad,
      sufreDeEstres: sufreDeEstres ?? this.sufreDeEstres,
      lasEmocionesDananSuVoz:
          lasEmocionesDananSuVoz ?? this.lasEmocionesDananSuVoz,
      medicamentosQueToma: medicamentosQueToma ?? this.medicamentosQueToma,
      accidentesOenfermedadesGravesQueHayaTenido:
          accidentesOenfermedadesGravesQueHayaTenido ??
              this.accidentesOenfermedadesGravesQueHayaTenido,
      haSidoIntervenidoQuirurgicamente: haSidoIntervenidoQuirurgicamente ??
          this.haSidoIntervenidoQuirurgicamente,
      haSidoEntubado: haSidoEntubado ?? this.haSidoEntubado,
      haConsultadoConOtrosProfesionales: haConsultadoConOtrosProfesionales ??
          this.haConsultadoConOtrosProfesionales,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "problemasDeVozEnSuFamilia": problemasDeVozEnSuFamilia,
      "presentaAlgunaEnfermedad": presentaAlgunaEnfermedad,
      "sufreDeEstres": sufreDeEstres,
      "lasEmocionesDañanSuVoz": lasEmocionesDananSuVoz,
      "medicamentosQueToma": medicamentosQueToma,
      "accidentesOenfermedadesGravesQueHayaTenido":
          accidentesOenfermedadesGravesQueHayaTenido,
      "haSidoIntervenidoQuirurgicamente": haSidoIntervenidoQuirurgicamente,
      "haSidoEntubado": haSidoEntubado,
      "haConsultadoConOtrosProfesionales": haConsultadoConOtrosProfesionales,
    };
  }

  factory AntecedentesMorbidos.fromJson(Map<String, dynamic> json) {
    return AntecedentesMorbidos(
      problemasDeVozEnSuFamilia: json["problemasDeVozEnSuFamilia"],
      presentaAlgunaEnfermedad: json["presentaAlgunaEnfermedad"],
      sufreDeEstres: json["sufreDeEstres"],
      lasEmocionesDananSuVoz: json["lasEmocionesDañanSuVoz"],
      medicamentosQueToma: json["medicamentosQueToma"],
      accidentesOenfermedadesGravesQueHayaTenido:
          json["accidentesOenfermedadesGravesQueHayaTenido"],
      haSidoIntervenidoQuirurgicamente:
          json["haSidoIntervenidoQuirurgicamente"],
      haSidoEntubado: json["haSidoEntubado"],
      haConsultadoConOtrosProfesionales:
          json["haConsultadoConOtrosProfesionales"],
    );
  }
}
