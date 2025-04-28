import 'package:formz/formz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/shared/infrastructure/inputs/inputs.dart';

final formChangePasswordProvider = StateNotifierProvider.autoDispose<
    FormChangePasswordNotifier, FormChangePasswordState>((ref) {
  final changePasswordCallback =
      ref.watch(authProvider.notifier).changePassword;
  return FormChangePasswordNotifier(
      changePasswordCallback: changePasswordCallback);
});

class FormChangePasswordNotifier
    extends StateNotifier<FormChangePasswordState> {
  final Function(String, String) changePasswordCallback;
  FormChangePasswordNotifier({required this.changePasswordCallback})
      : super(const FormChangePasswordState());

  void onOldPasswordChanged(String value) {
    final newOldPassword = Password.dirty(value);
    state = state.copyWith(
      oldPassword: newOldPassword,
      isValid: Formz.validate([newOldPassword, state.newPassword]),
    );
  }

  void onNewPasswordChanged(String value) {
    final newNewPassword = Password.dirty(value);
    state = state.copyWith(
      newPassword: newNewPassword,
      isValid: Formz.validate([state.oldPassword, newNewPassword]),
    );
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true, errorMessage: null);

    try {
      // Intento de cambio de contraseña
      await changePasswordCallback(
          state.oldPassword.value, state.newPassword.value);
    } catch (e) {
      // Manejo del error de cambio de contraseña
      state = state.copyWith(
        isPosting: false,
        errorMessage: 'Error al cambiar la contraseña.',
      );
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  void _touchEveryField() {
    final oldPassword = Password.dirty(state.oldPassword.value);
    final newPassword = Password.dirty(state.newPassword.value);

    state = state.copyWith(
      isFormPosted: true,
      oldPassword: oldPassword,
      newPassword: newPassword,
      isValid: Formz.validate([oldPassword, newPassword]),
    );
  }
}

class FormChangePasswordState {
  final Password oldPassword;
  final Password newPassword;
  final bool isPosting;
  final String? errorMessage;
  final bool isFormPosted;
  final bool isValid;

  const FormChangePasswordState({
    this.oldPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.isPosting = false,
    this.errorMessage,
    this.isFormPosted = false,
    this.isValid = false,
  });

  FormChangePasswordState copyWith({
    Password? oldPassword,
    Password? newPassword,
    bool? isPosting,
    String? errorMessage,
    bool? isFormPosted,
    bool? isValid,
  }) {
    return FormChangePasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      isPosting: isPosting ?? this.isPosting,
      errorMessage: errorMessage ?? this.errorMessage,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
    );
  }
}
