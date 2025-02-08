import 'package:sqflite/sqflite.dart';
import '/model/especialidad_model.dart';
import '/model/profesional_model.dart';
import '/services/db_helper.dart';

/// **Clase que maneja las operaciones CRUD para la entidad `Profesional`.**
///
/// Proporciona métodos para obtener profesionales, filtrarlos por especialidad
/// y recuperar la especialidad asociada a un profesional en la base de datos.
class ProfesionalCRUD {
  /// Instancia del helper de base de datos.
  DBHelper db = DBHelper();


  /// **Función** que obtiene la lista de todos los profesionales en la base de datos.
  ///
  /// @returns → Una `Future<List<Profesional>>` con todos los profesionales almacenados.
  Future<List<Profesional>> obtenerProfesionales() async {
    Database database = await db.abrirBD();

    final List<Map<String, dynamic>> mapas = await database.query('profesional');

    // Convierte el resultado en una lista de objetos `Profesional`
    return List.generate(mapas.length, (i){
      return Profesional.fromMap(mapas[i]);
    });
  }


  /// **Función** que obtiene la lista de profesionales que pertenecen a una especialidad concreta.
  ///
  /// @param idEspecialidad → El ID de la especialidad a filtrar.
  /// @returns → Una `Future<List<Profesional>>` con los profesionales de la especialidad.
  Future<List<Profesional>> obtenerProfesionalesPorEspecialidad(int idEspecialidad) async {
    Database database = await db.abrirBD();

    final List<Map<String, dynamic>> mapas = await database.query(
      'profesional',
      where: 'id_especialidad = ?', // Filtro por id_especialidad
      whereArgs: [idEspecialidad],
    );

    return List.generate(mapas.length, (i) {
      return Profesional.fromMap(mapas[i]);
    });
  }


  /// **Función** que obtiene la especialidad de un profesional en base a su ID.
  ///
  /// @param idProfesional → El ID del profesional cuya especialidad se quiere obtener.
  /// @returns → Un `Future<Especialidad?>` con la especialidad encontrada, o `null` si no existe.
  Future<Especialidad?> obtenerEspecialidadDeProfesional(int idProfesional) async {
    Database database = await db.abrirBD();

    // Consulta SQL para obtener la especialidad asociada a un profesional.
    List<Map<String, dynamic>> result = await database.rawQuery('''
      SELECT e.id_especialidad, e.nombre_especialidad, e.color
      FROM profesional p
      JOIN especialidad e ON p.id_especialidad = e.id_especialidad
      WHERE p.id_profesional = ?
    ''', [idProfesional]);

    if (result.isNotEmpty) {
      // Devuelve la especialidad encontrada.
      return Especialidad.fromMap(result[0]);
    } else {
      // Retorna null si el profesional no tiene especialidad asignada.
      return null;
    }
  }


  /// **Función** que obtiene un profesional en base a su ID.
  ///
  /// @param idProfesional → El ID del profesional a buscar.
  /// @returns → Un `Future<Profesional?>` con el profesional encontrado, o `null` si no existe.
  Future<Profesional?> obtenerProfesional(int idProfesional) async {
    Database database = await db.abrirBD();

    final List<Map<String, dynamic>> mapas = await database.query(
      'profesional',
      where: 'id_profesional = ?', // Filtro por id_profesional
      whereArgs: [idProfesional],
    );

    if (mapas.isNotEmpty) {
      // Devuelve el primer profesional encontrado
      return Profesional.fromMap(mapas.first);
    } else {
      // Retorna null si no se encuentra el profesional.
      return null;
    }
  }
}