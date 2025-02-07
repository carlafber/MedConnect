import 'package:flutter/material.dart';
import '/model/usuario_model.dart';

class UsuarioProvider extends ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUsuario(Usuario nuevoUsuario) {
    _usuario = nuevoUsuario;
    notifyListeners(); // Notifica a los widgets que dependen de este provider
  }

  void clearUsuario() {
    _usuario = null;
    notifyListeners();
  }
}