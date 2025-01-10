class Usuario {
  int? id;
  String nombre;
  String correo;
  String contrasena;
  String numeroTarjeta;
  String compania;

  Usuario({
    this.id,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.numeroTarjeta,
    required this.compania,
  });

  // Convertir un Usuario a un Map (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      id: map['id'],
      nombre: map['nombre'],
      correo: map['correo'],
      contrasena: map['contrasena'],
      numeroTarjeta: map['numero_tarjeta'],
      compania: map['compania'],
    );
  }
}