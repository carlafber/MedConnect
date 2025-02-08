import 'package:flutter/material.dart';

/// **Clase estática que define los estilos de texto y colores del proyecto.**
///
/// Contiene constantes de tipo `TextStyle` y `Color` que se utilizan en la interfaz
/// para mantener una apariencia uniforme en toda la aplicación.
class Estilos {
  /// Estilo para títulos principales.
  static const TextStyle titulo = TextStyle(
    color: Estilos.dorado_claro,
    fontSize: 50,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
  /// Estilo para títulos secundarios con sombra.
  static const TextStyle titulo2 = TextStyle(
    color: Color.fromARGB(255, 244, 216, 146),
    fontSize: 30,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        // Desplazamiento de la sombra
        offset: Offset(3.0, 3.0),
        // Difusión de la sombra
        blurRadius: 5.0,
        // Color de la sombra
        color: Estilos.dorado_oscuro_sombra,
      ),
    ],
  );
  /// Estilo para texto normal en color negro.
  static const TextStyle texto = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Roboto',
  );
  /// Estilo para texto en color blanco, tamaño más grande.
  static const TextStyle texto2 = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontFamily: 'Roboto',
  );
  /// Estilo para texto en color blanco, tamaño mediano.
  static const TextStyle texto3 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Roboto',
  );
  /// Estilo para texto en color `dorado_oscuro` con negrita.
  static const TextStyle texto4 = TextStyle(
    color: Estilos.dorado_oscuro,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
  /// Estilo para texto negro en negrita.
  static const TextStyle texto5 = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
  /// Estilo para texto negro de menor tamaño.
  static const TextStyle texto6 = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Roboto',
  );
  /// Estilo para texto negro en negrita con tamaño grande.
  static const TextStyle texto7 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
  /// Paleta de colores de la aplicación.
  static const Color dorado = Color.fromARGB(255, 185, 144, 40);
  static const Color dorado_oscuro = Color.fromARGB(255, 157, 118, 18);
  static const Color dorado_claro = Color.fromARGB(255, 219, 187, 106);
  static const Color dorado_oscuro_sombra = Color.fromARGB(255, 135, 100, 9);
  static const Color fondo = Color.fromARGB(255, 252, 242, 215);
}