import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PantallaCalendario(),
  ));
}

class PantallaCalendario extends StatefulWidget {
  const PantallaCalendario({super.key});

  @override
  _PantallaCalendarioState createState() => _PantallaCalendarioState();
}

class _PantallaCalendarioState extends State<PantallaCalendario> {
  late Map<DateTime, List<String>> _eventos;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _eventos = {
      DateTime.utc(2025, 1, 3): ['Soporte técnico', 'Consultoría'],
      DateTime.utc(2025, 1, 4): ['Reunión general', 'Planificación'],
      DateTime.utc(2025, 1, 10): ['Scrum', 'Proyecto ABC'],
      DateTime.utc(2025, 1, 15): ['Evento especial'],
      DateTime.utc(2025, 1, 20): ['Revisión de proyecto'],
      DateTime.utc(2025, 1, 25): ['Navidad'],
    };
  }

  // Obtener los eventos de un día específico
  List<String> _getEventosDelDia(DateTime date) {
    return _eventos[DateTime.utc(date.year, date.month, date.day)] ?? [];
  }

  void _agregarEvento() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();

        return AlertDialog(
          title: Text("Agregar Evento"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Ingrese el nombre del evento"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_controller.text.isNotEmpty && _selectedDay != null) {
                  setState(() {
                    if (_eventos[_selectedDay] == null) {
                      _eventos[_selectedDay!] = [];
                    }
                    _eventos[_selectedDay!]!.add(_controller.text);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text("Agregar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendario con Eventos"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _agregarEvento,
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            eventLoader: _getEventosDelDia, 
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              // Verificar si hay eventos en la fecha seleccionada
              List<String> eventos = _getEventosDelDia(selectedDay);
              if (eventos.isNotEmpty) {
                print("Eventos del ${selectedDay.toLocal()}:");
                for (var evento in eventos) {
                  print("- $evento");
                }
              }
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              markersAlignment: Alignment.bottomCenter,
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            daysOfWeekHeight: 30,
            startingDayOfWeek: StartingDayOfWeek.monday, // Establecer inicio de semana en lunes
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
