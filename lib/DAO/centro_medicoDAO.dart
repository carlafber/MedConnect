import 'package:proyecto_final/clases/centro_medico.dart';
import 'package:proyecto_final/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class CentroMedicoDAO {
  DBHelper db = DBHelper();

  Future<List<CentroMedico>> obtenerCentrosMeidcos() async {
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
}