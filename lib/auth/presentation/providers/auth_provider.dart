import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/domain/entities/user_entities.dart';
import 'package:h_c_1/auth/domain/repositories/auth_repository.dart';
import 'package:h_c_1/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:h_c_1/shared/infrastructure/errors/custom_error.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(
    authRepository: authRepository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    try {
      final user = await authRepository.checkAuthStatus();
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  Future<String> sendPhoneVerification(String phoneNumber) async {
    try {
      state = state.copyWith(
        isLoading: true,
        errorMessage: '',
      );

      final verificationId =
          await authRepository.sendPhoneVerification(phoneNumber);
      return verificationId;
    } on CustomError catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.requires2FA,
        errorMessage: e.message,
        isLoading: false,
      );
      throw e;
    }
  }

  Future<void> verifyPhoneCode(String code) async {
    try {
      if (state.verificationId == null) {
        throw CustomError('No hay ID de verificación disponible');
      }

      state = state.copyWith(
        isLoading: true,
        errorMessage: '',
      );

      final isValid = await authRepository.verifyPhoneCode(
        state.verificationId!,
        code,
      );

      if (isValid && state.user != null) {
        // Actualizar el estado completo después de una verificación exitosa
        state = state.copyWith(
          user: state.user,
          authStatus: AuthStatus.authenticated,
          errorMessage: '',
          isLoading: false,
          // Limpiar los campos de verificación
          verificationId: null,
          phoneNumber: null,
        );
        print('Verificación exitosa, estado actualizado a authenticated');
      } else {
        state = state.copyWith(
          authStatus: AuthStatus.requires2FA,
          errorMessage: 'Código de verificación inválido',
          isLoading: false,
        );
      }
    } on CustomError catch (e) {
      print('Error en verificación: ${e.message}');
      state = state.copyWith(
        authStatus: AuthStatus.requires2FA,
        errorMessage: e.message,
        isLoading: false,
      );
    }
  }

  Future<void> changePassword(String password, String newPassword) async {
    try {
      state = state.copyWith(
        isLoading: true,
        errorMessage: '',
      );

      await authRepository.changePassword(
          state.user!.email, password, newPassword);
      state = state.copyWith(
        isLoading: false,
        successMessage: 'Contraseña cambiada con éxito',
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: '');
  }

  void clearSuccess() {
    state = state.copyWith(successMessage: '');
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      if (user.userInformation.phone.isNotEmpty) {
        final verificationId = await sendPhoneVerification(
          user.userInformation.phone,
        );
        state = state.copyWith(
          authStatus: AuthStatus.requires2FA,
          user: user,
          phoneNumber: user.userInformation.phone,
          verificationId: verificationId,
          isLoading: false,
        );
      } else {
        await logout("Error al iniciar sesión");
        state = state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          errorMessage: 'Error al iniciar sesión',
          isLoading: false,
        );
      }
    } on CustomError catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: e.message,
        isLoading: false,
        verificationId: null,
        phoneNumber: null,
        user: null,
      );
    } catch (e) {
      logout('Error no controlado');
    }

    // final user = await authRepository.login(email, password);
    // state =state.copyWith(user: user, authStatus: AuthStatus.authenticated)
  }

  void _setLoggedUser(User user) async {
    print("User: ${user.userInformation.phone}");
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    await authRepository.logout();
    print(errorMessage);
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated, requires2FA }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String? phoneNumber;
  final String? verificationId;
  final String successMessage;
  final String errorMessage;
  final bool isLoading;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.phoneNumber,
      this.verificationId,
      this.errorMessage = '',
      this.successMessage = '',
      this.isLoading = false});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? phoneNumber,
    String? successMessage,
    String? errorMessage,
    String? verificationId,
    bool? isLoading,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          successMessage: successMessage ?? this.successMessage,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          errorMessage: errorMessage ?? this.errorMessage,
          verificationId: verificationId ?? this.verificationId,
          isLoading: isLoading ?? this.isLoading);
}
