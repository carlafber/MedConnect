import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'clases/especialidad.dart';
import 'clases/profesional.dart';
import 'DAO/citaDAO.dart';
import 'DAO/profesionalDAO.dart';
import 'clases/cita.dart';
import 'clases/usuario.dart';
import 'estilos.dart';
import 'guardar.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});

  @override
  State<InicioApp> createState() => _InicioApp();
}

class _InicioApp extends State<InicioApp> {
  ProfesionalDAO profesionalDAO = ProfesionalDAO();
  CitaDAO citaDAO = CitaDAO();
  Guardar guardar = Guardar();

  List<Cita> citas = [];
  Map<int, Especialidad> especialidades = {};
  Map<int, String> nombresProfesionales = {};
  String color = "";

  @override
  void initState() {
    super.initState();
    Usuario? usuario = guardar.get();
    if (usuario != null) {
      _cargarCitas(usuario.idUsuario as int);
    }
  }

  Future<void> _cargarCitas(int idUsuario) async {
    List<Cita> lista = await citaDAO.obtenerCitasUsuario(idUsuario);
    setState(() {
      citas = lista;
    });

    // Ordenar las citas por fecha
    citas.sort((a, b) {
      DateTime fechaA = DateTime.parse(a.fecha); // Convertir la fecha de la cita 'a' a DateTime
      DateTime fechaB = DateTime.parse(b.fecha); // Convertir la fecha de la cita 'b' a DateTime
      return fechaA.compareTo(fechaB); // Ordenar de más antiguo a más reciente
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      endDrawer: Drawer(
        child: Container(
          color: Estilos.dorado_oscuro,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding (padding: const EdgeInsets.all(40)),
              GestureDetector(
                onTap: () {
                  // Navega hacia la pantalla de perfil
                  Navigator.pushNamed(context, '/perfil');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Estilos.dorado_claro),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.person, color: Colors.white, size: 30),
                      const Padding(padding: EdgeInsets.only(right: 75)),
                      const Text(
                        'Perfil',
                        style: Estilos.texto3,
                      ),
                    ],
                  ),
                )
              ),
              Padding (padding: const EdgeInsets.all(60)),
              GestureDetector(
                onTap: () {
                  print("PDF");
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Estilos.dorado_claro),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(FontAwesomeIcons.bookOpen, color: Colors.white),
                      const Padding(padding: EdgeInsets.only(right: 30)),
                      const Text(
                        'Cuadro médico',
                        style: Estilos.texto3,
                      ),
                    ],
                  ),
                ),
              ),
              Padding (padding: const EdgeInsets.all(60)),
              GestureDetector(
                onTap: () {
                  print("CAMBIO");
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Estilos.dorado_claro),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.light_mode_outlined, color: Colors.white, size: 30),
                      const Padding(padding: EdgeInsets.only(right: 50)),
                      const Text(
                        'Apariencia',
                        style: Estilos.texto3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Fila con los dos botones en la parte superior
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuir los botones de manera adecuada
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/inicio_sesion');
                    },
                    backgroundColor: Estilos.dorado_oscuro,
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                  // Usa el Builder para obtener el contexto
                  Builder(
                    builder: (BuildContext context) {
                      return FloatingActionButton(
                        onPressed: () {
                          // Abrir el Drawer desde el lado derecho con el contexto
                          Scaffold.of(context).openEndDrawer();
                        },
                        backgroundColor: Estilos.dorado_oscuro,
                        child: const Icon(FontAwesomeIcons.bars, color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),
            Text("PRÓXIMAS CITAS", style: Estilos.titulo2),
            const Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Estilos.fondo,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: citas.length, // La cantidad de elementos en la lista
                  itemBuilder: (context, index) {

                    Cita cita = citas[index]; // Obtener cada cita de la lista
                    String nombreEspecialidad = especialidades[cita.idProfesional]?.nombreEspecialidad ?? 'Desconocida'; // Obtener especialidad del mapa
                    String color = especialidades[cita.idProfesional]?.color ?? '0xFFFFFFFF'; // Color predeterminado si no se encuentra
                    String nombreProfesional = nombresProfesionales[cita.idProfesional] ?? 'Desconocido';
                    // Convertir la fecha de la base de datos (yyyy-MM-dd) a dd-MM-yyyy
                    String fechaFormateada = DateFormat.yMMMMd("es_ES").format(DateFormat('yyyy-MM-dd').parse(cita.fecha));
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/ver_cita', // Ruta para la página de detalles
                          arguments: cita, // Pasar la cita como argumento
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(int.parse(color)), // Color dependiendo de la especialidad
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(FontAwesomeIcons.stethoscope, color: Colors.black), //FontAwesomeIcons.calendar
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Cita de $nombreEspecialidad con $nombreProfesional. El $fechaFormateada a las ${cita.hora}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context, 
                                  '/ver_cita', // Ruta para la página de detalles
                                  arguments: cita, // Pasar la cita como argumento
                                );
                              },
                              icon: const Icon(FontAwesomeIcons.circleInfo, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}