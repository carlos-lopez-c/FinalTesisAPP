import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // Importamos el paquete Firestore
import 'package:h_c_1/auth/infrastructure/errors/auth_errors.dart';
import 'package:h_c_1/config/constants/enviroments.dart';
import 'package:h_c_1/hc_tr/domain/datasources/hc_datasource.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_adult/hc_adult_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_general/hc_general_entity.dart';
import 'package:h_c_1/hc_tr/domain/entities/hc_voice/create_hc_voice_entity.dart';
import 'package:h_c_1/shared/infrastructure/services/key_value_storage_service_impl.dart';

class HcDatasourceImpl implements HcDatasource {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  // Obtiene el token de Firebase
  Future<String?> _getFirebaseToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Obtén el token de Firebase
      String? idToken = await user.getIdToken();
      return idToken;
    }
    return null;  // Si el usuario no está autenticado
  }

  // Configura el token en el header de autorización
  Future<void> _setAuthorizationHeader() async {
    final token = await _getFirebaseToken();
    print('Firebase Token: $token');
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      print('No se pudo obtener el token de Firebase');
    }
  }

  // Manejo de errores de Dio
  void _handleDioError(DioException error) {
    if (error.response?.statusCode == 400) {
      print('Error: ${error.response?.data}');
      throw CustomError(error.response?.data['message'] ?? 'Error en la solicitud');
    }
    if (error.response?.statusCode == 401) {
      print('Error: ${error.response?.data}');
      throw CustomError(error.response?.data['message'] ?? 'No has iniciado sesión');
    }
    if (error.response?.statusCode == 403) {
      print('Error: ${error.response?.data}');
      throw CustomError(error.response?.data['message'] ?? 'No tienes permisos');
    }
    if (error.response?.statusCode == 404) {
      print('Error: ${error.response?.data}');
      throw CustomError(error.response?.data['message'] ?? 'Recurso no encontrado');
    }
    if (error.response?.statusCode == 500) {
      print('Error: ${error.response?.data}');
      throw CustomError(error.response?.data['message'] ?? 'Error en el servidor');
    }
    print('Error: $error');
    throw CustomError('Error desconocido');
  }

  @override
  Future<void> createHcGeneral(CreateHcGeneral hc) async {
    try {
      await _setAuthorizationHeader();  // Agregar token al header

      // Guardar en Firestore en la colección "HcTrGeneral"
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final hcCollection = firestore.collection('HcTrGeneral');

      // Guardamos la historia clínica en la colección
      await hcCollection.add(hc.toJson());
      print("Historia clínica guardada en Firestore");

      // Realizamos la solicitud a la API
      final response = await dio.post('/hc/medical-history-terapy', data: hc.toJson());

      print("response: ${response.data}");
    } on DioException catch (error) {
      _handleDioError(error);  // Manejo de errores
    } catch (e) {
      print('Error: $e');
      throw CustomError('Error al crear la historia clínica');
    }
  }

  @override
  Future<void> createHcAdult(CreateHcAdultEntity hc) async {
    try {
      await _setAuthorizationHeader();  // Agregar token al header

      // Guardar en Firestore en la colección "HcTrGeneral"
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final hcCollection = firestore.collection('HcTrGeneral');

      // Guardamos la historia clínica en la colección
      await hcCollection.add(hc.toJson());
      print("Historia clínica guardada en Firestore");

      // Realizamos la solicitud a la API
      final response = await dio.post('/hc/adult-dietary-anamnesis', data: hc.toJson());

      print("response: ${response.data}");
    } on DioException catch (error) {
      _handleDioError(error);  // Manejo de errores
    } catch (e) {
      print('Error: $e');
      throw CustomError('Error al crear la historia clínica');
    }
  }

  @override
  Future<void> createHcVoice(CreateHcVoice hc) {
    // TODO: implement createHcVoice
    throw UnimplementedError();
  }

  @override
  Future<CreateHcGeneral> getHcGeneral(String cedula) async {
    try {
      await _setAuthorizationHeader();  // Agregar token al header
      print('cedula: $cedula');
      final response = await dio.get('/hc/medical-history-terapy/$cedula');
    
      if (response.data == null || response.data['hc'] == null) {
        throw CustomError('No se encontró la historia clínica');
      }

      final data = response.data['hc'];
      print('response: $data');
      return CreateHcGeneral.fromJson(data);  // Retorna el valor esperado

    } on DioException catch (e) {
      _handleDioError(e);  // Manejo de errores
      rethrow; // Asegúrate de lanzar nuevamente la excepción
    } catch (e) {
      print('Error: $e');
      throw CustomError('Error al obtener la historia clínica');
    }
  }
}
