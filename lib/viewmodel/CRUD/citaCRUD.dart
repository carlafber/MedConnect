import 'package:intl/intl.dart';
import 'package:proyecto_final/model/cita.dart';
import 'package:proyecto_final/services/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class CitaCRUD {
  DBHelper db = DBHelper();

  Future<int> crearCita(Cita cita) async {
    Database database = await db.abrirBD();
    
    // Convertir el objeto Cita a mapa
    Map<String, dynamic> citaMap = cita.toMap();

    // Imprimir la sentencia SQL
    /*String columnas = citaMap.keys.join(', ');
    String valores = citaMap.values.map((e) => "'$e'").join(', '); // Escapar las comillas si es necesario

    print('INSERT INTO cita ($columnas) VALUES ($valores);');*/

    int resultado = await database.insert(
      'cita', // Nombre de la tabla
      citaMap, // Mapa de la cita que se insertará
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

  Future<List<Cita>> obtenerCitasProximasUsuario(int idUsuario) async {
    Database database = await db.abrirBD();

    final DateTime hoy = DateTime.now();
    final String fechaHoy = DateFormat('yyyy-MM-dd').format(hoy); // Formato yyyy-MM-dd
    
    // Realiza una consulta con filtro por id_especialidad
    final List<Map<String, dynamic>> mapas = await database.query(
      'cita',
      where: 'id_usuario = ? AND fecha >= ?', // Filtro por id_usuario y fecha
      whereArgs: [idUsuario, fechaHoy],   // Argumentos para el filtro
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
    print('CITA con id $idCita eliminada');
  }

  Future<void> actualizarCita(int? idCita, String fecha, String hora) async {
    Database database = await db.abrirBD();  // Abre la base de datos
    await database.update(
      'cita',  // Nombre de la tabla
      {  // Campos a actualizar (en un solo mapa)
        'fecha': fecha,
        'hora': hora,
      },
      where: 'id_cita = ?',  // Filtro para encontrar el usuario
      whereArgs: [idCita],  // Argumento con el ID del usuario
    );
    print('CITA con id $idCita actualizada');
  }
}