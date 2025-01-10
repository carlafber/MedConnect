import 'package:flutter/material.dart';
import 'estilos.dart';


class CalendarioApp extends StatefulWidget {
  const CalendarioApp({super.key});

  @override
  State<CalendarioApp> createState() => _CalendarioApp();
}

class _CalendarioApp extends State<CalendarioApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding (
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/ver_cita');
                },
                child: Container(
                  color: Colors.white,  // Aquí asignamos el color al contenedor
                  padding: const EdgeInsets.all(20),
                  child: const Center(
                    child: Text(
                      'CALENDARIO',
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

/*
https://help.syncfusion.com/flutter/calendar/month-view

https://youtu.be/6Gxa-v7Zh7I?si=4gzsAXRkfT-QRDS1
https://www.syncfusion.com/blogs/post/introducing-the-calendar-widget-for-flutter/amp
https://pub.dev/packages/table_calendar
https://www.javatpoint.com/flutter-calendar
*/