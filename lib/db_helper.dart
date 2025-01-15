import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
 
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
 
      await db.insert('especialidad', {'nombre_especialidad': 'Cardiología'});
      await db.insert('especialidad', {'nombre_especialidad': 'Psiquiatría'});
      await db.insert('especialidad', {'nombre_especialidad': 'Pediatría'});
      await db.insert('especialidad', {'nombre_especialidad': 'Dermatología'});
      await db.insert('especialidad', {'nombre_especialidad': 'Oftanmología'});
      await db.insert('especialidad', {'nombre_especialidad': 'Traumatología'});
          

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
      await db.insert('profesional', {'nombre_profesional': 'Dra. Ana Sánchez', 'id_especialidad': 2});
      await db.insert('profesional', {'nombre_profesional': 'Dr. Pedro Díaz', 'id_especialidad': 3});
      await db.insert('profesional', {'nombre_profesional': 'Dra. Isabel Pérez', 'id_especialidad': 4});
      await db.insert('profesional', {'nombre_profesional': 'Dr. Juan Fernández', 'id_especialidad': 5});
      await db.insert('profesional', {'nombre_profesional': 'Dr. Marcos López', 'id_especialidad': 6});
      await db.insert('profesional', {'nombre_profesional': 'Dra. Clara Rodríguez', 'id_especialidad': 1});
      await db.insert('profesional', {'nombre_profesional': 'Dr. Felipe Pérez', 'id_especialidad': 2});
      await db.insert('profesional', {'nombre_profesional': 'Dra. Marta Jiménez', 'id_especialidad': 3});
      await db.insert('profesional', {'nombre_profesional': 'Dr. Alberto Torres', 'id_especialidad': 4});
      await db.insert('profesional', {'nombre_profesional': 'Dr. Raúl González', 'id_especialidad': 5});
      await db.insert('profesional', {'nombre_profesional': 'Dra. Sofía Fernández', 'id_especialidad': 6});

      //CENTRO MÉDICO
      await db.execute('''
        CREATE TABLE centro_medico(
          id_centro INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre_centro TEXT NOT NULL,
          direccion TEXT,
          id_especialidad INTEGER NOT NULL,
          FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad) ON DELETE CASCADE
        )
      ''');

      await db.insert('centro_medico', {'nombre_centro': 'Centro Médico Angustias', 'direccion': 'Calle de las Angustias 17, Valladolid', 'id_especialidad': 1});
      await db.insert('centro_medico', {'nombre_centro': 'Centro Médico San José', 'direccion': 'Calle Pío del Río Hortega 12, Valladolid', 'id_especialidad': 2});
      await db.insert('centro_medico', {'nombre_centro': 'Hospital Sagrado Corazón de Jesús', 'direccion': 'Calle Fidel Recio 1, Valladolid', 'id_especialidad': 3});
      await db.insert('centro_medico', {'nombre_centro': 'LoMás, Dermatología y Medicina Estética Integral', 'direccion': 'Calle de Juan Antonio Morales Pintor 2, Valladolid', 'id_especialidad': 4});
      await db.insert('centro_medico', {'nombre_centro': 'IOBA', 'direccion': 'Campus Miguel Delibes, Paseo de Belén 17, Valladolid', 'id_especialidad': 5});
      await db.insert('centro_medico', {'nombre_centro': 'Origen Diagnóstico y Traumatología', 'direccion': 'Calle Paulina Harriet 4-6, Valladolid', 'id_especialidad': 6});

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
      await db.insert('usuario', {'nombre': 'María López', 'correo': 'maria.lopez@email.com', 'contrasena': 'Maria', 'numero_tarjeta': '0987654321', 'compania': 'Adeslas'}, conflictAlgorithm: ConflictAlgorithm.replace);


      }, version: 1
    );
  }

  Future<void> eliminarBD()async{
    final databasePath = await getDatabasesPath();
    final path= join(databasePath, 'medconnect.db');
 
    await deleteDatabase(path);
    print("Base de datos eliminada");
  }
}