import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import '/model/cita_model.dart';
import '/services/db_helper.dart';

/// **Clase que maneja las operaciones CRUD para la entidad `Cita`.**
///
/// Proporciona métodos para crear, obtener, actualizar y eliminar citas en la base de datos.
class CitaCRUD {
  /// Instancia del helper de base de datos.
  DBHelper db = DBHelper();


  /// **Función** que crea una nueva cita en la base de datos.
  ///
  /// @param cita → El objeto `Cita` que se va a insertar.
  /// @returns → Un `Future<int>` con el ID de la cita creada.
  Future<int> crearCita(Cita cita) async {
    Database database = await db.abrirBD();
    
    // Convertir el objeto Cita a un mapa
    Map<String, dynamic> citaMap = cita.toMap();

    int resultado = await database.insert(
      'cita',
      citaMap,
      conflictAlgorithm: ConflictAlgorithm.replace, // Si ya existe, se reemplaza
    );

    return resultado;
  }


  /// **Función** que obtiene todas las citas de un usuario.
  ///
  /// @param idUsuario → El ID del usuario del cual se desean obtener las citas.
  /// @returns → Un `Future<List<Cita>>` con todas las citas del usuario.
  Future<List<Cita>> obtenerCitasUsuario(int idUsuario) async {
    Database database = await db.abrirBD();
    
    final List<Map<String, dynamic>> mapas = await database.query(
      'cita',
      where: 'id_usuario = ?', // Filtro por id_usuario
      whereArgs: [idUsuario],
    );

    // Convierte el resultado en una lista de objetos Cita
    return List.generate(mapas.length, (i) {
      return Cita.fromMap(mapas[i]);
    });
  }


  /// **Función** que obtiene las citas futuras de un usuario.
  ///
  /// @param idUsuario → El ID del usuario del cual se desean obtener las citas futuras.
  /// @returns → Un `Future<List<Cita>>` con las citas cuya fecha es igual o posterior a hoy.
  Future<List<Cita>> obtenerCitasProximasUsuario(int idUsuario) async {
    Database database = await db.abrirBD();

    final DateTime hoy = DateTime.now();
    final String fechaHoy = DateFormat('yyyy-MM-dd').format(hoy); // Mismo formato que en la base de datos
    
    final List<Map<String, dynamic>> mapas = await database.query(
      'cita',
      where: 'id_usuario = ? AND fecha >= ?', // Filtro por id_usuario y fecha
      whereArgs: [idUsuario, fechaHoy],
    );

    return List.generate(mapas.length, (i) {
      return Cita.fromMap(mapas[i]);
    });
  }


  /// **Método** que elimina una cita de la base de datos.
  ///
  /// @param idCita → El ID de la cita que se desea eliminar.
  Future<void> eliminarCita(int idCita) async {
    Database database = await db.abrirBD();

    await database.delete(
      'cita',
      where: 'id_cita = ?', // Filtro para eliminar la cita por ID
      whereArgs: [idCita],
    );
  }

  /// **Método** que actualiza la fecha y hora de una cita.
  ///
  /// @param idCita → El ID de la cita a actualizar.
  /// @param fecha → La nueva fecha de la cita.
  /// @param hora → La nueva hora de la cita.
  Future<void> actualizarCita(int? idCita, String fecha, String hora) async {
    Database database = await db.abrirBD();

    await database.update(
      'cita',
      {  // Campos a actualizar (en un solo mapa)
        'fecha': fecha,
        'hora': hora,
      },
      where: 'id_cita = ?', // Filtro para encontrar la cita
      whereArgs: [idCita],
    );
  }
}