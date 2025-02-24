class DatosFamiliares {
  bool? nuclear;
  bool? monoParental;
  bool? funcional;
  bool? reconstituida;
  bool? disfuncional;
  bool? extensa;

  DatosFamiliares({
    this.nuclear,
    this.monoParental,
    this.funcional,
    this.reconstituida,
    this.disfuncional,
    this.extensa,
  });

  DatosFamiliares copyWith({
    bool? nuclear,
    bool? monoParental,
    bool? funcional,
    bool? reconstituida,
    bool? disfuncional,
    bool? extensa,
  }) {
    return DatosFamiliares(
      nuclear: nuclear ?? this.nuclear,
      monoParental: monoParental ?? this.monoParental,
      funcional: funcional ?? this.funcional,
      reconstituida: reconstituida ?? this.reconstituida,
      disfuncional: disfuncional ?? this.disfuncional,
      extensa: extensa ?? this.extensa,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nuclear': nuclear,
      'monoParental': monoParental,
      'funcional': funcional,
      'reconstituida': reconstituida,
      'disfuncional': disfuncional,
      'extensa': extensa,
    };
  }

  factory DatosFamiliares.fromJson(Map<String, dynamic> json) {
    return DatosFamiliares(
      nuclear: json['nuclear'],
      monoParental: json['monoParental'],
      funcional: json['funcional'],
      reconstituida: json['reconstituida'],
      disfuncional: json['disfuncional'],
      extensa: json['extensa'],
    );
  }
}
