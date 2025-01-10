import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'estilos.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});

  @override
  State<InicioApp> createState() => _InicioApp();
}

class _InicioApp extends State<InicioApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      endDrawer: Drawer(
        child: Container(
          color: Estilos.dorado_oscuro, // Color de fondo del ListView
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding (padding: const EdgeInsets.all(40)),
              GestureDetector(
                onTap: () {
                  // Navega hacia la pantalla de PerfilApp
                  Navigator.pushNamed(context, '/perfil');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Estilos.dorado_claro),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.person, color: Colors.white, size: 30),
                      const Padding(padding: EdgeInsets.only(right: 75)),
                      const Text(
                        'Perfil',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                )
              ),
              Padding (padding: const EdgeInsets.all(60)),
              GestureDetector(
                onTap: () {
                  print("PDF");
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Estilos.dorado_claro),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(FontAwesomeIcons.bookOpen, color: Colors.white),
                      const Padding(padding: EdgeInsets.only(right: 30)),
                      const Text(
                        'Cuadro médico',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Padding (padding: const EdgeInsets.all(60)),
              GestureDetector(
                onTap: () {
                  print("CAMBIO");
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Estilos.dorado_claro),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.light_mode_outlined, color: Colors.white, size: 30),
                      const Padding(padding: EdgeInsets.only(right: 50)),
                      const Text(
                        'Apariencia',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Fila con los dos botones en la parte superior
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye los botones de manera adecuada
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/inicio_sesion');
                    },
                    backgroundColor: Estilos.dorado_oscuro,
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                  // Usa el Builder para obtener el contexto adecuado
                  Builder(
                    builder: (BuildContext context) {
                      return FloatingActionButton(
                        onPressed: () {
                          // Abre el Drawer desde el lado derecho usando el contexto adecuado
                          Scaffold.of(context).openEndDrawer();
                        },
                        backgroundColor: Estilos.dorado_oscuro,
                        child: const Icon(FontAwesomeIcons.bars, color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            // Espacio flexible para centrar el texto y separar los botones
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/ver_cita');
                },
                child: Container(
                  color: Colors.white, // Aquí asignamos el color al contenedor
                  padding: const EdgeInsets.all(20),
                  child: const Center(
                    child: Text(
                      'INICIO',
                      textAlign: TextAlign.center,
                      style: Estilos.texto,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}