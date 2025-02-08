import '/model/especialidad_model.dart';
import '/model/profesional_model.dart';
import '/services/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class ProfesionalCRUD {
  DBHelper db = DBHelper();

  Future<List<Profesional>> obtenerProfesionales() async {
    Database database = await db.abrirBD();
    final List<Map<String, dynamic>> mapas = await database.query('profesional');
    print("profesionales: $mapas");
    return List.generate(mapas.length, (i){
      return Profesional.fromMap(mapas[i]);
    });
  }

  Future<List<Profesional>> obtenerProfesionalesPorEspecialidad(int idEspecialidad) async {
    Database database = await db.abrirBD();
    
    // Realiza una consulta con filtro por id_especialidad
    final List<Map<String, dynamic>> mapas = await database.query(
      'profesional',
      where: 'id_especialidad = ?', // Filtro por id_especialidad
      whereArgs: [idEspecialidad],   // Argumento para el filtro
    );
    print("profesionales: $mapas");
    // Convierte el resultado en una lista de objetos Profesional
    return List.generate(mapas.length, (i) {
      return Profesional.fromMap(mapas[i]);
    });
  }

  Future<Especialidad?> obtenerEspecialidadDeProfesional(int idProfesional) async {
    Database database = await db.abrirBD();

    List<Map<String, dynamic>> result = await database.rawQuery('''
      SELECT e.id_especialidad, e.nombre_especialidad, e.color
      FROM profesional p
      JOIN especialidad e ON p.id_especialidad = e.id_especialidad
      WHERE p.id_profesional = ?
    ''', [idProfesional]);

    if (result.isNotEmpty) {
      // Si la consulta retorna resultados, creamos un objeto Especialidad
      return Especialidad.fromMap(result[0]);
    } else {
      // Si no se encuentra el profesional, devolvemos null
      return null;
    }
  }

  Future<Profesional?> obtenerProfesional(int idProfesional) async {
    Database database = await db.abrirBD();

    // Realiza una consulta con filtro por id_profesional
    final List<Map<String, dynamic>> mapas = await database.query(
      'profesional',
      where: 'id_profesional = ?',  // Filtro por id_profesional
      whereArgs: [idProfesional],    // Argumento para el filtro
    );

    // Si no se encuentra el profesional, retornamos null
    if (mapas.isNotEmpty) {
      return Profesional.fromMap(mapas.first); // Retorna el primer profesional encontrado
    } else {
      return null;
    }
  }
}