import 'package:flutter/material.dart';
import 'clases/especialidad.dart';
import 'clases/profesional.dart';
import 'clases/usuario.dart';
import 'estilos.dart';
import 'DAO/citaDAO.dart';
import 'DAO/profesionalDAO.dart';
import 'clases/cita.dart';
import 'guardar.dart';
import 'package:fl_chart/fl_chart.dart';

class EstadisticasApp extends StatefulWidget {
  const EstadisticasApp({super.key});

  @override
  State<EstadisticasApp> createState() => _EstadisticasApp();
}

class _EstadisticasApp extends State<EstadisticasApp> {
  ProfesionalDAO profesionalDAO = ProfesionalDAO();
  CitaDAO citaDAO = CitaDAO();
  Guardar guardar = Guardar();

  List<Cita> citas = [];
  Map<int, Especialidad> especialidades = {};
  Map<int, String> nombresProfesionales = {};

  @override
  void initState() {
    super.initState();
    Usuario? usuario = guardar.get();
    if (usuario != null) {
      _cargarCitas(usuario.idUsuario as int);
    }
  }

  // Función para cargar las citas y asociarlas con las especialidades
  Future<void> _cargarCitas(int idUsuario) async {
    List<Cita> lista = await citaDAO.obtenerCitasUsuario(idUsuario);
    setState(() {
      citas = lista;
    });

    // Cargar especialidades para cada profesional
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
  }

