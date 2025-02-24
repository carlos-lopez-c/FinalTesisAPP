import 'package:h_c_1/hc_tr/domain/entities/hc_general/aspectos_socializacion.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/comportamiento_general.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/datos_familiares.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/integracion_sensorial.dart';

class HabitosPersonales {
  bool? berrinches;
  bool? insulta;
  bool? llora;
  bool? grita;
  bool? agrede;
  bool? seEncierra;
  bool? pideAyuda;
  bool? pegaALosPadres;
  String aptitudesEInteresesEscolares;
  String rendimientoGeneralEscolaridad;
  ComportamientoGeneral comportamientoGeneral;
  AspectosSocializacion aspectosSocializacion;
  DatosFamiliares datosFamiliares;
  String quienViveEnCasa;
  IntegracionSensorial integracionSensorial;

  HabitosPersonales({
    this.berrinches,
    this.insulta,
    this.llora,
    this.grita,
    this.agrede,
    this.seEncierra,
    this.pideAyuda,
    this.pegaALosPadres,
    required this.aptitudesEInteresesEscolares,
    required this.rendimientoGeneralEscolaridad,
    required this.comportamientoGeneral,
    required this.aspectosSocializacion,
    required this.datosFamiliares,
    required this.quienViveEnCasa,
    required this.integracionSensorial,
  });

  HabitosPersonales copyWith({
    bool? berrinches,
    bool? insulta,
    bool? llora,
    bool? grita,
    bool? agrede,
    bool? seEncierra,
    bool? pideAyuda,
    bool? pegaALosPadres,
    String? aptitudesEInteresesEscolares,
    String? rendimientoGeneralEscolaridad,
    ComportamientoGeneral? comportamientoGeneral,
    AspectosSocializacion? aspectosSocializacion,
    DatosFamiliares? datosFamiliares,
    String? quienViveEnCasa,
    IntegracionSensorial? integracionSensorial,
  }) {
    return HabitosPersonales(
      berrinches: berrinches ?? this.berrinches,
      insulta: insulta ?? this.insulta,
      llora: llora ?? this.llora,
      grita: grita ?? this.grita,
      agrede: agrede ?? this.agrede,
      seEncierra: seEncierra ?? this.seEncierra,
      pideAyuda: pideAyuda ?? this.pideAyuda,
      pegaALosPadres: pegaALosPadres ?? this.pegaALosPadres,
      aptitudesEInteresesEscolares:
          aptitudesEInteresesEscolares ?? this.aptitudesEInteresesEscolares,
      rendimientoGeneralEscolaridad:
          rendimientoGeneralEscolaridad ?? this.rendimientoGeneralEscolaridad,
      comportamientoGeneral:
          comportamientoGeneral ?? this.comportamientoGeneral,
      aspectosSocializacion:
          aspectosSocializacion ?? this.aspectosSocializacion,
      datosFamiliares: datosFamiliares ?? this.datosFamiliares,
      quienViveEnCasa: quienViveEnCasa ?? this.quienViveEnCasa,
      integracionSensorial: integracionSensorial ?? this.integracionSensorial,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'berrinches': berrinches,
      'insulta': insulta,
      'llora': llora,
      'grita': grita,
      'agrede': agrede,
      'seEncierra': seEncierra,
      'pideAyuda': pideAyuda,
      'pegaALosPadres': pegaALosPadres,
      'aptitudesEInteresesEscolares': aptitudesEInteresesEscolares,
      'rendimientoGeneralEscolaridad': rendimientoGeneralEscolaridad,
      'comportamientoGeneral': comportamientoGeneral.toJson(),
      'aspectosSocializacion': aspectosSocializacion.toJson(),
      'datosFamiliares': datosFamiliares.toJson(),
      'quienViveEnCasa': quienViveEnCasa,
      'integracionSensorial': integracionSensorial.toJson(),
    };
  }

  factory HabitosPersonales.fromJson(Map<String, dynamic> json) {
    return HabitosPersonales(
        berrinches: json['berrinches'],
        insulta: json['insulta'],
        llora: json['llora'],
        grita: json['grita'],
        agrede: json['agrede'],
        seEncierra: json['seEncierra'],
        pideAyuda: json['pideAyuda'],
        pegaALosPadres: json['pegaALosPadres'],
        aptitudesEInteresesEscolares: json['aptitudesEInteresesEscolares'],
        rendimientoGeneralEscolaridad: json['rendimientoGeneralEscolaridad'],
        comportamientoGeneral:
            ComportamientoGeneral.fromJson(json['comportamientoGeneral']),
        aspectosSocializacion:
            AspectosSocializacion.fromJson(json['aspectosSocializacion']),
        datosFamiliares: DatosFamiliares.fromJson(json['datosFamiliares']),
        quienViveEnCasa: json['quienViveEnCasa'],
        integracionSensorial:
            IntegracionSensorial.fromJson(json['integracionSensorial']));
  }
}
