import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/model/usuario.dart';
import '/estilos.dart';
import 'CRUD/usuarioCRUD.dart';

class Funciones{
  // Función que abre un diálogo actualizar la contraseña
  void actualizarContrasena(BuildContext context, Usuario usuario, UsuarioCRUD usuarioCRUD) {
    final formulario = GlobalKey<FormState>();
    final TextEditingController contrasenaActual = TextEditingController();
    final TextEditingController contrasenaNueva1 = TextEditingController();
    final TextEditingController contrasenaNueva2 = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.actualizarContrasena, style: Estilos.texto5),
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
                      hintText: AppLocalizations.of(context)!.contrasenaActual,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.campoObligatorio;
                      }
                      // Comprobar que la contraseña introducida coincide con la almacenada en la base de datos
                      if (usuario.contrasena != value) {
                        return AppLocalizations.of(context)!.contrasenaIncorrecta;
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
                      hintText: AppLocalizations.of(context)!.nuevaContrasena,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.campoObligatorio;
                      } else if (value.length < 6) {
                        return AppLocalizations.of(context)!.debeTenerMinimo6Caracteres;
                      }
                      return null;
                    }
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    controller: contrasenaNueva2,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.confirmarContrasena,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.campoObligatorio;
                      } else if (value.length < 6) {
                        return AppLocalizations.of(context)!.debeTenerMinimo6Caracteres;
                      }
                      // Comprobar que las dos contraseñas nuevas introducidas coinciden
                      if (contrasenaNueva1 != contrasenaNueva2) {
                        return AppLocalizations.of(context)!.lasContrasenasNoCoinciden;
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
              child: Text(AppLocalizations.of(context)!.cancelar, style: Estilos.texto4),
            ),
            ElevatedButton(
              onPressed: () {
                if (formulario.currentState!.validate()) {
                  usuarioCRUD.actualizarContrasena(usuario.idUsuario, contrasenaNueva1);
                  Navigator.pop(context);
                }
              },
              child: Text(AppLocalizations.of(context)!.eliminar, style: Estilos.texto4),
            ),
          ],
        );
      },
    );
  }
}