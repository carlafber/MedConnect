import 'package:sqflite/sqflite.dart';
import '/model/especialidad_model.dart';
import '/services/db_helper.dart';

/// **Clase que maneja las operaciones CRUD para la entidad `Especialidad`.**
///
/// Proporciona métodos para obtener la lista de especialidades de la base de datos.
class EspecialidadCRUD {
  /// Instancia del helper de base de datos.
  DBHelper db = DBHelper();


  /// **Función** que obtiene la lista de todas las especialidades almacenadas en la base de datos.
  ///
  /// @returns → Un `Future<List<Especialidad>>` con todas las especialidades registradas.
  Future<List<Especialidad>> obtenerEspecialidades() async {
    Database database = await db.abrirBD();

    final List<Map<String, dynamic>> mapas = await database.query('especialidad');

    // Convierte el resultado en una lista de objetos Especialidad.
    return List.generate(mapas.length, (i){
      return Especialidad.fromMap(mapas[i]);
    });
  }
}