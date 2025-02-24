class Eficiencia {
  final bool? consumeLaTotalidadDeLosAlimentos;
  final String quePorcionConsume;
  final bool? haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo;
  final double cuantoPesoHaPerdido;
  final bool? manifiestaInteresPorAlimentarse;
  final bool? manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento;
  final String queTipoDeAlimento;
  final String queTipoDeLiquidoConsumeHabitualmente;
  final String cuantoLiquidoConsumeAlDia;

  Eficiencia({
    this.consumeLaTotalidadDeLosAlimentos,
    required this.quePorcionConsume,
    this.haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo,
    required this.cuantoPesoHaPerdido,
    this.manifiestaInteresPorAlimentarse,
    this.manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento,
    required this.queTipoDeAlimento,
    required this.queTipoDeLiquidoConsumeHabitualmente,
    required this.cuantoLiquidoConsumeAlDia,
  });

  Eficiencia copyWith({
    bool? consumeLaTotalidadDeLosAlimentos,
    String? quePorcionConsume,
    bool? haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo,
    double? cuantoPesoHaPerdido,
    bool? manifiestaInteresPorAlimentarse,
    bool? manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento,
    String? queTipoDeAlimento,
    String? queTipoDeLiquidoConsumeHabitualmente,
    String? cuantoLiquidoConsumeAlDia,
  }) {
    return Eficiencia(
      consumeLaTotalidadDeLosAlimentos: consumeLaTotalidadDeLosAlimentos ??
          this.consumeLaTotalidadDeLosAlimentos,
      quePorcionConsume: quePorcionConsume ?? this.quePorcionConsume,
      haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo:
          haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo ??
              this.haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo,
      cuantoPesoHaPerdido: cuantoPesoHaPerdido ?? this.cuantoPesoHaPerdido,
      manifiestaInteresPorAlimentarse: manifiestaInteresPorAlimentarse ??
          this.manifiestaInteresPorAlimentarse,
      manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento:
          manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento ??
              this.manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento,
      queTipoDeAlimento: queTipoDeAlimento ?? this.queTipoDeAlimento,
      queTipoDeLiquidoConsumeHabitualmente:
          queTipoDeLiquidoConsumeHabitualmente ??
              this.queTipoDeLiquidoConsumeHabitualmente,
      cuantoLiquidoConsumeAlDia:
          cuantoLiquidoConsumeAlDia ?? this.cuantoLiquidoConsumeAlDia,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'consumeLaTotalidadDeLosAlimentos': consumeLaTotalidadDeLosAlimentos,
      'quePorcionConsume': quePorcionConsume,
      'haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo':
          haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo,
      'cuantoPesoHaPerdido': cuantoPesoHaPerdido,
      'manifiestaInteresPorAlimentarse': manifiestaInteresPorAlimentarse,
      'manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento':
          manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento,
      'queTipoDeAlimento': queTipoDeAlimento,
      'queTipoDeLiquidoConsumeHabitualmente':
          queTipoDeLiquidoConsumeHabitualmente,
      'cuantoLiquidoConsumeAlDia': cuantoLiquidoConsumeAlDia,
    };
  }

  factory Eficiencia.fromJson(Map<String, dynamic> json) {
    return Eficiencia(
      consumeLaTotalidadDeLosAlimentos:
          json['consumeLaTotalidadDeLosAlimentos'],
      quePorcionConsume: json['quePorcionConsume'],
      haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo:
          json['haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo'],
      cuantoPesoHaPerdido: json['cuantoPesoHaPerdido'],
      manifiestaInteresPorAlimentarse: json['manifiestaInteresPorAlimentarse'],
      manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento:
          json['manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento'],
      queTipoDeAlimento: json['queTipoDeAlimento'],
      queTipoDeLiquidoConsumeHabitualmente:
          json['queTipoDeLiquidoConsumeHabitualmente'],
      cuantoLiquidoConsumeAlDia: json['cuantoLiquidoConsumeAlDia'],
    );
  }
}
