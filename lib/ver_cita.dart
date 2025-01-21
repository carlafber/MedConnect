import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_final/DAO/citaDAO.dart';
import 'DAO/centro_medicoDAO.dart';
import 'DAO/especialidadDAO.dart';
import 'DAO/profesionalDAO.dart';
import 'clases/centro_medico.dart';
import 'clases/cita.dart';
import 'clases/especialidad.dart';
import 'clases/profesional.dart';
import 'db_helper.dart';
import 'estilos.dart';

class VerCitaApp extends StatefulWidget {
  const VerCitaApp({super.key});

  @override
  State<VerCitaApp> createState() => _VerCitaApp();
}

class _VerCitaApp extends State<VerCitaApp> {
  final DBHelper db = DBHelper();
  final EspecialidadDAO especialidadDAO = EspecialidadDAO();
  final ProfesionalDAO profesionalDAO = ProfesionalDAO();
  final CentroMedicoDAO centroDAO = CentroMedicoDAO();
  final CitaDAO citaDAO = CitaDAO();

  Future<String> obtenerDetallesCita(Cita cita) async {
    return 'Fecha: ${cita.fecha}\nHora: ${cita.hora}';
  }

  Especialidad? especialidadCita;
  Profesional? profesionalCita;
  CentroMedico? centroCita;
  String fechaCita = "";
  String horaCita = "";

  bool _cargando = true;
  

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final Cita cita = ModalRoute.of(context)!.settings.arguments as Cita;
      await _cargarDatosDeCita(cita);
      fechaCita = cita.fecha;
      horaCita = cita.hora;
    });
  }

  Future<void> _cargarDatosDeCita(Cita cita) async {
    setState(() {
      _cargando = true; // Iniciar carga
    });
    // Cargar solo la especialidad, profesional y centro relacionados con esta cita.
    await _cargarEspecialidadDeCita(cita);
    await _cargarProfesionalDeCita(cita);
    await _cargarCentroDeCita(cita);
    setState(() {
      _cargando = false; // Finalizar carga
    });  // Para actualizar la UI después de cargar los datos.
  }

  Future<void> _cargarEspecialidadDeCita(Cita cita) async {
    final especialidad = await profesionalDAO.obtenerEspecialidadDeProfesional(cita.idProfesional);
    setState(() {
      especialidadCita = especialidad;
    });
  }

  Future<void> _cargarProfesionalDeCita(Cita cita) async {
    final profesional = await profesionalDAO.obtenerProfesional(cita.idProfesional);
    setState(() {
      profesionalCita = profesional;
    });
  }

  Future<void> _cargarCentroDeCita(Cita cita) async {
    final centro = await centroDAO.obtenerCentro(cita.idCentro);
    setState(() {
      centroCita = centro;
    });
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      locale: Locale('es', 'ES'), // Establece el idioma del DatePicker a español
    );
    if (d != null) {
      setState(() {
        fechaCita = DateFormat('yyyy-MM-dd').format(d); // Formato de fecha en español  
      });
    }
  }

  Future<void> _seleccionarHora(BuildContext context) async {
    // Muestra el TimePicker
    final TimeOfDay? t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) {
      setState(() {
        horaCita = t.format(context);
      });
    }
  }
  

  
  @override
  Widget build(BuildContext context) {
    final Cita cita = ModalRoute.of(context)!.settings.arguments as Cita;
    String fechaFormateada = DateFormat.yMMMMd("es_ES").format(DateFormat('yyyy-MM-dd').parse(fechaCita));
    
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding (
        padding: const EdgeInsets.all(25),
        child: /*_cargando  // Verifica si está cargando
          ? Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Estilos.dorado),),  // Mostrar el cargando
            )
          : */Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/main_bnb');
                  },
                  backgroundColor: Estilos.dorado_oscuro,
                  child: const Icon(Icons.arrow_back, color: Colors.white)
                ),
              ),
            ),
            Text("DETALLES DE LA CITA", style: Estilos.titulo2),
            const Padding(padding: EdgeInsets.all(10)),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(color: Estilos.fondo),
              padding: const EdgeInsets.all(10),
              child: Text(
                "Especialidad: ${especialidadCita!.nombreEspecialidad}",
                style: Estilos.texto6,
              ),
            ),
            const Padding(padding: EdgeInsets.all(13)),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(color: Estilos.fondo),
              padding: const EdgeInsets.all(10),
              child: Text(
                "Profesional: ${profesionalCita!.nombreProfesional}",
                style: Estilos.texto6,
              ),
            ),
            const Padding(padding: EdgeInsets.all(13)),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(color: Estilos.fondo),
              padding: const EdgeInsets.all(10),
              child: Text(
                "Centro médico: ${centroCita!.nombreCentro}",
                style: Estilos.texto6,
              ),
            ),
            const Padding(padding: EdgeInsets.all(13)),
            Container(
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Estilos.fondo),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Text(
                      'Fecha: $fechaFormateada',
                      textAlign: TextAlign.center,
                      style: Estilos.texto6,
                    ),
                    onTap: () {
                      _seleccionarFecha(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _seleccionarFecha(context);
                    },
                  ),
                ]
              ),
            ),
            const Padding(padding: EdgeInsets.all(13)),
            Container(
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Estilos.fondo),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Text(
                      'Hora: $horaCita',
                      textAlign: TextAlign.center,
                      style: Estilos.texto6,
                    ),
                    onTap: () {
                      _seleccionarHora(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () {
                      _seleccionarHora(context);
                    },
                  ),
                ]
              ),
            ),
            const Padding(padding: EdgeInsets.all(13)),
            Align(
              alignment: Alignment.bottomCenter, // Alinea el botón en parte inferior
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        //actualizar fecha y hora de cita
                        await citaDAO.actualizarCita(cita.idCita, fechaCita, horaCita);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Cita actualizada exitosamente")),
                        );
                        // Esperar 3 segundos antes de volver
                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Estilos.dorado_claro, 
                        ),
                        padding: const EdgeInsets.all(10),
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
                      onTap: () async {
                        //pedir confirmación
                        bool? confirmacion = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmar eliminación"),
                              content: Text("¿Estás seguro de que deseas eliminar la cita? Esta acción no se puede deshacer."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false); // Cancelar
                                  },
                                  child: Text("Cancelar", style: Estilos.texto4),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true); // Confirmar
                                  },
                                  child: Text("Eliminar", style: Estilos.texto4),
                                ),
                              ],
                            );
                          },
                        );
                        if (confirmacion == true) {
                          await citaDAO.eliminarCita(cita.idCita as int);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Cita eliminada correctamente")),
                          );
                          await Navigator.pushNamed(context, '/inicio');
                        }
                      },
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Estilos.dorado_claro,
                        ),
                        padding: const EdgeInsets.all(10),
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