import 'package:flutter/material.dart';
import 'estilos.dart';

class PerfilApp extends StatefulWidget {
  const PerfilApp({super.key});

  @override
  State<PerfilApp> createState() => _PerfilApp();
}

class _PerfilApp extends State<PerfilApp> {
  @override
  Widget build(BuildContext context) {
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
                    print("Volver");
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
                  'DETALLES DEL PERFIL',
                  textAlign: TextAlign.center,
                  style: Estilos.texto,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}