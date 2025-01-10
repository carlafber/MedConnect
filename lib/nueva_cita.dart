import 'package:flutter/material.dart';
import 'estilos.dart';

/*
DATOS CITA
  - especialidad
  - profesional
  - centro
  - fecha
  - hora
*/


class NuevaCitaApp extends StatefulWidget {
  const NuevaCitaApp({super.key});

  @override
  State<NuevaCitaApp> createState() => _NuevaCitaApp();
}

class _NuevaCitaApp extends State<NuevaCitaApp> {//cargar los datos de la bd
  final List<String> especialidades = ['Cardiología', 'Psiquiatría', 'Pediatría', 'Dermatología', 'Oftalmología', 'Traumatología'];
  String? especialidadSeleccionada;

  //coger solo los profesionales de la especialidad seleccionada
  final List<String> profesionales = ['Dr. Luis Martínez', 'Dra. Ana Sánchez', 'Dr. Pedro Díaz', 'Dra. Isabel Pérez', 'Dr. Juan Fernández', 'Dr. Marcos López', 'Dra. Clara Rodríguez', 'Dr. Felipe Pérez', 'Dra. Marta Jiménez', 'Dr. Alberto Torres', 'Dr. Raúl González', 'Dra. Sofía Fernández'];
  String? profesionalSeleccionado;

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
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'DATOS DE LA NUEVA CITA',
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


/*
https://mundanecode.com/posts/how-to-use-datepicker-in-flutter/
https://lohanidamodar.medium.com/date-and-time-pickers-in-flutter-without-using-any-packages-1de04a13938c
*/