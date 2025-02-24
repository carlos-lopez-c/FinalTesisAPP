import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';

class HcAdultState {
  final bool loading;
  final String tipo;
  final String successMessage;
  final String errorMessage;
  final CreateHcAdultEntity createHcAdult;
  final String cedula;

  HcAdultState({
    this.successMessage = '',
    this.loading = false,
    this.tipo = '',
    this.errorMessage = '',
    required this.createHcAdult,
    this.cedula = '',
  });

  HcAdultState copyWith({
    String successMessage = '',
    String? tipo,
    bool? loading,
    String? errorMessage,
    CreateHcAdultEntity? createHcAdult,
    String? cedula,
  }) {
    return HcAdultState(
      loading: loading ?? this.loading,
      tipo: tipo ?? this.tipo,
      successMessage: successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      createHcAdult: createHcAdult ?? this.createHcAdult,
      cedula: cedula ?? this.cedula,
    );
  }
}
