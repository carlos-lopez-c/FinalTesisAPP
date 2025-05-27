import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';

class HcGeneralFormState {
  final bool loading;
  final String errorMessage;
  final String successMessage;
  final CreateHcGeneral createHcGeneral;
  final String tipo;
  final String cedula;
  final int edad;
  final String status;

  HcGeneralFormState({
    this.loading = false,
    this.successMessage = '',
    this.errorMessage = '',
    this.tipo = 'Nuevo',
    required this.createHcGeneral,
    this.cedula = '',
    this.edad = 0,
    this.status = 'Nuevo',
  });

  HcGeneralFormState copyWith({
    bool? loading,
    String? errorMessage,
    String? successMessage,
    String? tipo,
    CreateHcGeneral? createHcGeneral,
    String? cedula,
    int? edad,
    String? status,
  }) {
    return HcGeneralFormState(
      loading: loading ?? this.loading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      createHcGeneral: createHcGeneral ?? this.createHcGeneral,
      cedula: cedula ?? this.cedula,
      tipo: tipo ?? this.tipo,
      edad: edad ?? this.edad,
      status: status ?? this.status,
    );
  }
}
