import '../model/usuario_model.dart';

class Guardar {  
  static final Guardar _instance = Guardar._internal();
  Usuario? _usuario; // Hacemos la variable privada y opcional (null safety)

  factory Guardar() {
    return _instance;
  }

  Guardar._internal();

  // Función para guardar el usuario
  void set(Usuario nuevoUsuario) {
    _usuario = nuevoUsuario;
  }

  // Función para obtener el usuario
  Usuario? get() {
    return _usuario;
  }
}