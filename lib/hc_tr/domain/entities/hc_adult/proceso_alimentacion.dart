class ProcesoDeAlimentacion {
  final bool? seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer;
  final String cuantoTiempo;
  final bool? creeUstedQueComeMuyRapido;
  final bool? sueleRealizarAlgunaOtraActividadMientrasCome;
  final String queOtraActividad;

  ProcesoDeAlimentacion({
     this.seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer,
    required this.cuantoTiempo,
     this.creeUstedQueComeMuyRapido,
     this.sueleRealizarAlgunaOtraActividadMientrasCome,
    required this.queOtraActividad,
  });

  ProcesoDeAlimentacion copyWith({
    bool? seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer,
    String? cuantoTiempo,
    bool? creeUstedQueComeMuyRapido,
    bool? sueleRealizarAlgunaOtraActividadMientrasCome,
    String? queOtraActividad,
  }) {
    return ProcesoDeAlimentacion(
      seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer:
          seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer ??
              this.seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer,
      cuantoTiempo: cuantoTiempo ?? this.cuantoTiempo,
      creeUstedQueComeMuyRapido:
          creeUstedQueComeMuyRapido ?? this.creeUstedQueComeMuyRapido,
      sueleRealizarAlgunaOtraActividadMientrasCome:
          sueleRealizarAlgunaOtraActividadMientrasCome ??
              this.sueleRealizarAlgunaOtraActividadMientrasCome,
      queOtraActividad: queOtraActividad ?? this.queOtraActividad,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer':
          seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer,
      'cuantoTiempo': cuantoTiempo,
      'creeUstedQueComeMuyRapido': creeUstedQueComeMuyRapido,
      'sueleRealizarAlgunaOtraActividadMientrasCome':
          sueleRealizarAlgunaOtraActividadMientrasCome,
      'queOtraActividad': queOtraActividad,
    };
  }

  factory ProcesoDeAlimentacion.fromJson(Map<String, dynamic> json) {
    return ProcesoDeAlimentacion(
      seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer:
          json['seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer'],
      cuantoTiempo: json['cuantoTiempo'],
      creeUstedQueComeMuyRapido: json['creeUstedQueComeMuyRapido'],
      sueleRealizarAlgunaOtraActividadMientrasCome:
          json['sueleRealizarAlgunaOtraActividadMientrasCome'],
      queOtraActividad: json['queOtraActividad'],
    );
  }
}
