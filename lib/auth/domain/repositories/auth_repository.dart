import 'package:h_c_1/auth/domain/entities/user_entities.dart';
import 'package:h_c_1/citas_medicTR/domain/entities/cita.entity.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> checkAuthStatus();
  Future<void> logout();
  Future<void> sendCode(String email);
  //validate code
  Future<void> validateCode(String email, String code);
  Future<void> resetPassword(String email, String token, String newPassword);
}
