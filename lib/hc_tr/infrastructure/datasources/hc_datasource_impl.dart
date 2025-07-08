import 'package:cloud_firestore/cloud_firestore.dart'; // Importamos el paquete Firestore
import 'package:flutter/services.dart';
import 'package:h_c_1/hc_ps/domain/entities/hc_ps_adult/create_hc_adult.dart';
import 'package:h_c_1/hc_tr/domain/datasources/hc_datasource.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';
import 'package:h_c_1/shared/infrastructure/errors/custom_error.dart';
import 'package:h_c_1/shared/infrastructure/errors/handle_error.dart';

class HcDatasourceImpl implements HcDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Obtiene el token de Firebase
  @override
  Future<void> createHcGeneral(CreateHcGeneral hc) async {
    try {
      // Guardar en Firestore en la colección "HcTrGeneral"
      await firestore.collection('HcTrGeneral').add(hc.toJson());

      print("Historia clínica general guardada en Firestore");
    } catch (e) {
      print('Error al crear la historia clínica general: $e');
      throw CustomError('Error al crear la historia clínica general');
    }
  }

  @override
  Future<void> createHcAdult(CreateHcAdultEntity hc) async {
    try {
      // Guardar en Firestore en la colección "HcTrAdult"
      await firestore.collection('HcTrAdult').add(hc.toJson());

      print("Historia clínica adulta guardada en Firestore");
    } catch (e) {
      print('Error al crear la historia clínica adulta: $e');
      throw CustomError('Error al crear la historia clínica adulta');
    }
  }

  @override
  Future<void> createHcVoice(CreateHcVoice hc) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Guardar en Firestore en la colección "HcTrVoice"
      await firestore.collection('HcTrVoice').add(hc.toJson());

      print("Historia clínica de voz guardada en Firestore");
    } catch (e) {
      print('Error al crear la historia clínica de voz: $e');
      throw CustomError('Error al crear la historia clínica de voz');
    }
  }

  @override
  Future<bool> existHcGeneral(String cedula) async {
    try {
      // 1. Buscar al paciente por su DNI
      final pacientesSnapshot = await firestore
          .collection('patients') // Colección de pacientes
          .where('dni', isEqualTo: cedula) // Filtra por DNI
          .limit(1) // Limita a 1 resultado (asumimos que el DNI es único)
          .get();

      if (pacientesSnapshot.docs.isEmpty) {
        return false; // No se encontró el paciente
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcTrGeneral') // Colección de historias clínicas
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      return hcSnapshot.docs.isNotEmpty; // Retorna true si se encontró la HC
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<CreateHcGeneral> getHcGeneral(String cedula) async {
    try {
      // 1. Buscar al paciente por su DNI
      final pacientesSnapshot = await firestore
          .collection('patients') // Colección de pacientes
          .where('dni', isEqualTo: cedula) // Filtra por DNI
          .limit(1) // Limita a 1 resultado (asumimos que el DNI es único)
          .get();

      if (pacientesSnapshot.docs.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'hc-not-found',
            message: 'No se encontró una historia clínica para este paciente');
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcTrGeneral') // Colección de historias clínicas
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      if (hcSnapshot.docs.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'hc-not-found',
            message: 'No se encontró una historia clínica para este paciente');
      }

      // Obtener los datos de la historia clínica
      final hcData = hcSnapshot.docs.first.data();

      // Agregar el ID del documento a los datos de la historia clínica
      hcData['id'] = hcSnapshot.docs.first.id; // Obtener el ID del documento
      // Convertir los datos a un objeto CreateHcGeneral
      return CreateHcGeneral.fromJson(hcData);
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<void> createHcPsAdult(CreateHcPsAdult hc) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Guardar en Firestore en la colección "HcTrVoice"
      await firestore.collection('HcPsAdult').add(hc.toJson());

      print("Historia clínica de voz guardada en Firestore");
    } catch (e) {
      print('Error al crear la historia clínica de voz: $e');
      throw CustomError('Error al crear la historia clínica de voz');
    }
  }

  @override
  Future<CreateHcPsAdult> getHcPsAdult(String cedula) async {
    try {
      // 1. Buscar al paciente por su DNI
      final pacientesSnapshot = await firestore
          .collection('patients') // Colección de pacientes
          .where('dni', isEqualTo: cedula) // Filtra por DNI
          .limit(1) // Limita a 1 resultado (asumimos que el DNI es único)
          .get();

      if (pacientesSnapshot.docs.isEmpty) {
        throw CustomError(
            'No se encontró un paciente con el DNI proporcionado');
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcPsAdult') // Colección de historias clínicas
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      if (hcSnapshot.docs.isEmpty) {
        throw CustomError(
            'No se encontró una historia clínica para este paciente');
      }

      // Obtener los datos de la historia clínica
      final hcData = hcSnapshot.docs.first.data();
      final hcId = hcSnapshot.docs.first.id; // Obtener el ID del documento

      print("Datos: $hcData");
      print("ID del documento: $hcId");

      // Convertir los datos a un objeto CreateHcPsAdult y asignar el ID
      return CreateHcPsAdult.fromJson(hcData)..id = hcId;
    } catch (e) {
      print('Error al obtener la historia clínica: $e');
      throw CustomError('Error al obtener la historia clínica');
    }
  }

  @override
  Future<CreateHcAdultEntity> getHcAdult(String cedula) async {
    try {
      // 1. Buscar al paciente por su DNI
      final pacientesSnapshot = await firestore
          .collection('patients') // Colección de pacientes
          .where('dni', isEqualTo: cedula) // Filtra por DNI
          .limit(1) // Limita a 1 resultado (asumimos que el DNI es único)
          .get();

      if (pacientesSnapshot.docs.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'patient-not-found',
            message: 'No se encontró un paciente con el DNI proporcionado');
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcTrAdult') // Colección de historias clínicas
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      if (hcSnapshot.docs.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'hc-not-found',
            message: 'No se encontró una historia clínica para este paciente');
      }

      // Obtener los datos de la historia clínica
      final hcData = hcSnapshot.docs.first.data();
      final hcId = hcSnapshot.docs.first.id; // Obtener el ID del documento

      // Agregar el ID del documento a los datos de la historia clínica
      hcData['id'] = hcId;

      // Convertir los datos a un objeto CreateHcAdultEntity
      return CreateHcAdultEntity.fromJson(hcData, id: hcId);
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<CreateHcVoice> getHcVoice(String cedula) async {
    try {
      // 1. Buscar al paciente por su DNI
      final pacientesSnapshot = await firestore
          .collection('patients') // Colección de pacientes
          .where('dni', isEqualTo: cedula) // Filtra por DNI
          .limit(1) // Limita a 1 resultado (asumimos que el DNI es único)
          .get();

      if (pacientesSnapshot.docs.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'patient-not-found',
            message: 'No se encontró un paciente con el DNI proporcionado');
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcTrVoice') // Colección de historias clínicas
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      if (hcSnapshot.docs.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'hc-not-found',
            message: 'No se encontró una historia clínica para este paciente');
      }

      // Obtener los datos de la historia clínica
      final hcData = hcSnapshot.docs.first.data();
      final hcId = hcSnapshot.docs.first.id; // Obtener el ID del documento

      // Agregar el ID del documento a los datos de la historia clínica
      hcData['id'] = hcId;

      // Convertir los datos a un objeto CreateHcVoice
      return CreateHcVoice.fromJson(hcData);
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<void> updateHcAdult(CreateHcAdultEntity hc) async {
    try {
      if (hc.id == null || hc.id!.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'id-hc-empty',
            message: 'El ID del documento es necesario para actualizar');
      }
      final hcData = hc.toJson();

      // Actualizar el documento en Firestore
      await firestore
          .collection('HcTrAdult') // Colección de historias clínicas
          .doc(hc.id) // Referencia al documento específico
          .update(hcData); // Actualizar con los nuevos datos
      print('Historia clínica actualizada correctamente');
    } catch (e) {
      print('Error al actualizar la historia clínica: $e');
    }
  }

  @override
  Future<void> updateHcGeneral(CreateHcGeneral hc) async {
    try {
      if (hc.id == null || hc.id!.isEmpty) {
        throw FirebaseException(
            plugin: 'firestore',
            code: 'id-hc-empty',
            message: 'El ID del documento es necesario para actualizar');
      }
      final hcData = hc.toJson();

      // Actualizar el documento en Firestore
      await firestore
          .collection('HcTrGeneral') // Colección de historias clínicas
          .doc(hc.id) // Referencia al documento específico
          .update(hcData); // Actualizar con los nuevos datos

      print('Historia clínica actualizada correctamente');
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<void> updateHcPsAdult(CreateHcPsAdult hc) async {
    try {
      // Verificar que el ID del documento esté presente
      if (hc.id == null || hc.id!.isEmpty) {
        throw CustomError('El ID del documento es necesario para actualizar');
      }

      // Convertir el objeto CreateHcPsAdult a un mapa
      final hcData = hc.toJson();

      // Actualizar el documento en Firestore
      await firestore
          .collection('HcPsAdult') // Colección de historias clínicas
          .doc(hc.id) // Referencia al documento específico
          .update(hcData); // Actualizar con los nuevos datos

      print('Historia clínica actualizada correctamente');
    } catch (e) {
      print('Error al actualizar la historia clínica: $e');
      throw CustomError('Error al actualizar la historia clínica');
    }
  }

  @override
  Future<void> updateHcVoice(CreateHcVoice hc) {
    try {
      // Verificar que el ID del documento esté presente
      if (hc.id == null || hc.id!.isEmpty) {
        throw CustomError('El ID del documento es necesario para actualizar');
      }

      // Convertir el objeto CreateHcVoice a un mapa
      final hcData = hc.toJson();

      // Actualizar el documento en Firestore
      return firestore
          .collection('HcTrVoice') // Colección de historias clínicas
          .doc(hc.id) // Referencia al documento específico
          .update(hcData) // Actualizar con los nuevos datos
          .then(
              (_) => print('Historia clínica de voz actualizada correctamente'))
          .catchError((e) {
        print('Error al actualizar la historia clínica de voz: $e');
        throw CustomError('Error al actualizar la historia clínica de voz');
      });
    } catch (e) {
      print('Error al actualizar la historia clínica de voz: $e');
      throw CustomError('Error al actualizar la historia clínica de voz');
    }
  }

  @override
  Future<bool> existHcAdult(String cedula) async {
    try {
      // 1. Buscar al paciente por su DNI
      final pacientesSnapshot = await firestore
          .collection('patients') // Colección de pacientes
          .where('dni', isEqualTo: cedula) // Filtra por DNI
          .limit(1) // Limita a 1 resultado (asumimos que el DNI es único)
          .get();

      if (pacientesSnapshot.docs.isEmpty) {
        return false; // No se encontró el paciente
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcTrAdult') // Colección de historias clínicas
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      return hcSnapshot.docs.isNotEmpty; // Retorna true si se encontró la HC
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<bool> existHcVoice(String cedula) async {
    try {
      // 1. Buscar al paciente por su DNI
      final pacientesSnapshot = await firestore
          .collection('patients') // Colección de pacientes
          .where('dni', isEqualTo: cedula) // Filtra por DNI
          .limit(1) // Limita a 1 resultado (asumimos que el DNI es único)
          .get();

      if (pacientesSnapshot.docs.isEmpty) {
        return false; // No se encontró el paciente
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcTrVoice') // Colección de historias clínicas
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      return hcSnapshot.docs.isNotEmpty; // Retorna true si se encontró la HC
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }

  @override
  Future<bool> existHcPsAdult(String cedula) async {
    try {
      // 1. Buscar al paciente por su DNI
      final pacientesSnapshot = await firestore
          .collection('patients') // Colección de pacientes
          .where('dni', isEqualTo: cedula) // Filtra por DNI
          .limit(1) // Limita a 1 resultado (asumimos que el DNI es único)
          .get();

      if (pacientesSnapshot.docs.isEmpty) {
        return false; // No se encontró el paciente
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection(
              'HcPsAdult') // Colección de historias clínicas de psicología
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      return hcSnapshot.docs.isNotEmpty; // Retorna true si se encontró la HC
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseException(e);
    } on PlatformException catch (e) {
      throw FirebaseErrorHandler.handlePlatformException(e);
    } catch (e) {
      throw FirebaseErrorHandler.handleGenericException(e);
    }
  }
}
