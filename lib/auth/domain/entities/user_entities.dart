import 'package:h_c_1/auth/domain/entities/user_information_entities.dart';
import 'package:h_c_1/auth/domain/entities/user_role_entities.dart';

class User {
  String id;
  String email;
  String username;
  bool isActive;
  UserInformation userInformation;
  List<UserRole> userRoles;
  String token;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.isActive,
    required this.userInformation,
    required this.userRoles,
    required this.token,
  });
}
