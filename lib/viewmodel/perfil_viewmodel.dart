import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/usuario_model.dart';
import 'estilos__viewmodel.dart';
import 'CRUD/usuario_viewmodel.dart';

class PerfilViewModel {
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
          title: Text(AppLocalizations.of(context)!.botonActualizarContrasena, style: Estilos.texto5),
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
                      hintText: AppLocalizations.of(context)!.campoContrasenaActual,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.errorCampoObligatorio;
                      }
                      // Comprobar que la contraseña introducida coincide con la almacenada en la base de datos
                      if (usuario.contrasena != value) {
                        return AppLocalizations.of(context)!.errorContrasenaIncorrecta;
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
                      hintText: AppLocalizations.of(context)!.campoNuevaContrasena,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.errorCampoObligatorio;
                      } else if (value.length < 6) {
                        return AppLocalizations.of(context)!.errorCaracteres;
                      }
                      return null;
                    }
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    controller: contrasenaNueva2,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.campoConfirmarContrasena,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Estilos.dorado_oscuro,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.errorCampoObligatorio;
                      } else if (value.length < 6) {
                        return AppLocalizations.of(context)!.errorCaracteres;
                      }
                      // Comprobar que las dos contraseñas nuevas introducidas coinciden
                      if (contrasenaNueva1 != contrasenaNueva2) {
                        return AppLocalizations.of(context)!.errorCoincidencia;
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
              child: Text(AppLocalizations.of(context)!.botonCancelar, style: Estilos.texto4),
            ),
            TextButton(
              onPressed: () {
                if (formulario.currentState!.validate()) {
                  usuarioCRUD.actualizarContrasena(usuario.idUsuario, contrasenaNueva1);
                  Navigator.pop(context);
                }
              },
              child: Text(AppLocalizations.of(context)!.botonEliminar, style: Estilos.texto4),
            ),
          ],
        );
      },
    );
  }
}