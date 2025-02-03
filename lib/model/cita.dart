class Cita {
  int? idCita;
  int idUsuario;
  int idProfesional;
  int idCentro;
  String fecha;
  String hora;

  Cita({
    this.idCita,
    required this.idUsuario,
    required this.idProfesional,
    required this.idCentro,
    required this.fecha,
    required this.hora,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_cita': idCita,
      'id_usuario': idUsuario,
      'id_profesional': idProfesional,
      'id_centro': idCentro,
      'fecha': fecha,
      'hora': hora,
    };
  }

  factory Cita.fromMap(Map<String, dynamic> map) {
    return Cita(
      idCita: map['id_cita'],
      idUsuario: map['id_usuario'],
      idProfesional: map['id_profesional'],
      idCentro: map['id_centro'],
      fecha: map['fecha'],
      hora: map['hora'],
    );
  }
}