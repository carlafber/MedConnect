import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/especialidad_model.dart';
import 'model/profesional_model.dart';
import 'estilos.dart';
import 'viewmodel/CRUD/cita_viewmodel.dart';
import 'viewmodel/CRUD/profesional_viewmodel.dart';
import 'model/cita_model.dart';
import 'viewmodel/provider_usuario_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EstadisticasApp extends StatefulWidget {
  const EstadisticasApp({super.key});

  @override
  State<EstadisticasApp> createState() => _EstadisticasApp();
}

class _EstadisticasApp extends State<EstadisticasApp> {
  ProfesionalCRUD profesionalCRUD = ProfesionalCRUD();
  CitaCRUD citaCRUD = CitaCRUD();

  List<Cita> citas = [];
  Map<int, Especialidad> especialidades = {};
  Map<int, String> nombresProfesionales = {};

  @override
  void initState() {
    super.initState();
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    if (usuario != null) {
      _cargarCitas(usuario.idUsuario as int);
    }
  }

  // Función para cargar las citas y asociarlas con las especialidades
  Future<void> _cargarCitas(int idUsuario) async {
    List<Cita> lista = await citaCRUD.obtenerCitasUsuario(idUsuario);
    setState(() {
      citas = lista;
    });

    // Cargar especialidades para cada profesional
    await Future.forEach(citas, (cita) async {
      Especialidad? especialidad = await profesionalCRUD.obtenerEspecialidadDeProfesional(cita.idProfesional);
      Profesional? profesional = await profesionalCRUD.obtenerProfesional(cita.idProfesional);
      
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
      String especialidad = especialidades[cita.idProfesional]?.nombreEspecialidad ?? AppLocalizations.of(context)!.textoDesconocida; // Usar la traducción
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
      double percentaje = (entry.value / totalCitas) * 100;

      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: "${percentaje.toStringAsFixed(1)}%", // Mostrar el porcentaje
        radius: 200, // Tamaño del gráfico
        color: Color(int.parse(colorHex)).withOpacity(0.5), // Hacer el color sea opaco
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.tituloEstadisticas, style: Estilos.titulo2), // Usar la traducción
            const Padding(padding: EdgeInsets.all(10)),
            // Contenedor con el gráfico y la leyenda
            Expanded(
              child: Container(
                color: Estilos.fondo,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
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
            ),
          ],
        ),
      ),
    );
  }
}