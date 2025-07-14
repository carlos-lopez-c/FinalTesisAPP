import 'package:h_c_1/auth/domain/datasources/auth_datasource.dart';
import 'package:h_c_1/auth/domain/entities/user_entities.dart';
import 'package:h_c_1/auth/domain/repositories/auth_repository.dart';
import 'package:h_c_1/auth/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({AuthDatasource? authDatasource})
      : authDatasource = authDatasource ?? AuthDatasourceImpl();

  @override
  Future<User> login(String email, String password) {
    return authDatasource.login(email, password);
  }

  @override
  Future<User> checkAuthStatus() {
    return authDatasource.checkAuthStatus();
  }

  @override
  Future<void> sendCode(String email) {
    return authDatasource.sendCode(email);
  }

  @override
  Future<void> validateCode(String email, String code) {
    return authDatasource.validateCode(email, code);
  }

  @override
  Future<void> resetPassword(String email, String token, String newPassword) {
    return authDatasource.resetPassword(email, token, newPassword);
  }

  @override
  Future<void> logout() {
    return authDatasource.logout();
  }

  @override
  Future<String> sendPhoneVerification(String phoneNumber) {
    return authDatasource.sendPhoneVerification(phoneNumber);
  }

  @override
  Future<bool> verifyPhoneCode(String verificationId, String code) {
    return authDatasource.verifyPhoneCode(verificationId, code);
  }

  @override
  Future<String> resendPhoneCode(String phoneNumber) {
    return authDatasource.resendPhoneCode(phoneNumber);
  }

  @override
  Future<void> changePassword(
      String email, String oldPassword, String newPassword) {
    return authDatasource.changePassword(email, oldPassword, newPassword);
  }
}
