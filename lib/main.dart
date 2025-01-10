import 'package:flutter/material.dart';
import 'inicio_sesion.dart';
import 'main_bnb.dart';
import 'ver_cita.dart';
import 'perfil.dart';


void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}


class _MainAppState extends State<MainApp> {
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/inicio_sesion', // Establece la ruta inicial
      routes: {
        '/inicio_sesion': (context) => const InicioSesionApp(),
        '/main_bnb': (context) => const MainBnBApp(),
        '/ver_cita': (context) => const VerCitaApp(),
        '/perfil': (context) => const PerfilApp(), //MENÚ
      },
    );
  }
}