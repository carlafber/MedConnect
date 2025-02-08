import 'package:flutter/material.dart';
import '/model/usuario_model.dart';
import '/services/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioCRUD {
  DBHelper db = DBHelper();
  
  Future<List<Usuario>> obtenerUsuarios() async {
    Database database = await db.abrirBD();
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

  Future<Usuario> obtenerUsuario(int idUsuario) async {
    Database database = await db.abrirBD();
    
    final List<Map<String, dynamic>> mapa = await database.query(
      'usuario',
      where: 'id_ususario = ?', // Filtro por numero_tarjeta
      whereArgs: [idUsuario], // Argumento para el filtro
      limit: 1, // Limitamos la consulta a un solo resultado
    );

    return Usuario.fromMap(mapa.first); // Devuelve el primer usuario de la lista
  }

  Future<void> eliminarUsuario(int idUsuario) async {
    Database database = await db.abrirBD();  // Abre la base de datos
    await database.delete(
      'usuario',  // El nombre de la tabla
      where: 'id_usuario = ?',  // Filtro para eliminar el usuario por ID
      whereArgs: [idUsuario],  // El argumento que contiene el ID del usuario
    );
    print('Usuario con id $idUsuario eliminado');
  }

  Future<void> actualizarContrasena(int? idUsuario, TextEditingController contrasenaNueva) async {
    Database database = await db.abrirBD();  // Abre la base de datos
    await database.update(
      'usuario',  // Nombre de la tabla
      {'contrasena': contrasenaNueva},  // Campo a actualizar
      where: 'id_usuario = ?',  // Filtro para encontrar el usuario
      whereArgs: [idUsuario],  // Argumento con el ID del usuario
    );
    print('Contraseña del usuario con id $idUsuario actualizada');
  }

}