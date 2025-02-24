class AlNacerNecesito {
  bool? incubadora;
  bool? oxigeno;
  String? tiempo;

  AlNacerNecesito({
    this.incubadora,
    this.oxigeno,
    this.tiempo,
  });

  AlNacerNecesito copyWith({
    bool? incubadora,
    bool? oxigeno,
    String? tiempo,
  }) {
    return AlNacerNecesito(
        incubadora: incubadora ?? this.incubadora,
        oxigeno: oxigeno ?? this.oxigeno,
        tiempo: tiempo ?? this.tiempo);
  }

  Map<String, dynamic> toJson() {
    return {
      'incubadora': incubadora,
      'oxigeno': oxigeno,
      'tiempo': tiempo,
    };
  }

  factory AlNacerNecesito.fromJson(Map<String, dynamic> json) {
    return AlNacerNecesito(
      incubadora: json['incubadora'],
      oxigeno: json['oxigeno'],
      tiempo: json['tiempo'],
    );
  }
}
