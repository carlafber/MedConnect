class CentroMedico {
  int? id;
  String nombreCentro;
  String direccion;

  CentroMedico({
    this.id,
    required this.nombreCentro,
    required this.direccion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre_centro': nombreCentro,
      'direccion': direccion,
    };
  }

  factory CentroMedico.fromMap(Map<String, dynamic> map) {
    return CentroMedico(
      id: map['id'],
      nombreCentro: map['nombre_centro'],
      direccion: map['direccion'],
    );
  }
}