import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/hc_ps/domain/entities/hc_ps_adult/create_hc_adult.dart';
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

  Future<void> createHcPsAdult(CreateHcPsAdult hc) async {
    print('🟢 Creando historia clínica');
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.createHcPsAdult(hc);
    } on CustomError catch (e) {
      print('🔴 Error al crear historia clínica: ${e.message}');
      state = state.copyWith(errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> updateHcPsAdult(CreateHcPsAdult hc) async {
    print('🟢 Actualizando historia clínica');
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.updateHcPsAdult(hc);
    } on CustomError catch (e) {
      print('🔴 Error al actualizar historia clínica: ${e.message}');
      state = state.copyWith(errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<CreateHcPsAdult?> getHcPsAdult(String cedula) async {
    print('🟢 Obteniendo historia clínica');
    state = state.copyWith(loading: true);
    try {
      final hc = await _hcRepository.getHcPsAdult(cedula);
      print("aQUI SI LLEGA");
      state = state.copyWith(errorMessage: '');
      return hc;
    } on CustomError catch (e) {
      print('🔴 Error al obtener historia clínica: ${e.message}');
      state = state.copyWith(errorMessage: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<bool> existHcPsAdult(String cedula) async {
    try {
      final exists = await _hcRepository.existHcPsAdult(cedula);
      return exists;
    } on CustomError catch (e) {
      print('🔴 Error al verificar existencia: ${e.message}');
      state = state.copyWith(errorMessage: e.message);
      return false;
    }
  }
}

class HCState {
  final bool loading;
  final String errorMessage;

  const HCState({
    this.loading = false,
    this.errorMessage = '',
  });

  HCState copyWith({
    bool? loading,
    String? errorMessage,
  }) {
    return HCState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
