import 'package:proyecto_final/model/centro_medico_model.dart';
import 'package:proyecto_final/services/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class CentroMedicoCRUD {
  DBHelper db = DBHelper();

  Future<List<CentroMedico>> obtenerCentrosMedicos() async {
    Database database = await db.abrirBD();
    final List<Map<String, dynamic>> mapas = await database.query('centro_medico');
    print("centros_medicos: $mapas");
    return List.generate(mapas.length, (i){
      return CentroMedico.fromMap(mapas[i]);
    });
  }

  Future<List<CentroMedico>> obtenerCentrosPorEspecialidad(int idEspecialidad) async {
    Database database = await db.abrirBD();
    
    // Realiza una consulta con filtro por id_especialidad
    final List<Map<String, dynamic>> mapas = await database.query(
      'centro_medico',
      where: 'id_especialidad = ?', // Filtro por id_especialidad
      whereArgs: [idEspecialidad],   // Argumento para el filtro
    );
    print("centros_medicos: $mapas");
    // Convierte el resultado en una lista de objetos CentroMedico
    return List.generate(mapas.length, (i) {
      return CentroMedico.fromMap(mapas[i]);
    });
  }

  Future<CentroMedico?> obtenerCentro(int idCentro) async {
    Database database = await db.abrirBD();

    // Realiza una consulta con filtro por id_profesional
    final List<Map<String, dynamic>> mapas = await database.query(
      'centro_medico',
      where: 'id_centro = ?',  // Filtro por id_profesional
      whereArgs: [idCentro],    // Argumento para el filtro
    );

    // Si no se encuentra el profesional, retornamos null
    if (mapas.isNotEmpty) {
      return CentroMedico.fromMap(mapas.first); // Retorna el primer profesional encontrado
    } else {
      return null;
    }
  }
}