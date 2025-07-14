import 'package:formz/formz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/shared/infrastructure/inputs/email_input.dart';
import 'package:h_c_1/shared/infrastructure/inputs/inputs.dart';

final formularioProvider =
    StateNotifierProvider.autoDispose<FormularioNotifier, FormularioState>(
        (ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  return FormularioNotifier(loginUserCallback: loginUserCallback);
});

class FormularioNotifier extends StateNotifier<FormularioState> {
  final Function(String, String) loginUserCallback;
  FormularioNotifier({required this.loginUserCallback})
      : super(const FormularioState());

  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  void onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([state.email, newPassword]),
    );
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true, errorMessage: null);

    try {
      // Intento de autenticación
      await loginUserCallback(state.email.value, state.password.value);
    } catch (e) {
      // Manejo del error de autenticación
      state = state.copyWith(
        isPosting: false,
        errorMessage: 'Revise la contraseña e intente nuevamente.',
      );
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
    );
  }
}

class FormularioState {
  final Email email;
  final Password password;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String? errorMessage;

  const FormularioState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.errorMessage,
  });

  FormularioState copyWith({
    Email? email,
    Password? password,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? errorMessage,
  }) {
    return FormularioState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
