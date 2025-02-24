class IntegracionSensorial {
  bool? vista;
  bool? oido;
  bool? tacto;
  bool? gustoYolfato;

  IntegracionSensorial({
    this.vista,
    this.oido,
    this.tacto,
    this.gustoYolfato,
  });

  IntegracionSensorial copyWith({
    bool? vista,
    bool? oido,
    bool? tacto,
    bool? gustoYolfato,
  }) {
    return IntegracionSensorial(
      vista: vista ?? this.vista,
      oido: oido ?? this.oido,
      tacto: tacto ?? this.tacto,
      gustoYolfato: gustoYolfato ?? this.gustoYolfato,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vista': vista,
      'oido': oido,
      'tacto': tacto,
      'gustoYolfato': gustoYolfato,
    };
  }

  factory IntegracionSensorial.fromJson(Map<String, dynamic> json) {
    return IntegracionSensorial(
      vista: json['vista'],
      oido: json['oido'],
      tacto: json['tacto'],
      gustoYolfato: json['gustoYolfato'],
    );
  }
}
