import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderIdioma extends ChangeNotifier{
  Locale _idioma = Locale('es');

  ProviderIdioma() {
    _cargarPreferencias();
  }

  Locale get idioma => _idioma;

  Future<void> cambiarIdioma(String codigoIdioma) async {
    _idioma = Locale(codigoIdioma);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', codigoIdioma);
  }


  Future<void> _cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    _idioma = Locale(prefs.getString('idioma') ?? 'es');
    notifyListeners();
  }
}