import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';
import 'package:h_c_1/hc_tr/domain/repositories/hc_repository.dart';
import 'package:h_c_1/hc_tr/infrastructure/repositories/hc_repository_impl.dart';
import 'package:h_c_1/shared/infrastructure/errors/custom_error.dart';

final hcProvider = StateNotifierProvider<HcNotifier, HCState>((ref) {
  final hcRepository = HcRepositoryImpl();
  return HcNotifier(hcRepository);
});

class HcNotifier extends StateNotifier<HCState> {
  final HcRepository _hcRepository;
  HcNotifier(this._hcRepository) : super(HCState());

  Future<void> createHcGeneral(CreateHcGeneral hc) async {
    print('🟢 Creando historia clínica');
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.createHcGeneral(hc);
    } on CustomError catch (e) {
      print('🔴 Error al crear historia clínica: ${e.message}');
      state = state.copyWith(
          errorMessage: e.message ?? 'Error al crear historia clínica');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> updateHcGeneral(CreateHcGeneral hc) async {
    print('🟢 Actualizando historia clínica');
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.updateHcGeneral(hc);
    } on CustomError catch (e) {
      print('🔴 Error al actualizar historia clínica: ${e.message}');
      state = state.copyWith(
          errorMessage: e.message ?? 'Error al actualizar historia clínica');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> createHcAdult(CreateHcAdultEntity hc) async {
    print('🟢 Creando historia clínica');
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.createHcAdult(hc);
    } on CustomError catch (e) {
      print('🔴 Error al crear historia clínica: ${e.message}');
      state = state.copyWith(
          errorMessage: e.message ?? 'Error al crear historia clínica');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> updateHcAdult(CreateHcAdultEntity hc) async {
    print('🟢 Actualizando historia clínica');
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.updateHcAdult(hc);
    } on CustomError catch (e) {
      print('🔴 Error al actualizar historia clínica: ${e.message}');
      state = state.copyWith(
          errorMessage: e.message ?? 'Error al actualizar historia clínica');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> updateHcVoice(CreateHcVoice hc) async {
    print('🟢 Actualizando historia clínica de voz');
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.updateHcVoice(hc);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<CreateHcGeneral?> getHcGeneral(String cedula) async {
    print('🟢 Obteniendo historia clínica general');
    state = state.copyWith(loading: true);
    try {
      final hc = await _hcRepository.getHcGeneral(cedula);
      state = state.copyWith(errorMessage: '');
      return hc;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<CreateHcAdultEntity?> getHcAdult(String cedula) async {
    state = state.copyWith(loading: true);
    try {
      final hc = await _hcRepository.getHcAdult(cedula);
      state = state.copyWith(errorMessage: '');
      return hc;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<CreateHcVoice?> getHcVoice(String cedula) async {
    print('🟢 Obteniendo historia clínica');
    state = state.copyWith(loading: true);
    try {
      final hc = await _hcRepository.getHcVoice(cedula);
      state = state.copyWith(errorMessage: '');
      return hc;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: '');
  }

  void clearSuccess() {
    state = state.copyWith(successMessage: '');
  }

  Future<void> createHcVoice(CreateHcVoice hc) async {
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.createHcVoice(hc);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<bool> existHcGeneral(String cedula) async {
    try {
      return await _hcRepository.existHcGeneral(cedula);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message);
      return false;
    }
  }

  Future<bool> existHcAdult(String cedula) async {
    try {
      return await _hcRepository.existHcAdult(cedula);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message);
      return false;
    }
  }

  Future<bool> existHcVoice(String cedula) async {
    try {
      return await _hcRepository.existHcVoice(cedula);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message);
      return false;
    }
  }
}

class HCState {
  final bool loading;
  final String errorMessage;
  final String successMessage;

  const HCState({
    this.successMessage = '',
    this.loading = false,
    this.errorMessage = '',
  });

  HCState copyWith({
    String? successMessage,
    bool? loading,
    String? errorMessage,
  }) {
    return HCState(
      successMessage: successMessage ?? this.successMessage,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
