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
}
