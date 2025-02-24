class AntecedentesPersonales {
  bool? deseado;
  bool? automedicacion;
  bool? depresion;
  bool? estres;
  bool? ansiedad;
  bool? traumatismo;
  bool? radiaciones;
  bool? medicina;
  bool? riesgoDeAborto;
  bool? maltratoFisico;
  bool? consumoDeDrogas;
  bool? consumoDeAlcohol;
  bool? consumoDeTabaco;
  bool? hipertension;
  bool? dietaBalanceada;

  AntecedentesPersonales({
    this.deseado,
    this.automedicacion,
    this.depresion,
    this.estres,
    this.ansiedad,
    this.traumatismo,
    this.radiaciones,
    this.medicina,
    this.riesgoDeAborto,
    this.maltratoFisico,
    this.consumoDeDrogas,
    this.consumoDeAlcohol,
    this.consumoDeTabaco,
    this.hipertension,
    this.dietaBalanceada,
  });

  AntecedentesPersonales copyWith({
    bool? deseado,
    bool? automedicacion,
    bool? depresion,
    bool? estres,
    bool? ansiedad,
    bool? traumatismo,
    bool? radiaciones,
    bool? medicina,
    bool? riesgoDeAborto,
    bool? maltratoFisico,
    bool? consumoDeDrogas,
    bool? consumoDeAlcohol,
    bool? consumoDeTabaco,
    bool? hipertension,
    bool? dietaBalanceada,
  }) {
    return AntecedentesPersonales(
      deseado: deseado ?? this.deseado,
      automedicacion: automedicacion ?? this.automedicacion,
      depresion: depresion ?? this.depresion,
      estres: estres ?? this.estres,
      ansiedad: ansiedad ?? this.ansiedad,
      traumatismo: traumatismo ?? this.traumatismo,
      radiaciones: radiaciones ?? this.radiaciones,
      medicina: medicina ?? this.medicina,
      riesgoDeAborto: riesgoDeAborto ?? this.riesgoDeAborto,
      maltratoFisico: maltratoFisico ?? this.maltratoFisico,
      consumoDeDrogas: consumoDeDrogas ?? this.consumoDeDrogas,
      consumoDeAlcohol: consumoDeAlcohol ?? this.consumoDeAlcohol,
      consumoDeTabaco: consumoDeTabaco ?? this.consumoDeTabaco,
      hipertension: hipertension ?? this.hipertension,
      dietaBalanceada: dietaBalanceada ?? this.dietaBalanceada,
    );
  }

  Map<String, dynamic> toJson() => {
        'deseado': deseado,
        'automedicacion': automedicacion,
        'depresion': depresion,
        'estres': estres,
        'ansiedad': ansiedad,
        'traumatismo': traumatismo,
        'radiaciones': radiaciones,
        'medicina': medicina,
        'riesgoDeAborto': riesgoDeAborto,
        'maltratoFisico': maltratoFisico,
        'consumoDeDrogas': consumoDeDrogas,
        'consumoDeAlcohol': consumoDeAlcohol,
        'consumoDeTabaco': consumoDeTabaco,
        'hipertension': hipertension,
        'dietaBalanceada': dietaBalanceada,
      };

  factory AntecedentesPersonales.fromJson(Map<String, dynamic> json) =>
      AntecedentesPersonales(
        deseado: json['deseado'],
        automedicacion: json['automedicacion'],
        depresion: json['depresion'],
        estres: json['estres'],
        ansiedad: json['ansiedad'],
        traumatismo: json['traumatismo'],
        radiaciones: json['radiaciones'],
        medicina: json['medicina'],
        riesgoDeAborto: json['riesgoDeAborto'],
        maltratoFisico: json['maltratoFisico'],
        consumoDeDrogas: json['consumoDeDrogas'],
        consumoDeAlcohol: json['consumoDeAlcohol'],
        consumoDeTabaco: json['consumoDeTabaco'],
        hipertension: json['hipertension'],
        dietaBalanceada: json['dietaBalanceada'],
      );
}
