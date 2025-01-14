import 'package:proyecto_final/clases/profesional.dart';
import 'package:proyecto_final/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class ProfesionalDAO {
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
}