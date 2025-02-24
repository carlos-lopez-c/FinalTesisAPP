import 'package:h_c_1/auth/domain/entities/role_entities.dart';
import 'package:h_c_1/auth/domain/entities/user_entities.dart';
import 'package:h_c_1/auth/domain/entities/user_information_entities.dart';
import 'package:h_c_1/auth/domain/entities/user_role_entities.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
      username: json['username'] ?? '',
      isActive: json['isActive'] ?? false,
      userInformation: UserInformationEntity(
        firstName: json['userInformation']?['firstName'] ?? '',
        lastName: json['userInformation']?['lastName'] ?? '',
        address: json['userInformation']?['address'] ?? '',
        phone: json['userInformation']?['phone'] ?? '',
        id: json['userInformation']?['id'] ?? '',
      ),
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      medicID: json['medicID'] ?? '',
      role: json['role'] ?? '');
}
