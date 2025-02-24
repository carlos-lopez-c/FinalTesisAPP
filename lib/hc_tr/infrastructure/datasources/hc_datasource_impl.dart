import 'package:cloud_firestore/cloud_firestore.dart'; // Importamos el paquete Firestore
import 'package:h_c_1/auth/infrastructure/errors/auth_errors.dart';
import 'package:h_c_1/hc_ps/domain/entities/hc_ps_adult/create_hc_adult.dart';
import 'package:h_c_1/hc_tr/domain/datasources/hc_datasource.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';

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
  Future<CreateHcGeneral> getHcGeneral(String cedula) async {
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
          .collection('HcTrGeneral') // Colección de historias clínicas
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
      print("Datos: $hcData");
      // Convertir los datos a un objeto CreateHcGeneral
      return CreateHcGeneral.fromJson(hcData);
    } catch (e) {
      print('Error al obtener la historia clínica: $e');
      throw CustomError('Error al obtener la historia clínica');
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
        throw CustomError(
            'No se encontró un paciente con el DNI proporcionado');
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;
      print("ID: $pacienteId");

      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcTrAdult') // Colección de historias clínicas
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
      final hcId = hcSnapshot
          .docs.first.id; // Obtener el ID del documento de la historia clínica

      print("Datos: $hcData");
      print("ID de la historia clínica: $hcId");

      // Convertir los datos a un objeto CreateHcAdultEntity, incluyendo el ID
      return CreateHcAdultEntity.fromJson(hcData, id: hcId);
    } catch (e) {
      print('Error al obtener la historia clínica: $e');
      throw CustomError('Error al obtener la historia clínica');
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
        throw CustomError(
            'No se encontró un paciente con el DNI proporcionado');
      }

      // Obtener el ID del paciente
      final pacienteId = pacientesSnapshot.docs.first.id;
      print("ID: $pacienteId");
      // 2. Buscar la historia clínica por el ID del paciente
      final hcSnapshot = await firestore
          .collection('HcTrVoice') // Colección de historias clínicas
          .where('patientId',
              isEqualTo: pacienteId) // Filtra por ID del paciente
          .limit(
              1) // Limita a 1 resultado (asumimos que hay una sola HC por paciente)
          .get();

      if (hcSnapshot.docs.isEmpty) {
        throw CustomError(
            'No se encontró una historia clínica para este paciente');
      }
      print("Datos: ${hcSnapshot.docs.first.data()}");
      // Obtener los datos de la historia clínica
      final hcData = hcSnapshot.docs.first.data();

      // Convertir los datos a un objeto CreateHcGeneral
      return CreateHcVoice.fromJson(hcData);
    } catch (e) {
      print('Error al obtener la historia clínica: $e');
      throw CustomError('Error al obtener la historia clínica');
    }
  }

  @override
  Future<void> updateHcAdult(CreateHcAdultEntity hc) async {
    try {
      if (hc.id == null || hc.id!.isEmpty) {
        throw CustomError('El ID del documento es necesario para actualizar');
      }
      final hcData = hc.toJson();

      // Actualizar el documento en Firestore
      await firestore
          .collection('HcTrAdult') // Colección de historias clínicas
          .doc(hc.id) // Referencia al documento específico
          .update(hcData); // Actualizar con los nuevos datos
      print('Holaaaaaaaaa');
      print('Historia clínica actualizada correctamente');
    } catch (e) {
      print('Error al actualizar la historia clínica: $e');
      throw CustomError('Error al actualizar la historia clínica');
    }
  }

  @override
  Future<void> updateHcGeneral(CreateHcGeneral hc) {
    // TODO: implement updateHcGeneral
    throw UnimplementedError();
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
    // TODO: implement updateHcVoice
    throw UnimplementedError();
  }
}
