import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/provider_idioma.dart';
import 'inicio_sesion.dart';
import 'main_bnb.dart';
import 'ver_cita.dart';
import 'perfil.dart';
import 'services/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  //await DBHelper().eliminarBD();

  await DBHelper().abrirBD();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderIdioma(),
        )
      ],
      child: const MainApp(),
    )
  );
} 

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}


class _MainAppState extends State<MainApp> {
 @override
  Widget build(BuildContext context) {
    return Consumer<ProviderIdioma>(
      builder: (context, providerIdioma, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/inicio_sesion', // Establece la ruta inicial
          routes: {
            '/inicio_sesion': (context) => const InicioSesionApp(),
            '/main_bnb': (context) => const MainBnBApp(),
            '/ver_cita': (context) => const VerCitaApp(),
            '/perfil': (context) => const PerfilApp(),
          },
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: providerIdioma.idioma,
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
          ],
        );
      },
    );
  }
}
