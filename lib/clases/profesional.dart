class Profesional {
  int? idProfesional;
  String nombreProfesional;
  int idEspecialidad;

  Profesional({
    this.idProfesional,
    required this.nombreProfesional,
    required this.idEspecialidad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_profesional': idProfesional,
      'nombre_profesional': nombreProfesional,
      'id_especialidad': idEspecialidad,
    };
  }

  factory Profesional.fromMap(Map<String, dynamic> map) {
    return Profesional(
      idProfesional: map['id_profesional'],
      nombreProfesional: map['nombre_profesional'],
      idEspecialidad: map['id_especialidad'],
    );
  }
}