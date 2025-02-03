import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'viewmodel/CRUD/usuarioCRUD.dart';
import 'model/usuario.dart';
import 'estilos.dart';
import 'guardar.dart';


class PerfilApp extends StatefulWidget {
  const PerfilApp({super.key});

  @override
  State<PerfilApp> createState() => _PerfilApp();
}

class _PerfilApp extends State<PerfilApp> {
  Guardar guardar = Guardar();
  UsuarioCRUD usuarioCRUD = UsuarioCRUD();

  @override
  Widget build(BuildContext context) {
    Usuario? usuario = guardar.get();

    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: Estilos.dorado_oscuro,
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/perfil.png', width: 100, height: 100),
                      const Padding(padding: EdgeInsets.all(10)),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.of(context)!.detallesPerfil, // Usar traducción
                          textAlign: TextAlign.center,
                          style: Estilos.titulo2,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.user, color: Colors.black),
                          const Padding(padding: EdgeInsets.all(10)),
                          Text(
                            AppLocalizations.of(context)!.nombre, // Usar traducción
                            style: Estilos.texto,
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Text(
                            usuario!.nombre,
                            style: Estilos.texto,
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.envelope, color: Colors.black),
                          const Padding(padding: EdgeInsets.all(10)),
                          Text(
                            AppLocalizations.of(context)!.correo, // Usar traducción
                            style: Estilos.texto,
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Text(
                            usuario.correo,
                            style: Estilos.texto,
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.creditCard, color: Colors.black),
                          const Padding(padding: EdgeInsets.all(10)),
                          Text(
                            AppLocalizations.of(context)!.numeroTarjeta, // Usar traducción
                            style: Estilos.texto,
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Text(
                            usuario.numeroTarjeta,
                            style: Estilos.texto,
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.circleCheck, color: Colors.black),
                          const Padding(padding: EdgeInsets.all(10)),
                          Text(
                            AppLocalizations.of(context)!.compania, // Usar traducción
                            style: Estilos.texto,
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Text(
                            usuario.compania,
                            style: Estilos.texto,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // Pedir confirmación
                          bool? confirmacion = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context)!.confirmarEliminacion), // Usar traducción
                                content: Text(AppLocalizations.of(context)!.confirmacionEliminarCita), // Usar traducción
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false); // Cancelar
                                    },
                                    child: Text(AppLocalizations.of(context)!.cancelar, style: Estilos.texto4), // Usar traducción
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true); // Confirmar
                                    },
                                    child: Text(AppLocalizations.of(context)!.eliminar, style: Estilos.texto4), // Usar traducción
                                  ),
                                ],
                              );
                            },
                          );
                          if (confirmacion == true) {
                            await usuarioCRUD.eliminarUsuario(usuario.idUsuario as int);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(AppLocalizations.of(context)!.usuarioEliminado)), // Usar traducción
                            );
                            await Navigator.pushNamed(context, '/inicio_sesion');
                          }
                        },
                        child: Container(
                          height: 75,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Estilos.dorado_claro,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            AppLocalizations.of(context)!.eliminarCuenta, // Usar traducción
                            textAlign: TextAlign.center,
                            style: Estilos.texto3,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(30)),
                      GestureDetector(
                        onTap: () async {
                          _actualizarContrasena(context, usuario, usuarioCRUD);
                        },
                        child: Container(
                          height: 75,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Estilos.dorado_claro,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            AppLocalizations.of(context)!.actualizarContrasena, // Usar traducción
                            textAlign: TextAlign.center,
                            style: Estilos.texto3,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función que abre un diálogo actualizar la contraseña
  void _actualizarContrasena(BuildContext context, Usuario usuario, UsuarioCRUD usuarioCRUD) {
    final formulario = GlobalKey<FormState>();
    final TextEditingController contrasenaActual = TextEditingController();
    final TextEditingController contrasenaNueva1 = TextEditingController();
    final TextEditingController contrasenaNueva2 = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.actualizarContrasena, style: Estilos.texto5), // Usar traducción
          backgroundColor: Estilos.fondo,
          content: SizedBox(
            width: 400,
            child: Form(
              key: formulario,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  // Introducir la contraseña actual
                  TextFormField(
                    controller: contrasenaActual,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.campoObligatorio, // Usar traducción
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.campoObligatorio; // Usar traducción
                      }
                      // Comprobar que la contraseña introducida coincide con la almacenada en la base de datos
                      if (usuario.contrasena != value) {
                        return AppLocalizations.of(context)!.contrasenaIncorrecta; // Usar traducción
                      }
                      return null;
                    }
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  // Introducir la nueva contraseña dos veces
                  TextFormField(
                    controller: contrasenaNueva1,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.debeTenerMinimo6Caracteres, // Usar traducción
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.campoObligatorio; // Usar traducción
                      } else if (value.length < 6) {
                        return AppLocalizations.of(context)!.debeTenerMinimo6Caracteres; // Usar traducción
                      }
                      return null;
                    }
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    controller: contrasenaNueva2,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.lasContrasenasNoCoinciden, // Usar traducción
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.campoObligatorio; // Usar traducción
                      } else if (value.length < 6) {
                        return AppLocalizations.of(context)!.debeTenerMinimo6Caracteres; // Usar traducción
                      }
                      // Comprobar que las dos contraseñas nuevas introducidas coinciden
                      if (contrasenaNueva1 != contrasenaNueva2) {
                        return AppLocalizations.of(context)!.lasContrasenasNoCoinciden; // Usar traducción
                      }
                      return null;
                    }
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelar, style: Estilos.texto4), // Usar traducción
            ),
            ElevatedButton(
              onPressed: () {
                if (formulario.currentState!.validate()) {
                  usuarioCRUD.actualizarContrasena(usuario.idUsuario, contrasenaNueva1);
                  Navigator.pop(context);
                }
              },
              child: Text(AppLocalizations.of(context)!.eliminar, style: Estilos.texto4), // Usar traducción
            ),
          ],
        );
      },
    );
  }
}