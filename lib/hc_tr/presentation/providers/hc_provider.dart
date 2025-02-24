import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/infrastructure/errors/auth_errors.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';
import 'package:h_c_1/hc_tr/domain/repositories/hc_repository.dart';
import 'package:h_c_1/hc_tr/infrastructure/repositories/hc_repository_impl.dart';

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

  Future<CreateHcGeneral?> getHcGeneral(String cedula) async {
    print('🟢 Obteniendo historia clínica');
    state = state.copyWith(loading: true);
    try {
      final hc = await _hcRepository.getHcGeneral(cedula);
      print("aQUI SI LLEGA");
      state = state.copyWith(errorMessage: '');
      return hc;
    } on CustomError catch (e) {
      print('🔴 Error al obtener historia clínica: ${e.message}');
      state = state.copyWith(
          errorMessage: e.message ?? 'Error al obtener historia clínica');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<CreateHcAdultEntity?> getHcAdult(String cedula) async {
    print('🟢 Obteniendo historia clínica');
    state = state.copyWith(loading: true);
    try {
      final hc = await _hcRepository.getHcAdult(cedula);
      print("aQUI SI LLEGA");
      state = state.copyWith(errorMessage: '');
      return hc;
    } catch (e) {
      print('🔴 Error al obtener historia clínica: ${e.toString()}');
      state = state.copyWith(
          errorMessage: e.toString() ?? 'Error al obtener historia clínica');
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
      print('🔴 Error al obtener historia clínica: ${e.toString()}');
      state = state.copyWith(
          errorMessage: e.toString() ?? 'Error al obtener historia clínica');
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> createHcVoice(CreateHcVoice hc) async {
    print('🟢 Creando historia clínica');
    state = state.copyWith(loading: true);
    try {
      await _hcRepository.createHcVoice(hc);
    } on CustomError catch (e) {
      print('🔴 Error al crear historia clínica: ${e.message}');
      state = state.copyWith(
          errorMessage: e.message ?? 'Error al crear historia clínica');
    } finally {
      state = state.copyWith(loading: false);
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