  // Función para obtener las secciones del gráfico
  List<PieChartSectionData> _getPieChartSections() {
    Map<String, int> especialidadesCount = {};

    // Contar la cantidad de citas por especialidad
    for (var cita in citas) {
      String especialidad = especialidades[cita.idProfesional]?.nombreEspecialidad ?? 'Desconocida';
      if (especialidadesCount.containsKey(especialidad)) {
        especialidadesCount[especialidad] = especialidadesCount[especialidad]! + 1;
      } else {
        especialidadesCount[especialidad] = 1;
      }
    }

    // Calcular el total de citas para los porcentajes
    int totalCitas = citas.length;

    // Convertir el conteo de especialidades a una lista de PieChartSectionData con porcentaje
    return especialidadesCount.entries.map((entry) {
      String colorHex = especialidades.entries.firstWhere((element) => element.value.nombreEspecialidad == entry.key).value.color;
      double percentage = (entry.value / totalCitas) * 100; // Calcular el porcentaje

      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: "${percentage.toStringAsFixed(1)}%", // Solo mostrar el porcentaje
        radius: 200, // Aumentar el radio para hacer el gráfico más grande
        color: Color(int.parse(colorHex)).withOpacity(0.5), // Asegurarse de que el color sea opaco
        titleStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  // Función para obtener la leyenda con colores y nombres de especialidades en un Row
  Widget _buildLegend() {
    // Crear un mapa con especialidades y colores
    Map<String, Color> especialidadesColores = {};

    // Obtener los colores de cada especialidad
    especialidades.forEach((idProfesional, especialidad) {
      especialidadesColores[especialidad.nombreEspecialidad] = Color(int.parse(especialidad.color)).withOpacity(0.5);
    });

    // Ordenar las especialidades por nombre de manera alfabética
    List<String> sortedEspecialidades = especialidadesColores.keys.toList()..sort();

    // Crear una lista de widgets para la leyenda en un Row
    List<Widget> legendItems = sortedEspecialidades.map((especialidad) {
      return Row(
        children: [
          Container(
            width: 20,
            height: 20,
            color: especialidadesColores[especialidad], // El color de la especialidad
          ),
          const SizedBox(width: 10),
          Text(especialidad), // El nombre de la especialidad
          const SizedBox(width: 20), // Espacio entre los elementos de la leyenda
        ],
      );
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Hacer que la leyenda sea desplazable horizontalmente
      child: Row(
        children: legendItems,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar los elementos verticalmente
          crossAxisAlignment: CrossAxisAlignment.center, // Centrar los elementos horizontalmente
          children: [
            // Título centrado
            Text("ESTADÍSTICAS", style: Estilos.titulo2),

            const Padding(padding: EdgeInsets.all(10)),

            // Contenedor blanco que incluye tanto el gráfico como la leyenda
            Expanded(
              child: Container(
                color: Estilos.fondo, // Establecer el color de fondo del contenedor como blanco
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // PieChart más grande
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: PieChart(
                          PieChartData(
                            sections: _getPieChartSections(),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0, // El espacio entre las secciones
                            centerSpaceRadius: 0, // El espacio en el centro del gráfico
                          ),
                        ),
                      ),
                    ),

                    // Leyenda dentro del contenedor blanco
                    const SizedBox(height: 20),
                    _buildLegend(), // Mostrar leyenda con colores y especialidades
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
/*import 'package:flutter/material.dart';
import 'clases/especialidad.dart';
import 'clases/profesional.dart';
import 'clases/usuario.dart';
import 'estilos.dart';
import 'DAO/citaDAO.dart';
import 'DAO/profesionalDAO.dart';
import 'clases/cita.dart';
import 'guardar.dart';
import 'package:fl_chart/fl_chart.dart';

class EstadisticasApp extends StatefulWidget {
  const EstadisticasApp({super.key});

  @override
  State<EstadisticasApp> createState() => _EstadisticasApp();
}

class _EstadisticasApp extends State<EstadisticasApp> {
  ProfesionalDAO profesionalDAO = ProfesionalDAO();
  CitaDAO citaDAO = CitaDAO();
  Guardar guardar = Guardar();

  List<Cita> citas = [];
  Map<int, Especialidad> especialidades = {};
  Map<int, String> nombresProfesionales = {};

  @override
  void initState() {
    super.initState();
    Usuario? usuario = guardar.get();
    if (usuario != null) {
      _cargarCitas(usuario.idUsuario as int);
    }
  }

  // Función para cargar las citas y asociarlas con las especialidades
  Future<void> _cargarCitas(int idUsuario) async {
    List<Cita> lista = await citaDAO.obtenerCitasUsuario(idUsuario);
    setState(() {
      citas = lista;
    });

    // Cargar especialidades para cada profesional
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
  }

  // Función para obtener las secciones del gráfico circular
  List<PieChartSectionData> _getPieChartSections() {
    Map<String, int> especialidadesCount = {};

    // Contar la cantidad de citas por especialidad
    for (var cita in citas) {
      String especialidad = especialidades[cita.idProfesional]?.nombreEspecialidad ?? 'Desconocida';
      if (especialidadesCount.containsKey(especialidad)) {
        especialidadesCount[especialidad] = especialidadesCount[especialidad]! + 1;
      } else {
        especialidadesCount[especialidad] = 1;
      }
    }

    // Calcular el total de citas para los porcentajes
    int totalCitas = citas.length;

    // Convertir el conteo de especialidades a una lista de PieChartSectionData con porcentaje
    return especialidadesCount.entries.map((entry) {
      String colorHex = especialidades.entries.firstWhere((element) => element.value.nombreEspecialidad == entry.key).value.color;
      double percentage = (entry.value / totalCitas) * 100; // Calcular el porcentaje

      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: "${percentage.toStringAsFixed(1)}%", // Solo mostrar el porcentaje
        radius: 200, // Aumentar el radio para hacer el gráfico más grande
        color: Color(int.parse(colorHex)).withOpacity(0.5), // Asegurarse de que el color sea opaco
        titleStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  // Función para obtener las citas por mes
  List<BarChartGroupData> _getBarChartData() {
    Map<String, int> citasPorMes = {};

    // Contar la cantidad de citas por mes
    for (var cita in citas) {
      DateTime fecha = DateTime.parse(cita.fecha);  // Convertir la fecha a DateTime
      String mes = fecha.month.toString(); // Obtener el mes de la cita
      if (citasPorMes.containsKey(mes)) {
        citasPorMes[mes] = citasPorMes[mes]! + 1;
      } else {
        citasPorMes[mes] = 1;
      }
    }

    // Crear los datos para el gráfico de barras
    return citasPorMes.entries.map((entry) {
      return BarChartGroupData(
        x: int.parse(entry.key) - 1, // El valor de X corresponde al mes (0-11)
        barRods: [
          BarChartRodData(
            fromY: 0, // Asegúrate de que la barra comience desde Y=0
            toY: entry.value.toDouble(), // La altura de la barra
            color: Colors.blue, // El color de las barras
            width: 16, // El ancho de las barras
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    }).toList();
  }

  // Función para obtener la leyenda con colores y nombres de especialidades en un Row
  Widget _buildLegend() {
    Map<String, Color> especialidadesColores = {};

    // Obtener los colores de cada especialidad
    especialidades.forEach((idProfesional, especialidad) {
      especialidadesColores[especialidad.nombreEspecialidad] = Color(int.parse(especialidad.color)).withOpacity(0.5);
    });

    // Crear una lista de widgets para la leyenda en un Row
    List<Widget> legendItems = especialidadesColores.entries.map((entry) {
      return Row(
        children: [
          Container(
            width: 20,
            height: 20,
            color: entry.value, // El color de la especialidad
          ),
          const SizedBox(width: 10),
          Text(entry.key), // El nombre de la especialidad
          const SizedBox(width: 20), // Espacio entre los elementos de la leyenda
        ],
      );
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Hacer que la leyenda sea desplazable horizontalmente
      child: Row(
        children: legendItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar los elementos verticalmente
          crossAxisAlignment: CrossAxisAlignment.center, // Centrar los elementos horizontalmente
          children: [
            // Título centrado
            Text("ESTADÍSTICAS", style: Estilos.titulo2),

            const Padding(padding: EdgeInsets.all(10)),

            // Contenedor blanco que incluye tanto el gráfico de barras como el gráfico circular
            Expanded(
              child: Container(
                color: Estilos.fondo, // Establecer el color de fondo del contenedor como blanco
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Columna con el gráfico de barras
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          // BarChart para mostrar citas por mes
                          Expanded(
                            child: BarChart(
                              BarChartData(
                                barGroups: _getBarChartData(),
                                borderData: FlBorderData(show: false),
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(
                                    axisNameWidget: Text('Meses'),
                                    sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return Text('Ene');
                                        case 1:
                                          return Text('Feb');
                                        case 2:
                                          return Text('Mar');
                                        case 3:
                                          return Text('Abr');
                                        case 4:
                                          return Text('May');
                                        case 5:
                                          return Text('Jun');
                                        case 6:
                                          return Text('Jul');
                                        case 7:
                                          return Text('Ago');
                                        case 8:
                                          return Text('Sep');
                                        case 9:
                                          return Text('Oct');
                                        case 10:
                                          return Text('Nov');
                                        case 11:
                                          return Text('Dic');
                                        default:
                                          return const Text('');
                                      }
                                    }),
                                  ),
                                  leftTitles: AxisTitles(
                                    axisNameWidget: Text('Cantidad'),
                                    sideTitles: SideTitles(showTitles: true),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Espacio entre los gráficos
                    const Padding(padding: EdgeInsets.all(10)),

                    // Columna con el gráfico circular
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          // PieChart
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: PieChart(
                                PieChartData(
                                  sections: _getPieChartSections(),
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 0, // El espacio entre las secciones
                                  centerSpaceRadius: 0, // El espacio en el centro del gráfico
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          _buildLegend(), // Mostrar leyenda con colores y especialidades
                        ],
                      ),
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
*/