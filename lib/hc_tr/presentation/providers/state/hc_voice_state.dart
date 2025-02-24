import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';

class HcVoiceState {
  final bool loading;
  final String errorMessage;
  final String successMessage;
  final CreateHcVoice createHcVoice;
  final String cedula;
  final String tipo;

  HcVoiceState({
    this.loading = false,
    this.successMessage = '',
    this.errorMessage = '',
    this.tipo = '',
    required this.createHcVoice,
    this.cedula = '',
  });

  HcVoiceState copyWith({
    bool? loading,
    String? tipo,
    String? successMessage,
    String? errorMessage,
    CreateHcVoice? createHcVoice,
    String? cedula,
  }) {
    return HcVoiceState(
      loading: loading ?? this.loading,
      tipo: tipo ?? this.tipo,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      createHcVoice: createHcVoice ?? this.createHcVoice,
      cedula: cedula ?? this.cedula,
    );
  }
}
