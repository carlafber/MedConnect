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

  Future<List<Cita>> obtenerCitasUsuario(int idUsuario) async {
    Database database = await db.abrirBD();
    
    // Realiza una consulta con filtro por id_especialidad
    final List<Map<String, dynamic>> mapas = await database.query(
      'cita',
      where: 'id_usuario = ?', // Filtro por id_especialidad
      whereArgs: [idUsuario],   // Argumento para el filtro
    );
    print("citas: $mapas");
    // Convierte el resultado en una lista de objetos Profesional
    return List.generate(mapas.length, (i) {
      return Cita.fromMap(mapas[i]);
    });
  }

  Future<void> eliminarCita(int idCita) async {
    Database database = await db.abrirBD();  // Abre la base de datos
    await database.delete(
      'cita',  // El nombre de la tabla
      where: 'id_cita = ?',  // Filtro para eliminar el usuario por ID
      whereArgs: [idCita],  // El argumento que contiene el ID del usuario
    );
    print('CITA con id $idCita eliminado');
  }
}