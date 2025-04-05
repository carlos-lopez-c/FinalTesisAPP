import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/domain/entities/user_entities.dart';
import 'package:h_c_1/auth/domain/repositories/auth_repository.dart';
import 'package:h_c_1/auth/infrastructure/errors/auth_errors.dart';
import 'package:h_c_1/auth/infrastructure/repositories/auth_repository_impl.dart';

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

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      if (user.userInformation.phone.isEmpty) {
        final verificationId = await authRepository.sendPhoneVerification(
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
        logout("Error al iniciar sesión");
      }
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }

    // final user = await authRepository.login(email, password);
    // state =state.copyWith(user: user, authStatus: AuthStatus.authenticated)
  }

  void _setLoggedUser(User user) async {
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
  final String errorMessage;
  final bool isLoading;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.phoneNumber,
      this.verificationId,
      this.errorMessage = '',
      this.isLoading = false});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? phoneNumber,
    String? errorMessage,
    String? verificationId,
    bool? isLoading,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          errorMessage: errorMessage ?? this.errorMessage,
          verificationId: verificationId ?? this.verificationId,
          isLoading: isLoading ?? this.isLoading);
}
