class Especialidad {
  int? idEspecialidad;
  String nombreEspecialidad;

  Especialidad({this.idEspecialidad, required this.nombreEspecialidad});

  Map<String, dynamic> toMap() {
    return {
      'id_especialidad': idEspecialidad,
      'nombre_especialidad': nombreEspecialidad,
    };
  }

  factory Especialidad.fromMap(Map<String, dynamic> map) {
    return Especialidad(
      idEspecialidad: map['id_especialidad'],
      nombreEspecialidad: map['nombre_especialidad'],
    );
  }
}