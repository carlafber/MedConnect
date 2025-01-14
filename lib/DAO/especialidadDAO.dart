import 'package:proyecto_final/clases/especialidad.dart';
import 'package:proyecto_final/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class EspecialidadDAO {
  DBHelper db = DBHelper();

  Future<List<Especialidad>> obtenerEspecialidades() async {
    Database database = await db.abrirBD();
    final List<Map<String, dynamic>> mapas = await database.query('especialidad');
    print("especialidades: $mapas");
    return List.generate(mapas.length, (i){
      return Especialidad.fromMap(mapas[i]);
    });
  }
}