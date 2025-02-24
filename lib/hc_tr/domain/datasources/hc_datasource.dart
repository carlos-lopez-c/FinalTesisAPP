import 'package:h_c_1/hc_ps/domain/entities/hc_ps_adult/create_hc_adult.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';

abstract class HcDatasource {
  Future<void> createHcGeneral(CreateHcGeneral hc);
  Future<void> createHcAdult(CreateHcAdultEntity hc);
  Future<void> createHcVoice(CreateHcVoice hc);
  Future<CreateHcGeneral> getHcGeneral(String cedula);
  Future<CreateHcAdultEntity> getHcAdult(String cedula);
  Future<CreateHcVoice> getHcVoice(String cedula);
  Future<CreateHcPsAdult> getHcPsAdult(String cedula);
  Future<void> createHcPsAdult(CreateHcPsAdult hc);
}
