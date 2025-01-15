import 'package:flutter/material.dart';
import 'clases/cita.dart';
import 'estilos.dart';

class VerCitaApp extends StatefulWidget {
  const VerCitaApp({super.key});

  @override
  State<VerCitaApp> createState() => _VerCitaApp();
}

class _VerCitaApp extends State<VerCitaApp> {
  @override
  Widget build(BuildContext context) {
    final Cita cita = ModalRoute.of(context)!.settings.arguments as Cita;
    
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding (
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Estilos.dorado_oscuro,
                  child: const Icon(Icons.arrow_back, color: Colors.white)
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'DETALLES DE LA CITA',
                  textAlign: TextAlign.center,
                  style: Estilos.texto,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            Align(
              alignment: Alignment.bottomCenter, // Alinea el botón en parte inferior
              child: GestureDetector(
                onTap: () {
                  print("Actualizar");
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Estilos.dorado_claro),
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Actualizar',
                    textAlign: TextAlign.center,
                    style: Estilos.texto2,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            Align(
              alignment: Alignment.bottomCenter, // Alinea el botón en la parte inferior
              child: GestureDetector(
                onTap: () {
                  print("Eliminar");
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Estilos.dorado_claro),
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Eliminar',
                    textAlign: TextAlign.center,
                    style: Estilos.texto2,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(20))
          ],
        ),
      ),
    );
  }
}