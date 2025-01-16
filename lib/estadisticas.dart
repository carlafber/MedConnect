import 'package:flutter/material.dart';
import 'estilos.dart';

class EstadisticasApp extends StatefulWidget {
  const EstadisticasApp({super.key});

  @override
  State<EstadisticasApp> createState() => _EstadisticasApp();
}

class _EstadisticasApp extends State<EstadisticasApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding (
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Estilos.fondo),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'ESTADÍSTICAS',
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