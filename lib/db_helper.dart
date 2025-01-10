import 'package:path/path.dart';
import 'package:proyecto_final/clases/especialidad.dart';
import 'package:proyecto_final/clases/profesional.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'clases/usuario.dart';
 
class DBHelper{
  Future<Database> abrirBD() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'medconnect.db');

    print("Conectado a la base de datos");

    return openDatabase(path, onCreate: (db, version) async{
      //USUARIO
      await db.execute('''
        CREATE TABLE usuario (
          id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT NOT NULL,
          correo TEXT NOT NULL UNIQUE,
          contrasena TEXT NOT NULL,
          numero_tarjeta TEXT NOT NULL UNIQUE,
          compania TEXT
        )
      ''');

      await db.insert('usuario', {'nombre': 'Juan Pérez', 'correo': 'juan.perez@email.com', 'contrasena': '1234', 'numero_tarjeta': '1234567890', 'compania': 'Asisa'}, conflictAlgorithm: ConflictAlgorithm.replace);
 
      //ESPECIALIDAD
      await db.execute('''
        CREATE TABLE especialidad(
          id_especialidad INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre_especialidad TEXT NOT NULL
        )
      ''');
 
      int idEspecialidad = await db.insert('especialidad', {'nombre_especialidad': 'Cardiología'});
      print('ID de la especialidad insertada: $idEspecialidad');


      //PROFESIONAL
      await db.execute('''
        CREATE TABLE profesional(
          id_profesional INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre_profesional TEXT NOT NULL,
          id_especialidad INTEGER NOT NULL,
          FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad) ON DELETE CASCADE
        )
      ''');

      await db.insert('profesional', {'nombre_profesional': 'Dr. Luis Martínez', 'id_especialidad': 1});

      //CENTRO MÉDICO
      await db.execute('''
        CREATE TABLE centro_medico(
          id_centro INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre_centro TEXT NOT NULL,
          direccion TEXT
        )
      ''');

      await db.insert('centro_medico', {'nombre_centro': 'Centro Médico Angustias', 'direccion': 'Calle de las Angustias 17, Valladolid'});

      //CITA
      await db.execute('''
        CREATE TABLE cita (
          id_cita INTEGER PRIMARY KEY AUTOINCREMENT,
          id_usuario INTEGER NOT NULL,
          id_profesional INTEGER NOT NULL,
          id_centro INTEGER NOT NULL,
          fecha DATE NOT NULL,
          hora TIME NOT NULL,
          FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE,
          FOREIGN KEY (id_profesional) REFERENCES profesional (id_profesional) ON DELETE CASCADE,
          FOREIGN KEY (id_centro) REFERENCES centro_medico (id_centro) ON DELETE CASCADE
        )
      ''');
      
      await db.insert('cita', {'id_usuario': 1, 'id_profesional': 1, 'id_centro': 1, 'fecha': '2025-02-10', 'hora': '10:00:00'});

      }, version: 1
    );
  }

  Future<void> eliminarBD()async{
    final databasePath = await getDatabasesPath();
    final path= join(databasePath, 'medconnect.db');
 
    await deleteDatabase(path);
    print("Base de datos eliminada");
  }


  Future<List<Usuario>> obtenerUsuarios() async {
    Database database = await abrirBD();
    final List<Map<String, dynamic>> mapas = await database.query('usuario');
    return List.generate(mapas.length, (i){
      return Usuario.fromMap(mapas[i]);
    });
  }

  Future<Usuario?> existeUsuario(String numTarjetaIntroducido) async {
    //Obtener la lista de usuarios desde la base de datos
    List<Usuario> usuarios = await obtenerUsuarios();

    for (var usuario in usuarios) {
      if (usuario.numeroTarjeta == numTarjetaIntroducido) {
        // Si el número de tarjeta coincide, devuelve el usuario
        return usuario;
      }
    }

    // Si no se encuentra el usuario con el número de tarjeta, devuelve null
    return null;
  }

  Future<List<Especialidad>> obtenerEspecialidades() async {
    Database database = await abrirBD();
    final List<Map<String, dynamic>> mapas = await database.query('especialidad');
    return List.generate(mapas.length, (i){
      return Especialidad.fromMap(mapas[i]);
    });
  }

  Future<List<Profesional>> obtenerProfesionales() async {
    Database database = await abrirBD();
    final List<Map<String, dynamic>> mapas = await database.query('profesional');
    return List.generate(mapas.length, (i){
      return Profesional.fromMap(mapas[i]);
    });
  }

  Future<List<Profesional>> obtenerProfesionalesPorEspecialidad(int idEspecialidad) async {
    Database database = await abrirBD();
    
    // Realiza una consulta con filtro por id_especialidad
    final List<Map<String, dynamic>> mapas = await database.query(
      'profesional',
      where: 'id_especialidad = ?', // Filtro por id_especialidad
      whereArgs: [idEspecialidad],   // Argumento para el filtro
    );
    
    // Convierte el resultado en una lista de objetos Profesional
    return List.generate(mapas.length, (i) {
      return Profesional.fromMap(mapas[i]);
    });
  }
}