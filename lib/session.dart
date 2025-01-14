import 'clases/usuario.dart';

class Session {
  static final Session _instance = Session._internal();
  
  Usuario? _usuario;
  
  factory Session() {
    return _instance;
  }
  
  Session._internal();
  
  Usuario? get usuario => _usuario;

  void set(Usuario ususario) {
    _usuario = usuario;
  }

  Usuario? get() {
    return usuario;
  }
}