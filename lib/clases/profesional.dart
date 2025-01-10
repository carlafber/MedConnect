class Profesional {
  int? id;
  String nombreProfesional;
  int idEspecialidad;

  Profesional({
    this.id,
    required this.nombreProfesional,
    required this.idEspecialidad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre_profesional': nombreProfesional,
      'id_especialidad': idEspecialidad,
    };
  }

  factory Profesional.fromMap(Map<String, dynamic> map) {
    return Profesional(
      id: map['id'],
      nombreProfesional: map['nombre_profesional'],
      idEspecialidad: map['id_especialidad'],
    );
  }
}