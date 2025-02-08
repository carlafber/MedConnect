import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/model/cita_model.dart';
import '/model/usuario_model.dart';
import '/viewmodel/CRUD/cita_viewmodel.dart';
import '/viewmodel/estilos_viewmodel.dart';
import '/viewmodel/guardar_usuario_viewmodel.dart';

class CalendarioApp extends StatefulWidget {
  const CalendarioApp({super.key});

  @override
  State<CalendarioApp> createState() => Calendario();
}

class Calendario extends State<CalendarioApp> {
  final CitaCRUD citaCRUD = CitaCRUD();
  late Map<DateTime, List<Cita>> _citas;
  late DateTime _selectedDate;
  late CalendarFormat _calendarFormat;
  Guardar guardar = Guardar();

  @override
  void initState() {
    super.initState();
    Usuario? usuario = guardar.get();
    _calendarFormat = CalendarFormat.month;
    _citas = {};
    _selectedDate = DateTime.now();
    if (usuario != null) {
      _cargarCitas(usuario.idUsuario as int);
    }
  }

  Future<void> _cargarCitas(int idUsuario) async {
    final citas = await citaCRUD.obtenerCitasUsuario(idUsuario);
    setState(() {
      _citas = {};
      for (var cita in citas) {
        DateTime fechaCita = DateFormat('yyyy-MM-dd').parse(cita.fecha);
        fechaCita = DateTime(fechaCita.year, fechaCita.month, fechaCita.day);
        if (!_citas.containsKey(fechaCita)) {
          _citas[fechaCita] = [];
        }
        _citas[fechaCita]?.add(cita);
      }
    });
  }

  List<Cita> _getEventosDelDia(DateTime date) {
    DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    return _citas[normalizedDate] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });

    List<Cita> eventos = _citas.entries
      .where((entry) => isSameDay(entry.key, selectedDay))
      .expand((entry) => entry.value)
      .toList();


    if (eventos.isNotEmpty) {
      for (var evento in eventos) {
        Navigator.pushNamed(
          context, 
          '/ver_cita', // Ruta para la página de detalles
          arguments: evento, // Pasar la cita como argumento
        );
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.tituloCalendario, style: Estilos.titulo2), // Usar la traducción
            const Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Estilos.fondo,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TableCalendar<Cita>(
                      firstDay: DateTime.utc(2020, 01, 01),
                      lastDay: DateTime.utc(2027, 12, 31),
                      focusedDay: _selectedDate,
                      selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
                      onDaySelected: _onDaySelected,
                      calendarFormat: _calendarFormat,
                      eventLoader: _getEventosDelDia,
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Estilos.dorado_claro,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Estilos.dorado,
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 1,
                        markerDecoration: BoxDecoration(
                          color:  Estilos.dorado_oscuro,
                          //shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: Estilos.texto7
                      ),
                      locale: 'es_ES',
                      daysOfWeekHeight: 30,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
