import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:h_c_1/auth/domain/repositories/auth_repository.dart';
import 'package:h_c_1/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:h_c_1/config/routes/app_routes.dart';
import 'package:h_c_1/shared/infrastructure/errors/custom_error.dart';
import 'package:h_c_1/shared/infrastructure/inputs/inputs.dart';

// Estado del formulario de recuperación de contraseña
class PasswordResetState {
  final Email email;
  final bool isSubmitting;
  final bool isFormPosted;
  final bool isValid;
  final String errorMessage;

  const PasswordResetState({
    this.email = const Email.pure(),
    this.isSubmitting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.errorMessage = '',
  });

  PasswordResetState copyWith({
    Email? email,
    Name? code,
    Password? newPassword,
    bool? isSubmitting,
    bool? isFormPosted,
    bool? isValid,
    String? errorMessage,
  }) {
    return PasswordResetState(
      email: email ?? this.email,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class PasswordResetNotifier extends StateNotifier<PasswordResetState> {
  final AuthRepository authRepository;
  final Ref ref;
  PasswordResetNotifier({
    required this.ref,
    required this.authRepository,
  }) : super(const PasswordResetState());

  // Validar email
  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail]),
    );
  }

  // Enviar código de verificación
  Future<void> sendCode(BuildContext context) async {
    print("Sending code to: ${state.email.value}");
    _touchFieldEmail();
    if (!state.isValid) return;

    try {
      state = state.copyWith(isSubmitting: true);
      print("Sending code to: ${state.email.value}");
      await authRepository.sendCode(state.email.value);

      // Simulamos éxito en el envío del código
      state = state.copyWith(isSubmitting: false, errorMessage: '');

      // Mostrar un mensaje de éxito si el código se envió correctamente
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Código enviado exitosamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Regresar a la pantalla anterior después de mostrar el mensaje
      ref.read(goRouterProvider).pop();
    } on CustomError catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(
          isSubmitting: false,
          errorMessage:
              'No existe una cuenta asociada a este correo electrónico.');
    }
  }

  // Marcar los campos como modificados
  void _touchFieldEmail() {
    final email = Email.dirty(state.email.value);
    print("Email: ${email.value}");
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      isValid: Formz.validate([email]),
    );
  }
}

final passwordResetProvider = StateNotifierProvider.autoDispose<
    PasswordResetNotifier, PasswordResetState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return PasswordResetNotifier(authRepository: authRepository, ref: ref);
});
