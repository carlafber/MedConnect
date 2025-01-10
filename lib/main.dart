import 'package:flutter/material.dart';
import 'inicio_sesion.dart';
import 'main_bnb.dart';
import 'ver_cita.dart';
import 'perfil.dart';
import 'db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  //await DBHelper().eliminarBD();

  await DBHelper().abrirBD();
    
  runApp(const MainApp());

} 

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
        '/perfil': (context) => const PerfilApp(),
      },
    );
  }
}