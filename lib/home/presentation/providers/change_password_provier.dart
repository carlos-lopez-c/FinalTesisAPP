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
      isValid: Formz.validate(
              [newOldPassword, state.newPassword, state.confirmPassword]) &&
          state.newPassword.value == state.confirmPassword.value,
    );
  }

  void onNewPasswordChanged(String value) {
    final newNewPassword = Password.dirty(value);
    state = state.copyWith(
      newPassword: newNewPassword,
      isValid: Formz.validate(
              [state.oldPassword, newNewPassword, state.confirmPassword]) &&
          newNewPassword.value == state.confirmPassword.value,
    );
  }

  void onConfirmPasswordChanged(String value) {
    final newConfirmPassword = Password.dirty(value);
    state = state.copyWith(
      confirmPassword: newConfirmPassword,
      isValid: Formz.validate(
              [state.oldPassword, state.newPassword, newConfirmPassword]) &&
          state.newPassword.value == newConfirmPassword.value,
    );
  }

  void onOldPasswordVisibilityChanged() {
    print('Old password visibility changed');

    state = state.copyWith(
      oldPasswordVisible: !state.oldPasswordVisible,
    );
  }

  void onNewPasswordVisibilityChanged() {
    state = state.copyWith(
      newPasswordVisible: !state.newPasswordVisible,
    );
  }

  void onConfirmPasswordVisibilityChanged() {
    state = state.copyWith(
      confirmPasswordVisible: !state.confirmPasswordVisible,
    );
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    if (state.newPassword.value != state.confirmPassword.value) {
      print('Passwords do not match');
      state = state.copyWith(
        errorMessage: 'Las contraseñas no coinciden',
      );
      return;
    }

    state = state.copyWith(isPosting: true, errorMessage: null);

    try {
      await changePasswordCallback(
          state.oldPassword.value, state.newPassword.value);
    } catch (e) {
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
    final confirmPassword = Password.dirty(state.confirmPassword.value);

    print("Old Password: ${oldPassword.value}");
    print("New Password: ${newPassword.value}");
    print("Confirm Password: ${confirmPassword.value}");

    // Validar que las contraseñas coincidan
    if (newPassword.value != confirmPassword.value) {
      state = state.copyWith(
        isFormPosted: true,
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        isValid: false,
        errorMessage: 'Las contraseñas no coinciden',
      );
      return;
    }

    state = state.copyWith(
      isFormPosted: true,
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([oldPassword, newPassword, confirmPassword]),
    );
  }
}

class FormChangePasswordState {
  final Password oldPassword;
  final Password newPassword;
  final Password confirmPassword;
  final bool oldPasswordVisible;
  final bool newPasswordVisible;
  final bool confirmPasswordVisible;
  final bool isPosting;
  final String? errorMessage;
  final bool isFormPosted;
  final bool isValid;

  const FormChangePasswordState({
    this.oldPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.oldPasswordVisible = false,
    this.newPasswordVisible = false,
    this.confirmPasswordVisible = false,
    this.isPosting = false,
    this.errorMessage,
    this.isFormPosted = false,
    this.isValid = false,
  });

  FormChangePasswordState copyWith({
    Password? oldPassword,
    Password? newPassword,
    Password? confirmPassword,
    bool? oldPasswordVisible,
    bool? newPasswordVisible,
    bool? confirmPasswordVisible,
    bool? isPosting,
    String? errorMessage,
    bool? isFormPosted,
    bool? isValid,
  }) {
    return FormChangePasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      oldPasswordVisible: oldPasswordVisible ?? this.oldPasswordVisible,
      newPasswordVisible: newPasswordVisible ?? this.newPasswordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
      isPosting: isPosting ?? this.isPosting,
      errorMessage: errorMessage ?? this.errorMessage,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
    );
  }
}
