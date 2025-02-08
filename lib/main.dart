import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'services/db_helper.dart';
import 'view/inicio_sesion_view.dart';
import 'view/main_bnb_view.dart';
import 'view/ver_cita_view.dart';
import 'view/perfil_view.dart';
import 'viewmodel/provider_idioma_viewmodel.dart';


/// Entrada a la aplicación.
///
/// Esta función es la primera que se ejecuta al iniciar la aplicación.
/// Configura la base de datos y el entorno de localización antes de ejecutar el widget principal de la aplicación.
void main() async {
  // Asegura que se inicialicen las conexiones y configuraciones antes de ejecutar el widget
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa la base de datos
  sqfliteFfiInit();

  // Configura la base de datos según la plataforma
  if(Platform.isWindows || Platform.isMacOS){
    databaseFactory = databaseFactoryFfi;
  } else {
    databaseFactory = databaseFactory;
  }
  // Por si fuera necesario eliminar la base de datos:
  // await DBHelper().eliminarBD();

  // Abre la base de datos
  await DBHelper().abrirBD();

  // Ejecuta la aplicación principal
  runApp(
    MultiProvider(
      providers: [
        // Proveedor que maneja el idioma de la aplicación
        ChangeNotifierProvider(
          create: (context) => ProviderIdioma(),
        )
      ],
      child: const MainApp(),
    )
  );
}


/// **Widget principal de la aplicación.**
///
/// Este widget contiene la estructura básica de la aplicación y maneja la navegación entre pantallas,
/// así como la configuración del idioma mediante un proveedor para obtener el idioma seleccionado.
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}


class MainAppState extends State<MainApp> {
 @override
  Widget build(BuildContext context) {
    return Consumer<ProviderIdioma>(
      builder: (context, providerIdioma, child) {
        return MaterialApp(
          // Desactiva el banner de debug en la aplicación
          debugShowCheckedModeBanner: false,
          // Establece la ruta inicial
          initialRoute: '/inicio_sesion',
          // Define las rutas de navegación
          routes: {
            '/inicio_sesion': (context) => const InicioSesionApp(),
            '/main_bnb': (context) => const MainBnBApp(),
            '/ver_cita': (context) => const VerCitaApp(),
            '/perfil': (context) => const PerfilApp(),
          },
          // Delegados de localización para gestionar el idioma
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // Idioma actual que se obtiene del proveedor
          locale: providerIdioma.idioma,
          // Idiomas soportados por la aplicación
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
          ],
        );
      },
    );
  }
}