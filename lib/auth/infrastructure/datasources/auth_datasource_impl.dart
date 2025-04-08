import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/services.dart';
import 'package:h_c_1/auth/domain/datasources/auth_datasource.dart';
import 'package:h_c_1/auth/domain/entities/user_entities.dart';
import 'package:h_c_1/shared/infrastructure/errors/custom_error.dart';
import 'package:h_c_1/shared/infrastructure/errors/handle_error.dart';
import 'package:h_c_1/auth/domain/entities/user_information_entities.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _formatPhoneNumber(String phoneNumber) {
    // Eliminar todos los caracteres no numéricos
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Si el número no comienza con el código de país, agregarlo
    if (!cleanedNumber.startsWith('593')) {
      cleanedNumber = '593$cleanedNumber';
    }

    // Agregar el prefijo '+' requerido por E.164
    return '+$cleanedNumber';
  }

  @override
  Future<User> checkAuthStatus() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw CustomError('No hay usuario autenticado.');
      }

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        throw CustomError('Usuario no encontrado en la base de datos.');
      }

      final userData = userDoc.data()!;
      final userInformationDoc = await _firestore
          .collection('userInformation')
          .doc(userData['userInformationId'])
          .get();

      if (!userInformationDoc.exists) {
        throw CustomError('Información del usuario no encontrada.');
      }

      final userInformationData = userInformationDoc.data()!;
      final userInformation = UserInformationEntity(
        id: userInformationDoc.id,
        firstName: userInformationData['firstname'],
        lastName: userInformationData['lastname'],
        address: userInformationData['address'],
        phone: userInformationData['phone'],
      );

      return User(
        id: user.uid,
        email: user.email!,
        username: userData['username'],
        isActive: userData['isActive'],
        userInformation: userInformation,
        role: userData['role'],
        medicID: userData['medicID'],
      );
    } catch (e) {
      throw CustomError('Error al verificar el estado de autenticación: $e');
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw FirebaseException(
          plugin: 'auth',
          code: 'user-null',
          message: 'Error al obtener el usuario.',
        );
      }

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'user-not-found',
            message: 'Usuario no encontrado en la base de datos.');
      }

      final userData = userDoc.data()!;
      if (userData['role'] != 'Therapy' && userData['role'] != 'Psicology') {
        throw FirebaseException(
            plugin: 'auth',
            code: 'user-not-authorized',
            message: 'Esta cuenta de Medico no tiene acceso a esta app.');
      }
      final userInformationDoc = await _firestore
          .collection('userInformation')
          .doc(userData['userInformationId'])
          .get();
      if (!userInformationDoc.exists) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'user-not-found',
            message: 'Usuario no encontrado en la base de datos.');
      }

      final userInformationData = userInformationDoc.data()!;
      final userInformation = UserInformationEntity(
        id: userInformationDoc.id,
        firstName: userInformationData['firstname'],
        lastName: userInformationData['lastname'],
        address: userInformationData['address'],
        phone: userInformationData['phone'],
      );
      return User(
        id: user.uid,
        email: user.email!,
        username: userData['username'],
        isActive: userData['isActive'],
        userInformation: userInformation,
        role: userData['role'],
        medicID: userData['medicID'],
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      print("Error: ${e}");
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<String> sendPhoneVerification(String phoneNumber) async {
    try {
      print("Phone Number: $phoneNumber");
      final formattedPhoneNumber = _formatPhoneNumber(phoneNumber);
      print('Enviando verificación a: $formattedPhoneNumber');

      final completer = Completer<String>();

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: formattedPhoneNumber,
        verificationCompleted:
            (firebase_auth.PhoneAuthCredential credential) async {
          try {
            await _firebaseAuth.signInWithCredential(credential);
            if (!completer.isCompleted) completer.complete('');
          } catch (e) {
            if (!completer.isCompleted) completer.completeError(e);
          }
        },
        verificationFailed: (firebase_auth.FirebaseAuthException e) {
          print('Error de verificación: ${e.message}');
          if (!completer.isCompleted) {
            final customError =
                FirebaseErrorHandler.handleFirebaseAuthException(e);
            completer.completeError(customError);
          }
        },
        codeSent: (String id, int? resendToken) {
          print('Código enviado. ID: $id');
          if (!completer.isCompleted) completer.complete(id);
        },
        codeAutoRetrievalTimeout: (String id) {
          print('Timeout de recuperación automática. ID: $id');
        },
      );

      final verificationId = await completer.future;
      if (verificationId.isEmpty) {
        throw FirebaseException(
          plugin: 'auth',
          code: 'verification-failed',
          message: 'No se pudo obtener el ID de verificación',
        );
      }

      return verificationId;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Error en sendPhoneVerification: $e');
      throw FirebaseErrorHandler.handleFirebaseAuthException(e);
    } catch (e) {
      print('Error en sendPhoneVerification: $e');
      if (e is CustomError) throw e;
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<bool> verifyPhoneCode(String verificationId, String code) async {
    try {
      print("Verification ID: $verificationId");
      print("Code: $code");
      final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      print("Credential: ${credential}");

      await _firebaseAuth.signInWithCredential(credential);
      print("Sign In With Credential: ${_firebaseAuth.currentUser}");
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print("Error: ${e}");
      throw FirebaseErrorHandler.handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      print("Error: ${e}");
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      print("Error: ${e}");
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<String> resendPhoneCode(String phoneNumber) async {
    try {
      return await sendPhoneVerification(phoneNumber);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<void> sendCode(String email) async {
    try {
      print("Verificando email: $email");

      // Realizar la consulta con limit(1) y usando el parámetro correcto
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw FirebaseException(
          plugin: 'firestore',
          code: 'user-not-found',
          message: 'No existe una cuenta asociada a este correo electrónico.',
        );
      }

      // Si el correo existe, enviar el email de reset
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      throw FirebaseErrorHandler.handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      print("Firestore Error: ${e.message}");
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } catch (e) {
      print("Error general: $e");
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<void> validateCode(String email, String code) async {
    // Firebase no proporciona una forma directa de validar un código de restablecimiento de contraseña.
    // Generalmente, el usuario sigue el enlace proporcionado en el correo electrónico para restablecer la contraseña.
    throw UnimplementedError('La validación de código no está implementada.');
  }

  @override
  Future<void> resetPassword(
      String email, String token, String newPassword) async {
    try {
      await _firebaseAuth.confirmPasswordReset(
          code: token, newPassword: newPassword);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw CustomError(e.message ?? 'Error al restablecer la contraseña.');
    } catch (e) {
      throw CustomError('Error desconocido: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      // Si utilizas proveedores de autenticación como Google, Facebook, etc.,
      // asegúrate de cerrar sesión en ellos también.
      // Por ejemplo, para Google:
      // await GoogleSignIn().signOut();
    } catch (e) {
      throw CustomError('Error al cerrar sesión: $e');
    }
  }
}
