import 'package:proyecto_final/clases/cita.dart';
import 'package:proyecto_final/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class CitaDAO {
  DBHelper db = DBHelper();

  Future<int> crearCita(Cita cita) async {
    Database database = await db.abrirBD();
    int resultado = await database.insert(
      'cita', // Nombre de la tabla
      cita.toMap(), // Mapa de la cita que se insertará
      conflictAlgorithm: ConflictAlgorithm.replace, // Si ya existe, reemplaza
    );
    print("Cita creada con ID: $resultado");
    return resultado;
  }
}