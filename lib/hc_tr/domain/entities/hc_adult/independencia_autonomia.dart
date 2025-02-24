class IndependenciaAutonomia {
  final String seAlimentaSoloOConAyuda;
  final String queTipoDeAyudaNecesita;
  final bool? preparaSusAlimentos;
  final String quePrepara;
  final bool? decideQueComer;

  IndependenciaAutonomia({
    required this.seAlimentaSoloOConAyuda,
    required this.queTipoDeAyudaNecesita,
    this.preparaSusAlimentos,
    required this.quePrepara,
    this.decideQueComer,
  });

  IndependenciaAutonomia copyWith({
    String? seAlimentaSoloOConAyuda,
    String? queTipoDeAyudaNecesita,
    bool? preparaSusAlimentos,
    String? quePrepara,
    bool? decideQueComer,
  }) {
    return IndependenciaAutonomia(
      seAlimentaSoloOConAyuda:
          seAlimentaSoloOConAyuda ?? this.seAlimentaSoloOConAyuda,
      queTipoDeAyudaNecesita:
          queTipoDeAyudaNecesita ?? this.queTipoDeAyudaNecesita,
      preparaSusAlimentos: preparaSusAlimentos ?? this.preparaSusAlimentos,
      quePrepara: quePrepara ?? this.quePrepara,
      decideQueComer: decideQueComer ?? this.decideQueComer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seAlimentaSoloOConAyuda': seAlimentaSoloOConAyuda,
      'queTipoDeAyudaNecesita': queTipoDeAyudaNecesita,
      'preparaSusAlimentos': preparaSusAlimentos,
      'quePrepara': quePrepara,
      'decideQueComer': decideQueComer,
    };
  }

  factory IndependenciaAutonomia.fromJson(Map<String, dynamic> json) {
    return IndependenciaAutonomia(
      seAlimentaSoloOConAyuda: json['seAlimentaSoloOConAyuda'],
      queTipoDeAyudaNecesita: json['queTipoDeAyudaNecesita'],
      preparaSusAlimentos: json['preparaSusAlimentos'],
      quePrepara: json['quePrepara'],
      decideQueComer: json['decideQueComer'],
    );
  }
}
