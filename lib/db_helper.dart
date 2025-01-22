import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
 
class DBHelper{
  Future<Database> abrirBD() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'medconnect.db');


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
      await db.insert('usuario', {'nombre': 'María López', 'correo': 'maria.lopez@email.com', 'contrasena': 'Maria', 'numero_tarjeta': '0987654321', 'compania': 'Adeslas'}, conflictAlgorithm: ConflictAlgorithm.replace);
      await db.insert('usuario', {'nombre': 'Carlos Gómez', 'correo': 'carlos.gomez@email.com', 'contrasena': 'Carlitos13', 'numero_tarjeta': '4561230789', 'compania': 'Caser'}, conflictAlgorithm: ConflictAlgorithm.replace);
      await db.insert('usuario', {'nombre': 'Laura Fernández', 'correo': 'laura.fernandez@email.com', 'contrasena': 'Laurita', 'numero_tarjeta': '1122334455', 'compania': 'Asisa'}, conflictAlgorithm: ConflictAlgorithm.replace);
      await db.insert('usuario', {'nombre': 'Jorge Martínez', 'correo': 'jorge.martinez@email.com', 'contrasena': 'JorgeM', 'numero_tarjeta': '9988776655', 'compania': 'Adeslas'}, conflictAlgorithm: ConflictAlgorithm.replace);
      await db.insert('usuario', {'nombre': 'Beatriz González', 'correo': 'beatriz.gonzalez@email.com', 'contrasena': 'Beita69', 'numero_tarjeta': '5566778899', 'compania': 'Caser'}, conflictAlgorithm: ConflictAlgorithm.replace);
      await db.insert('usuario', {'nombre': 'Antonio Ruiz', 'correo': 'antonio.ruiz@email.com', 'contrasena': 'Antonito', 'numero_tarjeta': '6677889900', 'compania': 'Adeslas'}, conflictAlgorithm: ConflictAlgorithm.replace);
      await db.insert('usuario', {'nombre': 'Elena Ramírez', 'correo': 'elena.ramirez@email.com', 'contrasena': 'Elena1234', 'numero_tarjeta': '4455667788', 'compania': 'Caser'}, conflictAlgorithm: ConflictAlgorithm.replace);


      //ESPECIALIDAD
      await db.execute('''
        CREATE TABLE especialidad(
          id_especialidad INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre_especialidad TEXT NOT NULL,
          color TEXT NOT NULL
        )
      ''');
 
      await db.insert('especialidad', {'nombre_especialidad': 'Cardiología', 'color': '0x4DFF5B5B'});
      await db.insert('especialidad', {'nombre_especialidad': 'Psiquiatría', 'color': '0x4DFF5BEE'});
      await db.insert('especialidad', {'nombre_especialidad': 'Pediatría', 'color': '0x4DBE5BFF'});
      await db.insert('especialidad', {'nombre_especialidad': 'Dermatología', 'color': '0x4D42EA54'});
      await db.insert('especialidad', {'nombre_especialidad': 'Oftanmología', 'color': '0x4D5BCDFF'});
      await db.insert('especialidad', {'nombre_especialidad': 'Traumatología', 'color': '0x4DFFA35B'});
          

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
      
      await db.insert('cita', {'id_usuario': 1, 'id_profesional': 1, 'id_centro': 1, 'fecha': '2025-02-10', 'hora': '10:00'});
      await db.insert('cita', {'id_usuario': 2, 'id_profesional': 2, 'id_centro': 2, 'fecha': '2025-03-15', 'hora': '14:30'});
      await db.insert('cita', {'id_usuario': 3, 'id_profesional': 3, 'id_centro': 3, 'fecha': '2025-04-20', 'hora': '09:00'});
      await db.insert('cita', {'id_usuario': 4, 'id_profesional': 4, 'id_centro': 4, 'fecha': '2025-05-12', 'hora': '11:00'});
      await db.insert('cita', {'id_usuario': 5, 'id_profesional': 5, 'id_centro': 5, 'fecha': '2025-06-18', 'hora': '15:30'});
      await db.insert('cita', {'id_usuario': 1, 'id_profesional': 6, 'id_centro': 6, 'fecha': '2025-07-22', 'hora': '08:30'});
      await db.insert('cita', {'id_usuario': 4, 'id_profesional': 1, 'id_centro': 1, 'fecha': '2025-08-01', 'hora': '09:30'});
      await db.insert('cita', {'id_usuario': 5, 'id_profesional': 2, 'id_centro': 2, 'fecha': '2025-08-02', 'hora': '13:00'});
      await db.insert('cita', {'id_usuario': 6, 'id_profesional': 3, 'id_centro': 3, 'fecha': '2025-08-03', 'hora': '11:15'});
      await db.insert('cita', {'id_usuario': 7, 'id_profesional': 4, 'id_centro': 4, 'fecha': '2025-08-04', 'hora': '14:45'});
      await db.insert('cita', {'id_usuario': 8, 'id_profesional': 5, 'id_centro': 5, 'fecha': '2025-08-05', 'hora': '16:30'});
      await db.insert('cita', {'id_usuario': 2, 'id_profesional': 6, 'id_centro': 6, 'fecha': '2025-08-06', 'hora': '17:00'});
      await db.insert('cita', {'id_usuario': 1, 'id_profesional': 8, 'id_centro': 2, 'fecha': '2025-01-23', 'hora': '12:00'});
      await db.insert('cita', {'id_usuario': 1, 'id_profesional': 9, 'id_centro': 3, 'fecha': '2025-04-14', 'hora': '17:30'});
      await db.insert('cita', {'id_usuario': 1, 'id_profesional': 5, 'id_centro': 5, 'fecha': '2025-03-05', 'hora': '12:40'});
      await db.insert('cita', {'id_usuario': 1, 'id_profesional': 4, 'id_centro': 4, 'fecha': '2025-02-03', 'hora': '19:30'});
      await db.insert('cita', {'id_usuario': 2, 'id_profesional': 7, 'id_centro': 1, 'fecha': '2025-01-09', 'hora': '13:15'});
      await db.insert('cita', {'id_usuario': 2, 'id_profesional': 7, 'id_centro': 1, 'fecha': '2025-03-10', 'hora': '17:20'});
      await db.insert('cita', {'id_usuario': 2, 'id_profesional': 4, 'id_centro': 4, 'fecha': '2025-02-11', 'hora': '20:15'});
      await db.insert('cita', {'id_usuario': 2, 'id_profesional': 11, 'id_centro': 5, 'fecha': '2025-01-30', 'hora': '18:30'});



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