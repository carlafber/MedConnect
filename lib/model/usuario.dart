class Usuario {
  int? idUsuario;
  String nombre;
  String correo;
  String contrasena;
  String numeroTarjeta;
  String compania;

  Usuario({
    this.idUsuario,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.numeroTarjeta,
    required this.compania,
  });

  // Convertir un Usuario a un Map (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUsuario,
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
      'numero_tarjeta': numeroTarjeta,
      'compania': compania,
    };
  }

  // Crear un Usuario a partir de un Map (para leer desde la base de datos)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id_usuario'],
      nombre: map['nombre'],
      correo: map['correo'],
      contrasena: map['contrasena'],
      numeroTarjeta: map['numero_tarjeta'],
      compania: map['compania'],
    );
  }
}