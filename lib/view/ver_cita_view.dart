import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../viewmodel/CRUD/cita_viewmodel.dart';
import '../viewmodel/CRUD/centro_medico_viewmodel.dart';
import '../viewmodel/CRUD/especialidad_viewmodel.dart';
import '../viewmodel/CRUD/profesional_viewmodel.dart';
import '../model/centro_medico_model.dart';
import '../model/cita_model.dart';
import '../model/especialidad_model.dart';
import '../model/profesional_model.dart';
import '../services/db_helper.dart';
import '../viewmodel/estilos_viewmodel.dart';

class VerCitaApp extends StatefulWidget {
  const VerCitaApp({super.key});

  @override
  State<VerCitaApp> createState() => _VerCitaApp();
}

class _VerCitaApp extends State<VerCitaApp> {
  final DBHelper db = DBHelper();
  final EspecialidadCRUD especialidadCRUD = EspecialidadCRUD();
  final ProfesionalCRUD profesionalCRUD = ProfesionalCRUD();
  final CentroMedicoCRUD centroCRUD = CentroMedicoCRUD();
  final CitaCRUD citaCRUD = CitaCRUD();

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

  // Cargar especialidades para cada cita
  Future<void> _cargarEspecialidadDeCita(Cita cita) async {
    final especialidad = await profesionalCRUD.obtenerEspecialidadDeProfesional(cita.idProfesional);
    setState(() {
      especialidadCita = especialidad;
    });
  }

  // Cargar profesionales para cada cita
  Future<void> _cargarProfesionalDeCita(Cita cita) async {
    final profesional = await profesionalCRUD.obtenerProfesional(cita.idProfesional);
    setState(() {
      profesionalCita = profesional;
    });
  }

  // Cargar centros para cada cita
  Future<void> _cargarCentroDeCita(Cita cita) async {
    final centro = await centroCRUD.obtenerCentro(cita.idCentro);
    setState(() {
      centroCita = centro;
    });
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),  // Para que no se puedan seleccionar fechas anteriores a la actual
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: _cargando  // Verifica si está cargando
          ? Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Estilos.dorado),),  // Mostrar el cargando
            )
          : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Alineamos todo a la izquierda
                  children: [
                    // Botón de flecha alineado a la izquierda
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      backgroundColor: Estilos.dorado_oscuro,
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    
                    // Expansión del texto para centrarlo
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.tituloDetallesCita,
                        textAlign: TextAlign.center,  // Centra el texto
                        style: Estilos.titulo2,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(color: Estilos.fondo),
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${AppLocalizations.of(context)!.textoEspecialidad}: ${especialidadCita!.nombreEspecialidad}",
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
                  "${AppLocalizations.of(context)!.textoProfesional}: ${profesionalCita!.nombreProfesional}",
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
                  "${AppLocalizations.of(context)!.textoCentroMedico}: ${centroCita!.nombreCentro}",
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
                        '${AppLocalizations.of(context)!.textoFecha}: $fechaFormateada',
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
                  ],
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
                        '${AppLocalizations.of(context)!.textoHora}: $horaCita',
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
                  ],
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
                          // Actualizar fecha y hora de cita
                          await citaCRUD.actualizarCita(cita.idCita, fechaCita, horaCita);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context)!.exitoCitaActualizada)),
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
                          child: Text(
                            AppLocalizations.of(context)!.botonActualizar,
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
                          // Pedir confirmación
                          bool? confirmacion = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context)!.mensajeConfirmarEliminacion),
                                content: Text(AppLocalizations.of(context)!.mensajeEliminarCita),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false); // Cancelar
                                    },
                                    child: Text(AppLocalizations.of(context)!.botonCancelar, style: Estilos.texto4),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true); // Confirmar
                                    },
                                    child: Text(AppLocalizations.of(context)!.botonEliminar, style: Estilos.texto4),
                                  ),
                                ],
                              );
                            },
                          );
                          if (confirmacion == true) {
                            await citaCRUD.eliminarCita(cita.idCita as int);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(AppLocalizations.of(context)!.exitoCitaEliminada)),
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
                          child: Text(
                            AppLocalizations.of(context)!.botonEliminar,
                            textAlign: TextAlign.center,
                            style: Estilos.texto3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
