class Especialidad {
  int? idEspecialidad;
  String nombreEspecialidad;
  String color;

  Especialidad({this.idEspecialidad, required this.nombreEspecialidad, required this.color});

  Map<String, dynamic> toMap() {
    return {
      'id_especialidad': idEspecialidad,
      'nombre_especialidad': nombreEspecialidad,
      'color': color,
    };
  }

  factory Especialidad.fromMap(Map<String, dynamic> map) {
    return Especialidad(
      idEspecialidad: map['id_especialidad'],
      nombreEspecialidad: map['nombre_especialidad'],
      color: map['color'],
    );
  }
}