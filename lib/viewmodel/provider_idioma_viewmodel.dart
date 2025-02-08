import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// **Proveedor de configuración del idioma.**
///
/// Esta clase gestiona y almacena el idioma seleccionado por el usuario, permitiendo así
/// cambiar entre idiomas y mantenerlo para que sea el mismo entre sesiones de la aplicación.
class ProviderIdioma extends ChangeNotifier{
  // Idioma por defecto: español (es)
  Locale _idioma = Locale('es');

  /// **Constructor** que carga las preferencias del idioma al inicializar el proveedor.
  ProviderIdioma() {
    cargarPreferencias();
  }

  /// Obtiene el idioma actual configurado.
  ///
  /// @returns Un objeto `Locale` que representa el idioma actual.
  Locale get idioma => _idioma;


  /// **Método** que cambia el idioma de la aplicación.
  ///
  /// @param codigoIdioma → El código del idioma (por ejemplo, 'es' para español, 'en' para inglés).
  Future<void> cambiarIdioma(String codigoIdioma) async {
    _idioma = Locale(codigoIdioma);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', codigoIdioma);
  }


  /// **Método** que carga las preferencias del idioma desde SharedPreferences.
  ///
  /// Si no se encuentra ninguna preferencia guardada, se establece el idioma por defecto a español.
  ///
  /// *Este método se ejecuta automáticamente cuando se crea la clase*.
  Future<void> cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    _idioma = Locale(prefs.getString('idioma') ?? 'es');
    notifyListeners();
  }
}