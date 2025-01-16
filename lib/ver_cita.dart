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
            Text("DETALLES DE LA CITA", style: Estilos.titulo2),
            const Padding(padding: EdgeInsets.all(10)),
            Expanded(//DETALLES
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Estilos.fondo),
                padding: const EdgeInsets.all(10),
                child: Text(
                  '\nFecha: ${cita.fecha}\nHora: ${cita.hora}',
                  textAlign: TextAlign.center,
                  style: Estilos.texto,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            Align(
              alignment: Alignment.bottomCenter, // Alinea el botón en parte inferior
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("Actualizar");
                      },
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Estilos.dorado_claro, 
                          borderRadius: BorderRadius.circular(15)
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Text(
                          'Actualizar',
                          textAlign: TextAlign.center,
                          style: Estilos.texto3,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("Eliminar");
                      },
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Estilos.dorado_claro,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Text(
                          'Eliminar',
                          textAlign: TextAlign.center,
                          style: Estilos.texto3,
                        ),
                      ),
                    ),
                 ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}