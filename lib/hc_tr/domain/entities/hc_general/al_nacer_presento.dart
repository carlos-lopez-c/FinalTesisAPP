class AlNacerPresento {
  bool? cianosis;
  bool? ictericia;
  bool? malformaciones;
  bool? circulacionDelCordonEnElCuello;
  bool? sufrimientoFetal;
  String peso;
  String talla;
  String perimetroCefalico;
  String apgar;

  AlNacerPresento({
    this.cianosis,
    this.ictericia,
    this.malformaciones,
    this.circulacionDelCordonEnElCuello,
    this.sufrimientoFetal,
    required this.peso,
    required this.talla,
    required this.perimetroCefalico,
    required this.apgar,
  });

  AlNacerPresento copyWith({
    bool? cianosis,
    bool? ictericia,
    bool? malformaciones,
    bool? circulacionDelCordonEnElCuello,
    bool? sufrimientoFetal,
    String? peso,
    String? talla,
    String? perimetroCefalico,
    String? apgar,
  }) {
    return AlNacerPresento(
      cianosis: cianosis ?? this.cianosis,
      ictericia: ictericia ?? this.ictericia,
      malformaciones: malformaciones ?? this.malformaciones,
      circulacionDelCordonEnElCuello:
          circulacionDelCordonEnElCuello ?? this.circulacionDelCordonEnElCuello,
      sufrimientoFetal: sufrimientoFetal ?? this.sufrimientoFetal,
      peso: peso ?? this.peso,
      talla: talla ?? this.talla,
      perimetroCefalico: perimetroCefalico ?? this.perimetroCefalico,
      apgar: apgar ?? this.apgar,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cianosis': cianosis,
      'ictericia': ictericia,
      'malformaciones': malformaciones,
      'circulacionDelCordonEnElCuello': circulacionDelCordonEnElCuello,
      'sufrimientoFetal': sufrimientoFetal,
      'peso': peso,
      'talla': talla,
      'perimetroCefalico': perimetroCefalico,
      'apgar': apgar,
    };
  }

  factory AlNacerPresento.fromJson(Map<String, dynamic> json) {
    return AlNacerPresento(
      cianosis: json['cianosis'],
      ictericia: json['ictericia'],
      malformaciones: json['malformaciones'],
      circulacionDelCordonEnElCuello: json['circulacionDelCordonEnElCuello'],
      sufrimientoFetal: json['sufrimientoFetal'],
      peso: json['peso'],
      talla: json['talla'],
      perimetroCefalico: json['perimetroCefalico'],
      apgar: json['apgar'],
    );
  }
}
