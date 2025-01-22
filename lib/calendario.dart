import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'DAO/citaDAO.dart';
import 'clases/cita.dart';
import 'clases/usuario.dart';
import 'estilos.dart';
import 'guardar.dart';

class CalendarioApp extends StatefulWidget {
  const CalendarioApp({super.key});

  @override
  State<CalendarioApp> createState() => _CalendarioApp();
}

class _CalendarioApp extends State<CalendarioApp> {
  final CitaDAO citaDAO = CitaDAO();
  late Map<DateTime, List<Cita>> _citas; // Mapa de citas por fecha
  late DateTime _selectedDate; // Fecha seleccionada
  late CalendarFormat _calendarFormat;
  Guardar guardar = Guardar();

  @override
  void initState() {
    super.initState();
    Usuario? usuario = guardar.get();
    _calendarFormat = CalendarFormat.month; // Formato de calendario por defecto
    _citas = {}; // Mapa de citas vacío
    _selectedDate = DateTime.now(); // Fecha seleccionada por defecto
    if (usuario != null) {
      _cargarCitas(usuario.idUsuario as int);
    } // Cargar las citas desde la base de datos
  }

  // Cargar las citas desde la base de datos
  Future<void> _cargarCitas(int idUsuario) async {
    final citas = await citaDAO.obtenerCitasUsuario(idUsuario); // Obtener todas las citas de la base de datos
    print("Citas obtenidas: $citas"); // Depuración para verificar las citas obtenidas
    setState(() {
      _citas = {}; // Limpiar el mapa
      for (var cita in citas) {
        DateTime fechaCita = DateFormat('yyyy-MM-dd').parse(cita.fecha);
        // Asegurémonos de que solo se utilice la fecha, sin horas ni minutos.
        fechaCita = DateTime(fechaCita.year, fechaCita.month, fechaCita.day); 
        print("Cita cargada: ${cita.fecha} -> $fechaCita"); // Depuración para verificar cómo se están convirtiendo las fechas
        if (!_citas.containsKey(fechaCita)) {
          _citas[fechaCita] = [];
        }
        _citas[fechaCita]?.add(cita);
      }
    });
  }

  // Mostrar el evento cuando se seleccione un día
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Aquí está el contenedor donde se muestra el calendario
            Expanded(
              child: GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, '/ver_cita');
                },
                child: Container(
                  color: Estilos.fondo,  // Aquí asignamos el color al contenedor
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TableCalendar<Cita>(
                        firstDay: DateTime.utc(2025, 01, 01), // Primer día de la semana (lunes)
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _selectedDate,
                        selectedDayPredicate: (day) {
                          return isSameDay(day, _selectedDate);
                        },
                        onDaySelected: _onDaySelected,
                        calendarFormat: _calendarFormat,
                        eventLoader: (day) {
                          // Asegurémonos de que el eventLoader está cargando las citas correctas
                          print("Cargando eventos para: $day"); // Depuración para verificar qué días se están cargando
                          print(_citas);
                          return _citas[day] ?? [];  // Devuelve las citas de ese día
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Estilos.dorado_claro,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Estilos.dorado_oscuro,
                            shape: BoxShape.circle,
                          ),
                          markersMaxCount: 1, // Limitar a 1 marcador por día
                          markerDecoration: BoxDecoration(
                            color: Colors.red, // Color del punto en el día
                            shape: BoxShape.circle,
                            // Aumentar el tamaño del punto
                            border: Border.all(
                              color: Colors.white,  // Bordes blancos para resaltar el marcador
                              width: 2,
                            ),
                            // Ajusta el tamaño para que sea más grande
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false, // Eliminar el botón "2 weeks"
                          formatButtonTextStyle: TextStyle().copyWith(color: Estilos.dorado),
                          formatButtonDecoration: BoxDecoration(
                            color: Estilos.dorado_oscuro,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          titleCentered: true,
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            color: Estilos.dorado_oscuro,
                            fontWeight: FontWeight.bold,
                          ),
                          weekendStyle: TextStyle(
                            color: Estilos.dorado_oscuro,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        locale: 'es_ES', // Establecer el calendario en español
                        daysOfWeekHeight: 30,
                        startingDayOfWeek: StartingDayOfWeek.monday, // Establecer inicio de semana en lunes
                      ),
                      const SizedBox(height: 20),
                      if (_citas[_selectedDate] != null && _citas[_selectedDate]!.isNotEmpty)
                        Text(
                          "Citas para ${DateFormat('yyyy-MM-dd').format(_selectedDate)}:",
                          style: Estilos.texto,
                        ),
                      if (_citas[_selectedDate] != null && _citas[_selectedDate]!.isNotEmpty)
                        ..._citas[_selectedDate]!.map((cita) {
                          return ListTile(
                            title: Text(
                              'Hora: ${cita.hora}',
                              style: Estilos.texto,
                            ),
                            subtitle: Text(
                              'Profesional: ${cita.idProfesional}', // O cualquier dato que desees mostrar
                              style: Estilos.texto,
                            ),
                            onTap: () {
                              // Navegar a la página de ver cita cuando se toca un ítem de la lista
                              //Navigator.pushNamed(context, '/ver_cita', arguments: cita);
                            },
                          );
                        }).toList(),
                    ],
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


/*import 'package:flutter/material.dart';
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
                  color: Estilos.fondo,  // Aquí asignamos el color al contenedor
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


https://help.syncfusion.com/flutter/calendar/month-view

https://youtu.be/6Gxa-v7Zh7I?si=4gzsAXRkfT-QRDS1
https://www.syncfusion.com/blogs/post/introducing-the-calendar-widget-for-flutter/amp
https://pub.dev/packages/table_calendar
https://www.javatpoint.com/flutter-calendar
*/
