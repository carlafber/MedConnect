import 'package:flutter/material.dart';

// Clase para estilos de texto reutilizables
class Estilos {
  static const TextStyle titulo = TextStyle(
    color: Estilos.dorado_claro,
    fontSize: 50,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
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
  static const Color dorado = Color.fromARGB(255, 185, 144, 40);
  static const Color dorado_oscuro = Color.fromARGB(255, 157, 118, 18);
  static const Color dorado_claro = Color.fromARGB(255, 219, 187, 106);
}