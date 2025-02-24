class SaludBocal {
  final bool? cuentaConTodasSusPiezasDentales;
  final String porQueNoCuentaConTodasSusPiezasDentales;
  final bool? utilizaPlacaDental;
  final bool? seRealizaAseoBucalDespuesDeCadaComida;
  final String conQueFrecuenciaSeLavaLosDientes;
  final bool? asisteRegularmenteAControlesDentales;
  final String conQueFrecuenciaAsisteAControlesDentales;
  final bool? tieneAlgunaMolestiaODolorDentroDeSuBoca;
  final String queMolestiaODolor;

  SaludBocal({
    this.cuentaConTodasSusPiezasDentales,
    required this.porQueNoCuentaConTodasSusPiezasDentales,
    this.utilizaPlacaDental,
    this.seRealizaAseoBucalDespuesDeCadaComida,
    required this.conQueFrecuenciaSeLavaLosDientes,
    this.asisteRegularmenteAControlesDentales,
    required this.conQueFrecuenciaAsisteAControlesDentales,
    this.tieneAlgunaMolestiaODolorDentroDeSuBoca,
    required this.queMolestiaODolor,
  });

  SaludBocal copyWith({
    bool? cuentaConTodasSusPiezasDentales,
    String? porQueNoCuentaConTodasSusPiezasDentales,
    bool? utilizaPlacaDental,
    bool? seRealizaAseoBucalDespuesDeCadaComida,
    String? conQueFrecuenciaSeLavaLosDientes,
    bool? asisteRegularmenteAControlesDentales,
    String? conQueFrecuenciaAsisteAControlesDentales,
    bool? tieneAlgunaMolestiaODolorDentroDeSuBoca,
    String? queMolestiaODolor,
  }) {
    return SaludBocal(
      cuentaConTodasSusPiezasDentales: cuentaConTodasSusPiezasDentales ??
          this.cuentaConTodasSusPiezasDentales,
      porQueNoCuentaConTodasSusPiezasDentales:
          porQueNoCuentaConTodasSusPiezasDentales ??
              this.porQueNoCuentaConTodasSusPiezasDentales,
      utilizaPlacaDental: utilizaPlacaDental ?? this.utilizaPlacaDental,
      seRealizaAseoBucalDespuesDeCadaComida:
          seRealizaAseoBucalDespuesDeCadaComida ??
              this.seRealizaAseoBucalDespuesDeCadaComida,
      conQueFrecuenciaSeLavaLosDientes: conQueFrecuenciaSeLavaLosDientes ??
          this.conQueFrecuenciaSeLavaLosDientes,
      asisteRegularmenteAControlesDentales:
          asisteRegularmenteAControlesDentales ??
              this.asisteRegularmenteAControlesDentales,
      conQueFrecuenciaAsisteAControlesDentales:
          conQueFrecuenciaAsisteAControlesDentales ??
              this.conQueFrecuenciaAsisteAControlesDentales,
      tieneAlgunaMolestiaODolorDentroDeSuBoca:
          tieneAlgunaMolestiaODolorDentroDeSuBoca ??
              this.tieneAlgunaMolestiaODolorDentroDeSuBoca,
      queMolestiaODolor: queMolestiaODolor ?? this.queMolestiaODolor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cuentaConTodasSusPiezasDentales': cuentaConTodasSusPiezasDentales,
      'porQueNoCuentaConTodasSusPiezasDentales':
          porQueNoCuentaConTodasSusPiezasDentales,
      'utilizaPlacaDental': utilizaPlacaDental,
      'seRealizaAseoBucalDespuesDeCadaComida':
          seRealizaAseoBucalDespuesDeCadaComida,
      'conQueFrecuenciaSeLavaLosDientes': conQueFrecuenciaSeLavaLosDientes,
      'asisteRegularmenteAControlesDentales':
          asisteRegularmenteAControlesDentales,
      'conQueFrecuenciaAsisteAControlesDentales':
          conQueFrecuenciaAsisteAControlesDentales,
      'tieneAlgunaMolestiaODolorDentroDeSuBoca':
          tieneAlgunaMolestiaODolorDentroDeSuBoca,
      'queMolestiaODolor': queMolestiaODolor,
    };
  }

  factory SaludBocal.fromJson(Map<String, dynamic> json) {
    return SaludBocal(
      cuentaConTodasSusPiezasDentales: json['cuentaConTodasSusPiezasDentales'],
      porQueNoCuentaConTodasSusPiezasDentales:
          json['porQueNoCuentaConTodasSusPiezasDentales'],
      utilizaPlacaDental: json['utilizaPlacaDental'],
      seRealizaAseoBucalDespuesDeCadaComida:
          json['seRealizaAseoBucalDespuesDeCadaComida'],
      conQueFrecuenciaSeLavaLosDientes:
          json['conQueFrecuenciaSeLavaLosDientes'],
      asisteRegularmenteAControlesDentales:
          json['asisteRegularmenteAControlesDentales'],
      conQueFrecuenciaAsisteAControlesDentales:
          json['conQueFrecuenciaAsisteAControlesDentales'],
      tieneAlgunaMolestiaODolorDentroDeSuBoca:
          json['tieneAlgunaMolestiaODolorDentroDeSuBoca'],
      queMolestiaODolor: json['queMolestiaODolor'],
    );
  }
}
