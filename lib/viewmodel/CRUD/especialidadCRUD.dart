import 'package:proyecto_final/model/especialidad.dart';
import 'package:proyecto_final/services/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class EspecialidadCRUD {
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