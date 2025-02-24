class Sintomologia {
  String fonastenia;
  String fonalgia;
  bool? tensionEnFonacion;
  bool? sensacionDeConstriccionEnElCuello;
  bool? sensacionDeCuerpoExtrano;
  bool? descargaPosterior;
  bool? odinofagia;
  bool? extensionTonalReducida;
  bool? picorLaringeo;

  Sintomologia({
    required this.fonastenia,
    required this.fonalgia,
    this.tensionEnFonacion,
    this.sensacionDeConstriccionEnElCuello,
    this.sensacionDeCuerpoExtrano,
    this.descargaPosterior,
    this.odinofagia,
    this.extensionTonalReducida,
    this.picorLaringeo,
  });

  Sintomologia copyWith({
    String? fonastenia,
    String? fonalgia,
    bool? tensionEnFonacion,
    bool? sensacionDeConstriccionEnElCuello,
    bool? sensacionDeCuerpoExtrano,
    bool? descargaPosterior,
    bool? odinofagia,
    bool? extensionTonalReducida,
    bool? picorLaringeo,
  }) {
    return Sintomologia(
      fonastenia: fonastenia ?? this.fonastenia,
      fonalgia: fonalgia ?? this.fonalgia,
      tensionEnFonacion: tensionEnFonacion ?? this.tensionEnFonacion,
      sensacionDeConstriccionEnElCuello: sensacionDeConstriccionEnElCuello ??
          this.sensacionDeConstriccionEnElCuello,
      sensacionDeCuerpoExtrano:
          sensacionDeCuerpoExtrano ?? this.sensacionDeCuerpoExtrano,
      descargaPosterior: descargaPosterior ?? this.descargaPosterior,
      odinofagia: odinofagia ?? this.odinofagia,
      extensionTonalReducida:
          extensionTonalReducida ?? this.extensionTonalReducida,
      picorLaringeo: picorLaringeo ?? this.picorLaringeo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fonastenia": fonastenia,
      "fonalgia": fonalgia,
      "tensionEnFonacion": tensionEnFonacion,
      "sensacionDeConstriccionEnElCuello": sensacionDeConstriccionEnElCuello,
      "sensacionDeCuerpoExtrano": sensacionDeCuerpoExtrano,
      "descargaPosterior": descargaPosterior,
      "odinofagia": odinofagia,
      "extensionTonalReducida": extensionTonalReducida,
      "picorLaringeo": picorLaringeo,
    };
  }

  factory Sintomologia.fromJson(Map<String, dynamic> json) {
    return Sintomologia(
      fonastenia: json["fonastenia"],
      fonalgia: json["fonalgia"],
      tensionEnFonacion: json["tensionEnFonacion"],
      sensacionDeConstriccionEnElCuello:
          json["sensacionDeConstriccionEnElCuello"],
      sensacionDeCuerpoExtrano: json["sensacionDeCuerpoExtrano"],
      descargaPosterior: json["descargaPosterior"],
      odinofagia: json["odinofagia"],
      extensionTonalReducida: json["extensionTonalReducida"],
      picorLaringeo: json["picorLaringeo"],
    );
  }
}
