import 'clases/usuario.dart';

class Guardar {  
  static final Guardar _instance = Guardar._internal();
  Usuario? _usuario; // Hacemos la variable privada y opcional (null safety)

  factory Guardar() {
    return _instance;
  }

  Guardar._internal();

  void set(Usuario nuevoUsuario) {
    _usuario = nuevoUsuario;
    print(_usuario);
    print("nombre: ${_usuario!.nombre}, id: ${_usuario!.idUsuario}");
  }

  Usuario? get() {
    return _usuario;
  }
}