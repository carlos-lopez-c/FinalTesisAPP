class MalUsoVocal {
  bool? trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo;
  bool? trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual;
  bool? cantaFueraDeSuRegistro;
  bool? cantaSinVocalizar;

  MalUsoVocal({
    this.trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo,
    this.trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual,
    this.cantaFueraDeSuRegistro,
    this.cantaSinVocalizar,
  });

  MalUsoVocal copyWith({
    bool? trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo,
    bool? trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual,
    bool? cantaFueraDeSuRegistro,
    bool? cantaSinVocalizar,
  }) {
    return MalUsoVocal(
      trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo:
          trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo ??
              this.trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo,
      trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual:
          trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual ??
              this.trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual,
      cantaFueraDeSuRegistro:
          cantaFueraDeSuRegistro ?? this.cantaFueraDeSuRegistro,
      cantaSinVocalizar: cantaSinVocalizar ?? this.cantaSinVocalizar,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo":
          trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo,
      "trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual":
          trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual,
      "cantaFueraDeSuRegistro": cantaFueraDeSuRegistro,
      "cantaSinVocalizar": cantaSinVocalizar,
    };
  }

  factory MalUsoVocal.fromJson(Map<String, dynamic> json) {
    return MalUsoVocal(
      trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo:
          json["trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo"],
      trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual:
          json["trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual"],
      cantaFueraDeSuRegistro: json["cantaFueraDeSuRegistro"],
      cantaSinVocalizar: json["cantaSinVocalizar"],
    );
  }
}
