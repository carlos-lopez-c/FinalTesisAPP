import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';

final twoFactorProvider =
    StateNotifierProvider.autoDispose<TwoFactorNotifier, TwoFactorState>((ref) {
  final verifyCodeCallback = ref.watch(authProvider.notifier).verifyPhoneCode;
  return TwoFactorNotifier(verifyCodeCallback: verifyCodeCallback);
});

class TwoFactorNotifier extends StateNotifier<TwoFactorState> {
  final Function(String) verifyCodeCallback;
  TwoFactorNotifier({required this.verifyCodeCallback})
      : super(const TwoFactorState());

  void onCodeChanged(String value) {
    state = state.copyWith(
      code: value,
      isValid: value.length == 6,
    );
  }

  Future<void> verifyCode() async {
    if (!state.isValid) return;

    state = state.copyWith(isLoading: true);

    try {
      await verifyCodeCallback(state.code);

      // Si la verificación es exitosa, navegamos al home
      state = state.copyWith(
        isLoading: false,
        isVerified: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Código inválido. Por favor, intente nuevamente.',
      );
    }
  }

  void resendCode() {
    state = state.copyWith(
      canResend: false,
      resendCountdown: 60,
    );

    // Iniciar el contador
    _startResendCountdown();
  }

  void _startResendCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (state.resendCountdown > 0) {
        state = state.copyWith(
          resendCountdown: state.resendCountdown - 1,
        );
        _startResendCountdown();
      } else {
        state = state.copyWith(
          canResend: true,
          resendCountdown: 60,
        );
      }
    });
  }
}

class TwoFactorState {
  final String phoneNumber;
  final String code;
  final bool isValid;
  final bool isLoading;
  final bool isVerified;
  final bool canResend;
  final int resendCountdown;
  final String? errorMessage;

  const TwoFactorState({
    this.phoneNumber = '+593 99 999 9999', // Número de ejemplo
    this.code = '',
    this.isValid = false,
    this.isLoading = false,
    this.isVerified = false,
    this.canResend = true,
    this.resendCountdown = 60,
    this.errorMessage,
  });

  TwoFactorState copyWith({
    String? phoneNumber,
    String? code,
    bool? isValid,
    bool? isLoading,
    bool? isVerified,
    bool? canResend,
    int? resendCountdown,
    String? errorMessage,
  }) {
    return TwoFactorState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      code: code ?? this.code,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      isVerified: isVerified ?? this.isVerified,
      canResend: canResend ?? this.canResend,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
