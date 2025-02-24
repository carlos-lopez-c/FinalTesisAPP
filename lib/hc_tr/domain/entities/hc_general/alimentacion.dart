class Alimentacion {
  bool? materna;
  bool? artificial;
  bool? maticacion;

  Alimentacion({
    this.materna,
    this.artificial,
    this.maticacion,
  });

  Alimentacion copyWith({
    bool? materna,
    bool? artificial,
    bool? maticacion,
  }) {
    return Alimentacion(
      materna: materna ?? this.materna,
      artificial: artificial ?? this.artificial,
      maticacion: maticacion ?? this.maticacion,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materna': materna,
      'artificial': artificial,
      'maticacion': maticacion,
    };
  }

  factory Alimentacion.fromJson(Map<String, dynamic> json) {
    return Alimentacion(
      materna: json['materna'] ?? true,
      artificial: json['artificial'] ?? true,
      maticacion: json['maticacion'] ?? true,
    );
  }
}
