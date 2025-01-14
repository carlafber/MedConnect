class CentroMedico {
  int? idCentro;
  String nombreCentro;
  String direccion;
  int idEspecialidad;

  CentroMedico({
    this.idCentro,
    required this.nombreCentro,
    required this.direccion,
    required this.idEspecialidad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_centro': idCentro,
      'nombre_centro': nombreCentro,
      'direccion': direccion,
      'id_especialidad': idEspecialidad,
    };
  }

  factory CentroMedico.fromMap(Map<String, dynamic> map) {
    return CentroMedico(
      idCentro: map['id_centro'],
      nombreCentro: map['nombre_centro'],
      direccion: map['direccion'],
      idEspecialidad: map['id_especialidad'],
    );
  }
}