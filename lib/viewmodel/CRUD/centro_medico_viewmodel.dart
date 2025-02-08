import 'package:sqflite/sqflite.dart';
import '/model/centro_medico_model.dart';
import '/services/db_helper.dart';

/// **Clase que maneja las operaciones CRUD para la entidad `CentroMedico`.**
///
/// Proporciona métodos para obtener información sobre los centros médicos,incluyendo la
/// consulta de todos ellos, la búsqueda por especialidad y la obtención de un centro específico.
class CentroMedicoCRUD {
  /// Instancia del helper de base de datos.
  DBHelper db = DBHelper();


  /// **Función** que obtiene la lista de todos los centros médicos en la base de datos.
  ///
  /// @returns → Un `Future<List<CentroMedico>>` con todos los centros médicos disponibles.
  Future<List<CentroMedico>> obtenerCentrosMedicos() async {
    Database database = await db.abrirBD();

    // Consulta todos los centros médicos.
    final List<Map<String, dynamic>> mapas = await database.query('centro_medico');

    // Convierte los resultados en una lista de objetos CentroMedico.
    return List.generate(mapas.length, (i){
      return CentroMedico.fromMap(mapas[i]);
    });
  }


  /// **Función** que obtiene los centros médicos que ofrecen una especialidad concreta.
  ///
  /// @param idEspecialidad → El ID de la especialidad.
  /// @returns → Un `Future<List<CentroMedico>>` con los centros médicos que ofrecen la especialidad indicada.
  Future<List<CentroMedico>> obtenerCentrosPorEspecialidad(int idEspecialidad) async {
    Database database = await db.abrirBD();
    
    final List<Map<String, dynamic>> mapas = await database.query(
      'centro_medico',
      where: 'id_especialidad = ?', // Filtro por id_especialidad
      whereArgs: [idEspecialidad],
    );

    return List.generate(mapas.length, (i) {
      return CentroMedico.fromMap(mapas[i]);
    });
  }


  /// **Función** que obtiene un centro médico por su ID.
  ///
  /// @param idCentro → El ID del centro médico a buscar.
  /// @returns → Un `Future<CentroMedico?>` con el centro médico si se encuentra, o `null` si no existe.
  Future<CentroMedico?> obtenerCentro(int idCentro) async {
    Database database = await db.abrirBD();

    final List<Map<String, dynamic>> mapas = await database.query(
      'centro_medico',
      where: 'id_centro = ?', // Filtro por id_centro
      whereArgs: [idCentro],
    );

    if (mapas.isNotEmpty) {
      // Devuelve el primer centro médico encontrado
      return CentroMedico.fromMap(mapas.first);
    } else {
      // Retorna null si no se encuentra el centro médico.
      return null;
    }
  }
}