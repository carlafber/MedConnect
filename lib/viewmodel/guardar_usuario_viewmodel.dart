import '/model/usuario_model.dart';

/// **Clase Singleton para almacenar un usuario en memoria.**
///
/// Almacena y recupera un objeto `Usuario` durante la ejecución de la aplicación.
/// Utiliza el patrón Singleton para asegurar que solo exista una única instancia de `Guardar`.
class Guardar {

  /// Instancia única de `Guardar` y se asigna a `_instance`.
  static final Guardar _instance = Guardar._internal();

  /// Variable privada para almacenar el usuario
  Usuario? _usuario;

  /// **Constructor** de fábrica que devuelve la instancia única de `Guardar` y
  /// asegura que siempre se utilice la misma instancia de la clase.
  factory Guardar() {
    return _instance;
  }

  /// **Constructor** interno para evitar múltiples instancias al que solo se
  /// puede acceder a través del constructor de fábrica.
  Guardar._internal();


  /// **Método** para almacenar un usuario.
  ///
  /// @param nuevoUsuario → El objeto `Usuario` que se desea guardar.
  void set(Usuario nuevoUsuario) {
    _usuario = nuevoUsuario;
  }


  /// **Función** para obtener el usuario almacenado.
  ///
  /// @returns → El objeto `Usuario` guardado, o `null` si no se ha asignado ninguno.
  Usuario? get() {
    return _usuario;
  }
}