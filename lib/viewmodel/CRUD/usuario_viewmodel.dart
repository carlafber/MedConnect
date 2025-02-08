import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/model/usuario_model.dart';
import '/services/db_helper.dart';

/// **Clase que maneja las operaciones CRUD para la entidad `Usuario`.**
///
/// Proporciona métodos para obtener, insertar, actualizar y eliminar usuarios en la base de datos.
class UsuarioCRUD {
  /// Instancia del helper de base de datos.
  DBHelper db = DBHelper();


  /// **Función** que obtiene la lista de todos los usuarios en la base de datos.
  ///
  /// @returns → Una `Future<List<Usuario>>` con todos los usuarios almacenados.
  Future<List<Usuario>> obtenerUsuarios() async {
    Database database = await db.abrirBD();

    final List<Map<String, dynamic>> mapas = await database.query('usuario');

    return List.generate(mapas.length, (i){
      return Usuario.fromMap(mapas[i]);
    });
  }


  /// **Función** que verifica si un número de tarjeta específico corresponde con un usuario existente en la base de datos.
  ///
  /// @param numTarjetaIntroducido → El número de tarjeta del usuario a verificar.
  /// @returns → Un `Future<Usuario?>` con el usuario si existe, o `null` si no se encuentra.
  Future<Usuario?> existeUsuario(String numTarjetaIntroducido) async {
    // Obtener la lista de usuarios desde la base de datos
    List<Usuario> usuarios = await obtenerUsuarios();

    for (var usuario in usuarios) {
      if (usuario.numeroTarjeta == numTarjetaIntroducido) {
        // Devuelve el usuario si el número de tarjeta coincide.
        return usuario;
      }
    }
    // Devuelve null si no se encuentra un usuario con ese número de tarjeta.
    return null;
  }


  /// **Función** que obtiene un usuario por su ID.
  ///
  /// @param idUsuario → El ID del usuario a buscar.
  /// @returns → Un `Future<Usuario>` con el usuario correspondiente al ID.
  Future<Usuario> obtenerUsuario(int idUsuario) async {
    Database database = await db.abrirBD();
    
    final List<Map<String, dynamic>> mapa = await database.query(
      'usuario', // El nombre de la tabla
      where: 'id_ususario = ?', // Filtrar el usuario por ID.
      whereArgs: [idUsuario], // El argumento que contiene el ID del usuario
      limit: 1, // Limitar la consulta a un solo resultado.
    );
    // Devuelve el primer usuario de la lista.
    return Usuario.fromMap(mapa.first);
  }


  /// **Método** que elimina un usuario de la base de datos.
  ///
  /// @param idUsuario → El ID del usuario a eliminar.
  Future<void> eliminarUsuario(int idUsuario) async {
    Database database = await db.abrirBD();

    await database.delete(
      'usuario',
      where: 'id_usuario = ?',  // Filtro para eliminar el usuario por ID
      whereArgs: [idUsuario],
    );
  }


  /// **Método** que actualiza la contraseña de un usuario en la base de datos.
  ///
  /// @param idUsuario → El ID del usuario cuya contraseña se actualizará.
  /// @param contrasenaNueva → El `TextEditingController` con la nueva contraseña.
  Future<void> actualizarContrasena(int? idUsuario, TextEditingController contrasenaNueva) async {
    Database database = await db.abrirBD();

    await database.update(
      'usuario',
      {'contrasena': contrasenaNueva},  // Campo a actualizar
      where: 'id_usuario = ?',  // Filtro para actualizar el usuario por ID
      whereArgs: [idUsuario],
    );
  }
}