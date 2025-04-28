import 'package:h_c_1/auth/domain/entities/user_entities.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);
  Future<User> checkAuthStatus();
  Future<void> logout();
  Future<void> sendCode(String email);
  // 2FA methods
  Future<String> sendPhoneVerification(String phoneNumber);
  Future<bool> verifyPhoneCode(String verificationId, String code);
  Future<String> resendPhoneCode(String phoneNumber);

  Future<void> changePassword(
      String email, String oldPassword, String newPassword);
  //validate code
  Future<void> validateCode(String email, String code);
  Future<void> resetPassword(String email, String token, String newPassword);
}
