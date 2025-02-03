import 'package:flutter/material.dart';
import 'package:proyecto_final/model/usuario.dart';
import 'guardar.dart';
import 'viewmodel/CRUD/centro_medicoCRUD.dart';
import 'viewmodel/CRUD/citaCRUD.dart';
import 'viewmodel/CRUD/especialidadCRUD.dart';
import 'viewmodel/CRUD/profesionalCRUD.dart';
import 'model/centro_medico.dart';
import 'model/cita.dart';
import 'estilos.dart';
import 'model/especialidad.dart';
import 'model/profesional.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Agregado para la localización

class NuevaCitaApp extends StatefulWidget {
  const NuevaCitaApp({super.key});

  @override
  State<NuevaCitaApp> createState() => _NuevaCitaApp();
}

class _NuevaCitaApp extends State<NuevaCitaApp> {
  EspecialidadCRUD especialidadCRUD = EspecialidadCRUD();
  ProfesionalCRUD profesionalCRUD = ProfesionalCRUD();
  CentroMedicoCRUD centroCRUD = CentroMedicoCRUD();
  CitaCRUD citaCRUD = CitaCRUD();
  Guardar guardar = Guardar();

  List<Especialidad> especialidades = [];
  List<Profesional> profesionales = [];
  List<CentroMedico> centros = [];

  Especialidad? especialidadSeleccionada;
  Profesional? profesionalSeleccionado;
  CentroMedico? centroSeleccionado;

  String fechaSeleccionada = '';
  String horaSeleccionada = '';

  @override
  void initState() {
    super.initState();
    _cargarEspecialidades();
  }

  // Cargar especialidades desde la base de datos
  Future<void> _cargarEspecialidades() async {
    List<Especialidad> lista = await especialidadCRUD.obtenerEspecialidades();
    setState(() {
      especialidades = lista;
    });
  }

  // Cargar profesionales filtrados por especialidad
  Future<void> _cargarProfesionales(int idEspecialidad) async {
    List<Profesional> lista = await profesionalCRUD.obtenerProfesionalesPorEspecialidad(idEspecialidad);
    setState(() {
      profesionales = lista;
      profesionalSeleccionado = null; // Reinicia selección al cambiar la especialidad
    });
  }

  // Cargar centros médicos filtrados por especialidad
  Future<void> _cargarCentros(int idEspecialidad) async {
    List<CentroMedico> lista = await centroCRUD.obtenerCentrosPorEspecialidad(idEspecialidad);
    setState(() {
      centros = lista;
      profesionalSeleccionado = null; // Reinicia selección al cambiar la especialidad
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
        fechaSeleccionada = DateFormat.yMMMMd("es_ES").format(d); // Formato de fecha en español  
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
      final String formattedTime = t.format(context);
      setState(() {
        horaSeleccionada = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    fechaSeleccionada = AppLocalizations.of(context)!.seleccionaFecha; 
    horaSeleccionada = AppLocalizations.of(context)!.seleccionaHora; 
    
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.nuevaCita, style: Estilos.titulo2), // Usamos el texto traducido
              const Padding(padding: EdgeInsets.all(10)),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Estilos.fondo),
                padding: const EdgeInsets.all(10),
                child: DropdownButton<Especialidad>(
                  isExpanded: true,
                  value: especialidadSeleccionada,
                  hint: Text(AppLocalizations.of(context)!.seleccionaEspecialidad), 
                  onChanged: (Especialidad? nuevaEspecialidad) {
                    setState(() {
                      especialidadSeleccionada = nuevaEspecialidad;
                    });
                    if (nuevaEspecialidad != null) {
                      _cargarProfesionales(nuevaEspecialidad.idEspecialidad as int);
                      _cargarCentros(nuevaEspecialidad.idEspecialidad as int);
                    }
                  },
                  items: especialidades.map((Especialidad especialidad) {
                    return DropdownMenuItem<Especialidad>(
                      value: especialidad,
                      child: Text(especialidad.nombreEspecialidad),
                    );
                  }).toList(),
                ),
              ),
              const Padding(padding: EdgeInsets.all(15)),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Estilos.fondo),
                padding: const EdgeInsets.all(10),
                child: DropdownButton<Profesional>(
                  isExpanded: true,
                  value: profesionalSeleccionado,
                  hint: Text(AppLocalizations.of(context)!.seleccionaProfesional), 
                  onChanged: (Profesional? nuevoProfesional) {
                    setState(() {
                      profesionalSeleccionado = nuevoProfesional;
                    });
                  },
                  items: profesionales.map((Profesional profesional) {
                    return DropdownMenuItem<Profesional>(
                      value: profesional,
                      child: Text(profesional.nombreProfesional),
                    );
                  }).toList(),
                ),
              ),
              const Padding(padding: EdgeInsets.all(15)),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Estilos.fondo),
                padding: const EdgeInsets.all(10),
                child: DropdownButton<CentroMedico>(
                  isExpanded: true,
                  value: centroSeleccionado,
                  hint: Text(AppLocalizations.of(context)!.seleccionaCentroMedico), 
                  onChanged: (CentroMedico? nuevoCentro) {
                    setState(() {
                      centroSeleccionado = nuevoCentro;
                    });
                  },
                  items: centros.map((CentroMedico centro) {
                    return DropdownMenuItem<CentroMedico>(
                      value: centro,
                      child: Text(centro.nombreCentro),
                    );
                  }).toList(),
                ),
              ),
              const Padding(padding: EdgeInsets.all(15)),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Estilos.fondo),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        fechaSeleccionada,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black)
                      ),
                      onTap: (){
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
                )
              ),
              const Padding(padding: EdgeInsets.all(15)),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Estilos.fondo),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        horaSeleccionada,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black)
                      ),
                      onTap: (){
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
                )
              ),
              const Padding(padding: EdgeInsets.all(15)),
              GestureDetector(
                onTap: () async {
                  Usuario? usuario = guardar.get();
                  if (usuario != null) {
                    // Convertir la fecha seleccionada a formato yyyy-MM-dd antes de guardarla
                    String fechaFormatoGuardar = DateFormat('yyyy-MM-dd').format(DateFormat.yMMMMd("es_ES").parse(fechaSeleccionada));

                    Cita cita = Cita(
                      idUsuario: usuario.idUsuario as int,
                      idProfesional: profesionalSeleccionado!.idProfesional as int,
                      idCentro: centroSeleccionado!.idCentro as int,
                      fecha: fechaFormatoGuardar, // Guardar en formato yyyy-MM-dd
                      hora: horaSeleccionada,
                    );

                    // Limpiar campos
                    setState(() {
                      especialidadSeleccionada = null;
                      profesionalSeleccionado = null;
                      centroSeleccionado = null;
                      fechaSeleccionada = AppLocalizations.of(context)!.seleccionaFecha; 
                      horaSeleccionada = AppLocalizations.of(context)!.seleccionaHora; 
                    });

                    await citaCRUD.crearCita(cita);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.citaCreadaExitosamente)), 
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.errorUsuarioNoEncontrado)), 
                    );
                  }
                },
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Estilos.dorado_claro),
                  child: Text(
                    AppLocalizations.of(context)!.agregar, 
                    textAlign: TextAlign.center,
                    style: Estilos.texto3,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
