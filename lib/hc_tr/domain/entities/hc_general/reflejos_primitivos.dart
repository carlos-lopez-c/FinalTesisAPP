class ReflejosPrimitivos {
  bool? palmar;
  bool? moro;
  bool? presion;
  bool? deBusqueda;
  bool? banbiski;

  ReflejosPrimitivos({
    this.palmar,
    this.moro,
    this.presion,
    this.deBusqueda,
    this.banbiski,
  });

  ReflejosPrimitivos copyWith({
    bool? palmar,
    bool? moro,
    bool? presion,
    bool? deBusqueda,
    bool? banbiski,
  }) {
    return ReflejosPrimitivos(
      palmar: palmar ?? this.palmar,
      moro: moro ?? this.moro,
      presion: presion ?? this.presion,
      deBusqueda: deBusqueda ?? this.deBusqueda,
      banbiski: banbiski ?? this.banbiski,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'palmar': palmar,
      'moro': moro,
      'presion': presion,
      'deBusqueda': deBusqueda,
      'banbiski': banbiski,
    };
  }

  factory ReflejosPrimitivos.fromJson(Map<String, dynamic> json) {
    return ReflejosPrimitivos(
      palmar: json['palmar'],
      moro: json['moro'],
      presion: json['presion'],
      deBusqueda: json['deBusqueda'],
      banbiski: json['banbiski'],
    );
  }
}
