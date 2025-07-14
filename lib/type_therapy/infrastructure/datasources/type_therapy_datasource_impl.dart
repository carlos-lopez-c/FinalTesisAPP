import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_c_1/type_therapy/domain/datasources/type_therapy_datasource.dart';
import 'package:h_c_1/type_therapy/domain/entities/type_therapy_entity.dart';

class TypeTherapyDatasourceImpl implements TypeTherapyDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<TypeTherapyEntity>> getTypeTherapies() async {
    try {
      // Obtiene la colección de 'specialtyTherapy'
      QuerySnapshot querySnapshot =
          await _firestore.collection('specialtyTherapy').get();

      // Mapea los documentos a una lista de TypeTherapyEntity
      List<TypeTherapyEntity> typeTherapies = querySnapshot.docs.map((doc) {
        // Obtiene los datos del documento
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Añade el ID del documento a los datos
        data['id'] = doc.id;

        // Crea una instancia de TypeTherapyEntity con los datos modificados
        return TypeTherapyEntity.fromJson(data);
      }).toList();

      return typeTherapies;
    } catch (e) {
      print('Error al obtener las especialidades de terapia: $e');
      throw Exception('Error al obtener las especialidades de terapia');
    }
  }

  @override
  Future<TypeTherapyEntity> getTypeTherapiesByNameUnique(String name) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('specialtyTherapy')
          .where('name', isEqualTo: name)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('No se encontró la especialidad de terapia');
      }

      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      data['id'] = querySnapshot.docs.first.id;
      return TypeTherapyEntity.fromJson(data);
    } catch (e) {
      print('Error al obtener la especialidad de terapia: $e');
      throw Exception('Error al obtener la especialidad de terapia');
    }
  }
}
