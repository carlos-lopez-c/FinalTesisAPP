import 'package:h_c_1/hc_ps/domain/entities/hc_ps_adult/create_hc_adult.dart';
import 'package:h_c_1/hc_tr/domain/datasources/hc_datasource.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';
import 'package:h_c_1/hc_tr/domain/repositories/hc_repository.dart';
import 'package:h_c_1/hc_tr/infrastructure/datasources/hc_datasource_impl.dart';

class HcRepositoryImpl implements HcRepository {
  final HcDatasource datasource;

  HcRepositoryImpl({HcDatasource? datasource})
      : datasource = datasource ?? HcDatasourceImpl();
  @override
  Future<void> createHcGeneral(CreateHcGeneral hc) {
    return datasource.createHcGeneral(hc);
  }

  @override
  Future<void> createHcAdult(CreateHcAdultEntity hc) {
    return datasource.createHcAdult(hc);
  }

  @override
  Future<void> createHcVoice(CreateHcVoice hc) {
    return datasource.createHcVoice(hc);
  }

  @override
  Future<CreateHcGeneral> getHcGeneral(String cedula) {
    return datasource.getHcGeneral(cedula);
  }

  @override
  Future<CreateHcAdultEntity> getHcAdult(String cedula) {
    return datasource.getHcAdult(cedula);
  }

  @override
  Future<CreateHcVoice> getHcVoice(String cedula) {
    return datasource.getHcVoice(cedula);
  }

  @override
  Future<CreateHcPsAdult> getHcPsAdult(String cedula) {
    return datasource.getHcPsAdult(cedula);
  }

  @override
  Future<void> createHcPsAdult(CreateHcPsAdult hc) {
    return datasource.createHcPsAdult(hc);
  }

  @override
  Future<void> updateHcPsAdult(CreateHcPsAdult hc) {
    return datasource.updateHcPsAdult(hc);
  }

  @override
  Future<void> updateHcGeneral(CreateHcGeneral hc) {
    return datasource.updateHcGeneral(hc);
  }

  @override
  Future<void> updateHcAdult(CreateHcAdultEntity hc) {
    return datasource.updateHcAdult(hc);
  }

  @override
  Future<void> updateHcVoice(CreateHcVoice hc) {
    return datasource.updateHcVoice(hc);
  }

  @override
  Future<bool> existHcGeneral(String cedula) {
    return datasource.existHcGeneral(cedula);
  }

  @override
  Future<bool> existHcAdult(String cedula) {
    return datasource.existHcAdult(cedula);
  }

  @override
  Future<bool> existHcVoice(String cedula) {
    return datasource.existHcVoice(cedula);
  }

  @override
  Future<bool> existHcPsAdult(String cedula) {
    return datasource.existHcPsAdult(cedula);
  }
}
