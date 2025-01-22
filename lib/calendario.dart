import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'DAO/citaDAO.dart';
import 'DAO/profesionalDAO.dart';
import 'clases/cita.dart';
import 'clases/especialidad.dart';
import 'clases/profesional.dart';
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
  ProfesionalDAO profesionalDAO = ProfesionalDAO();
  late Map<DateTime, List<Cita>> _citas;
  late DateTime _selectedDate;
  late CalendarFormat _calendarFormat;
  Guardar guardar = Guardar();

  Map<int, Especialidad> especialidades = {};
  Map<int, String> nombresProfesionales = {}; // Mapa para obtener el nombre del profesional.
  Map<DateTime, Color> markerColors = {}; // Mapa para los colores de los días.

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
    final citas = await citaDAO.obtenerCitasUsuario(idUsuario);
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

    // Cargar especialidades y nombres de los profesionales
    await Future.forEach(citas, (cita) async {
      Especialidad? especialidad = await profesionalDAO.obtenerEspecialidadDeProfesional(cita.idProfesional);
      Profesional? profesional = await profesionalDAO.obtenerProfesional(cita.idProfesional);

      if (especialidad != null) {
        setState(() {
          especialidades[cita.idProfesional] = especialidad;
        });
      }

      if (profesional != null) {
        setState(() {
          nombresProfesionales[cita.idProfesional] = profesional.nombreProfesional;
        });
      }
    });

    // Establecer el color para los días con citas
    _setColorsForMarkers();
  }

  // Este método establece los colores de los marcadores
  void _setColorsForMarkers() {
    markerColors.clear(); // Limpiar mapa de colores
    _citas.forEach((fecha, citasDelDia) {
      if (citasDelDia.isNotEmpty) {
        // Se asume que la primera cita de un día determina el color de ese día
        int idProfesional = citasDelDia.first.idProfesional;
        Color color = _getColorDeEspecialidad(idProfesional);
        markerColors[fecha] = color;
        print("pàra la fecha $fecha el color es ${markerColors[fecha].toString()}");
      }
    });
  }

  // Este método devuelve el color de la especialidad asociado a la cita.
  Color _getColorDeEspecialidad(int idProfesional) {
    return Color(int.parse(especialidades[idProfesional]?.color ?? '0xFFFFFFFF'));
  }

  List<Cita> _getEventosDelDia(DateTime date) {
    DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    return _citas[normalizedDate] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });

    List<Cita> _eventos = _citas.entries
        .where((entry) => isSameDay(entry.key, selectedDay))
        .expand((entry) => entry.value)
        .toList();

    if (_eventos.isNotEmpty) {
      for (var evento in _eventos) {
        Navigator.pushNamed(
          context,
          '/ver_cita', // Ruta para la página de detalles
          arguments: evento, // Pasar la cita como argumento
        );
      }
    }
    print(_selectedDate);
    print(markerColors[_selectedDate]);
  }

  @override
  Widget build(BuildContext context) {
    DateTime normalizedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Estilos.fondo,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TableCalendar<Cita>(
                      firstDay: DateTime.utc(2025, 01, 01),
                      lastDay: DateTime.utc(2030, 12, 31),
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
                          color: Estilos.dorado_oscuro,
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 1,
                        // Decoración de los marcadores según el color de la especialidad
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (markerColors[normalizedDate] ?? Colors.pink),
                          border: Border.all(color: Colors.white, width: 2),
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
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      locale: 'es_ES',
                      daysOfWeekHeight: 30,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
