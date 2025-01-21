import 'package:flutter/material.dart';

// Clase para estilos de texto reutilizables
class Estilos {
  static const TextStyle titulo = TextStyle(
    color: Estilos.dorado_claro,
    fontSize: 50,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titulo2 = TextStyle(
    color: Color.fromARGB(255, 244, 216, 146),
    fontSize: 30,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        offset: Offset(3.0, 3.0), // Desplazamiento de la sombra
        blurRadius: 5.0, // Difusión de la sombra
        color: Estilos.dorado_oscuro_sombra, // Color de la sombra
      ),
    ],
  );
  static const TextStyle texto = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Roboto',
  );
  static const TextStyle texto2 = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontFamily: 'Roboto',
  );
  static const TextStyle texto3 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Roboto',
  );
  static const TextStyle texto4 = TextStyle(
    color: Estilos.dorado_oscuro,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle texto5 = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
  static const Color dorado = Color.fromARGB(255, 185, 144, 40);
  static const Color dorado_oscuro = Color.fromARGB(255, 157, 118, 18);
  static const Color dorado_claro = Color.fromARGB(255, 219, 187, 106);
  static const Color dorado_oscuro_sombra = Color.fromARGB(255, 135, 100, 9);
  static const Color fondo = Color.fromARGB(255, 252, 242, 215);
  
}