import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:h_c_1/auth/domain/datasources/auth_datasource.dart';
import 'package:h_c_1/auth/domain/entities/role_entities.dart';
import 'package:h_c_1/auth/domain/entities/user_entities.dart';
import 'package:h_c_1/auth/infrastructure/errors/auth_errors.dart';
import 'package:h_c_1/auth/domain/entities/user_information_entities.dart';
import 'package:h_c_1/auth/domain/entities/user_role_entities.dart';
import 'package:h_c_1/config/firebase/firebase_options.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase inicializado correctamente');
  }

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final firebase_auth.User? firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        print('⚠️ Usuario no autenticado');
        throw CustomError('Usuario no autenticado');
      }
      return await _firebaseUserToEntity(firebaseUser, token);
    } catch (e) {
      print('⚠️ Error al verificar autenticación: $e');
      throw CustomError('Error al verificar autenticación');
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final firebase_auth.User? firebaseUser = credential.user;
      if (firebaseUser == null) {
        print('⚠️ Error de autenticación: usuario nulo');
        throw CustomError('Error de autenticación');
      }
      return await _firebaseUserToEntity(firebaseUser, 'exampleToken');
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('⚠️ Error de autenticación: ${e.message}');
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw CustomError('Credenciales incorrectas');
      }
      throw CustomError('Error de autenticación');
    }
  }

  @override
  Future<void> resetPassword(String email, String token, String newPassword) async {
    try {
      await _firebaseAuth.confirmPasswordReset(code: token, newPassword: newPassword);
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('⚠️ Error al cambiar la contraseña: ${e.message}');
      throw CustomError('Error al cambiar la contraseña: ${e.message}');
    }
  }

  @override
  Future<void> sendCode(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('⚠️ Error al enviar código de recuperación: ${e.message}');
      throw CustomError('Error al enviar código de recuperación: ${e.message}');
    }
  }

  @override
  Future<void> validateCode(String email, String code) async {
    try {
      await _firebaseAuth.verifyPasswordResetCode(code);
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('⚠️ Código inválido: ${e.message}');
      throw CustomError('Código inválido: ${e.message}');
    }
  }

  Future<User> _firebaseUserToEntity(firebase_auth.User firebaseUser, String token) async {
  try {
    // Imprimir el UID del usuario para verificar
    print('✅ UID del usuario autenticado: ${firebaseUser.uid}');
    
    // Obtener el correo del usuario autenticado
    String userEmail = firebaseUser.email ?? '';
    
    if (userEmail.isEmpty) {
      print('⚠️ El correo del usuario está vacío');
      throw CustomError('Correo del usuario no encontrado');
    }

    // Buscar en Firestore por correo electrónico
    final querySnapshot = await _firestore.collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    // Comprobar si encontramos algún documento
    if (querySnapshot.docs.isEmpty) {
      print('⚠️ No se encontró un usuario con este correo en Firestore');
      throw CustomError('Usuario no encontrado en Firestore');
    }

    // Obtener el primer documento encontrado
    final docSnapshot = querySnapshot.docs.first;

    // Verificar los datos obtenidos de Firestore
    final data = docSnapshot.data();

    // Imprimir los datos del usuario obtenidos de Firestore
    print('✅ Datos obtenidos de Firestore: $data');

    // Verificar si el rol es "Terapia" o "Psicologia"
    String role = data['rol'] ?? '';
    if (role != 'TERAPIA' && role != 'PSICOLOGIA') {
      print('⚠️ Rol no permitido: $role');
      throw CustomError('Rol no permitido. Redirigiendo al login.');
    }

    // Crear el objeto User con los datos obtenidos
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      username: firebaseUser.displayName ?? '',
      isActive: data['isActive'] ?? true,
      userInformation: UserInformation(
        id: firebaseUser.uid,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        phone: data['phone'] ?? '',
        address: data['address'] ?? '',
      ),
      userRoles: [
        UserRole(role: Role(name: role)),
      ],
      token: token,
      medicID: data['medicID'] ?? '',
    );
  } catch (e) {
    print('⚠️ Error al obtener datos del usuario: $e');
    throw CustomError('Error al obtener datos del usuario');
  }
}
}