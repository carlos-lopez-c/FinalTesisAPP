class AspectosSocializacion {
  bool? mayores;
  bool? menores;
  bool? todos;
  bool? socializacionConFamilia;
  bool? reaccionConPersonasExtranas;
  bool? lograConcentrarse5Min;
  bool? reconocePartesDelCuerpo;
  bool? asociaObjetos;
  bool? reconoceASusFamiliares;
  bool? reconoceColoresBasicos;

  AspectosSocializacion({
    this.mayores,
    this.menores,
    this.todos,
    this.socializacionConFamilia,
    this.reaccionConPersonasExtranas,
    this.lograConcentrarse5Min,
    this.reconocePartesDelCuerpo,
    this.asociaObjetos,
    this.reconoceASusFamiliares,
    this.reconoceColoresBasicos,
  });

  AspectosSocializacion copyWith({
    bool? mayores,
    bool? menores,
    bool? todos,
    bool? socializacionConFamilia,
    bool? reaccionConPersonasExtranas,
    bool? lograConcentrarse5Min,
    bool? reconocePartesDelCuerpo,
    bool? asociaObjetos,
    bool? reconoceASusFamiliares,
    bool? reconoceColoresBasicos,
  }) {
    return AspectosSocializacion(
      mayores: mayores ?? this.mayores,
      menores: menores ?? this.menores,
      todos: todos ?? this.todos,
      socializacionConFamilia:
          socializacionConFamilia ?? this.socializacionConFamilia,
      reaccionConPersonasExtranas:
          reaccionConPersonasExtranas ?? this.reaccionConPersonasExtranas,
      lograConcentrarse5Min:
          lograConcentrarse5Min ?? this.lograConcentrarse5Min,
      reconocePartesDelCuerpo:
          reconocePartesDelCuerpo ?? this.reconocePartesDelCuerpo,
      asociaObjetos: asociaObjetos ?? this.asociaObjetos,
      reconoceASusFamiliares:
          reconoceASusFamiliares ?? this.reconoceASusFamiliares,
      reconoceColoresBasicos:
          reconoceColoresBasicos ?? this.reconoceColoresBasicos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mayores': mayores,
      'menores': menores,
      'todos': todos,
      'socializacionConFamilia': socializacionConFamilia,
      'reaccionConPersonasExtrañas': reaccionConPersonasExtranas,
      'lograConcentrarse5Min': lograConcentrarse5Min,
      'reconocePartesDelCuerpo': reconocePartesDelCuerpo,
      'asociaObjetos': asociaObjetos,
      'reconoceASusFamiliares': reconoceASusFamiliares,
      'reconoceColoresBasicos': reconoceColoresBasicos,
    };
  }

  factory AspectosSocializacion.fromJson(Map<String, dynamic> json) {
    return AspectosSocializacion(
      mayores: json['mayores'],
      menores: json['menores'],
      todos: json['todos'],
      socializacionConFamilia: json['socializacionConFamilia'],
      reaccionConPersonasExtranas: json['reaccionConPersonasExtrañas'],
      lograConcentrarse5Min: json['lograConcentrarse5Min'],
      reconocePartesDelCuerpo: json['reconocePartesDelCuerpo'],
      asociaObjetos: json['asociaObjetos'],
      reconoceASusFamiliares: json['reconoceASusFamiliares'],
      reconoceColoresBasicos: json['reconoceColoresBasicos'],
    );
  }
}
