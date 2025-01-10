class Especialidad {
  int? id;
  String nombreEspecialidad;

  Especialidad({this.id, required this.nombreEspecialidad});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre_especialidad': nombreEspecialidad,
    };
  }

  factory Especialidad.fromMap(Map<String, dynamic> map) {
    return Especialidad(
      id: map['id'],
      nombreEspecialidad: map['nombre_especialidad'],
    );
  }
}