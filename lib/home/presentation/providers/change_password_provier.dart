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
    final passwordValidations = _validatePassword(value);
    final allRequirementsMet = _areAllRequirementsMet(passwordValidations);

    state = state.copyWith(
      newPassword: newNewPassword,
      isValid: Formz.validate(
              [state.oldPassword, newNewPassword, state.confirmPassword]) &&
          newNewPassword.value == state.confirmPassword.value &&
          allRequirementsMet,
      hasMinLength: passwordValidations['hasMinLength'] ?? false,
      hasUppercase: passwordValidations['hasUppercase'] ?? false,
      hasLowercase: passwordValidations['hasLowercase'] ?? false,
      hasNumber: passwordValidations['hasNumber'] ?? false,
      hasSpecialChar: passwordValidations['hasSpecialChar'] ?? false,
    );
  }

  // 🔹 Validar requisitos de contraseña
  Map<String, bool> _validatePassword(String password) {
    return {
      'hasMinLength': password.length >= 12,
      'hasUppercase': password.contains(RegExp(r'[A-Z]')),
      'hasLowercase': password.contains(RegExp(r'[a-z]')),
      'hasNumber': password.contains(RegExp(r'[0-9]')),
      'hasSpecialChar': password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
    };
  }

  // 🔹 Verificar si todos los requisitos están cumplidos
  bool _areAllRequirementsMet(Map<String, bool> validations) {
    return validations.values.every((isValid) => isValid);
  }

  void onConfirmPasswordChanged(String value) {
    final newConfirmPassword = Password.dirty(value);
    final passwordValidations = _validatePassword(state.newPassword.value);
    final allRequirementsMet = _areAllRequirementsMet(passwordValidations);

    state = state.copyWith(
      confirmPassword: newConfirmPassword,
      isValid: Formz.validate(
              [state.oldPassword, state.newPassword, newConfirmPassword]) &&
          state.newPassword.value == newConfirmPassword.value &&
          allRequirementsMet,
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

    if (!state.isValid) {
      // Verificar si el problema es que no se cumplen todos los requisitos
      final passwordValidations = _validatePassword(state.newPassword.value);
      final allRequirementsMet = _areAllRequirementsMet(passwordValidations);

      if (!allRequirementsMet) {
        state = state.copyWith(
          errorMessage:
              'La nueva contraseña debe cumplir con todos los requisitos de seguridad',
        );
        return;
      }

      if (state.newPassword.value != state.confirmPassword.value) {
        state = state.copyWith(
          errorMessage: 'Las contraseñas no coinciden',
        );
        return;
      }

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

    final passwordValidations = _validatePassword(newPassword.value);
    final allRequirementsMet = _areAllRequirementsMet(passwordValidations);

    state = state.copyWith(
      isFormPosted: true,
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([oldPassword, newPassword, confirmPassword]) &&
          newPassword.value == confirmPassword.value &&
          allRequirementsMet,
    );
  }

  // 🔹 Limpiar todos los campos del formulario
  void clearForm() {
    state = const FormChangePasswordState();
    print('🔹 Formulario de cambio de contraseña limpiado');
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

  // Validaciones de contraseña
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasNumber;
  final bool hasSpecialChar;

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
    this.hasMinLength = false,
    this.hasUppercase = false,
    this.hasLowercase = false,
    this.hasNumber = false,
    this.hasSpecialChar = false,
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
    bool? hasMinLength,
    bool? hasUppercase,
    bool? hasLowercase,
    bool? hasNumber,
    bool? hasSpecialChar,
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
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasLowercase: hasLowercase ?? this.hasLowercase,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
    );
  }
}
