import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'estilos_viewmodel.dart';
import 'CRUD/usuario_viewmodel.dart';
import '/model/usuario_model.dart';

/// **Proveedor de funciones relacionadas con el perfil de usuario.**
///
/// Gestiona la operación de actualización de contraseña de un usuario, proporcionando
/// una interfaz para que el usuario pueda cambiar su contraseña mediante un diálogo.
class PerfilViewModel {
  /// **Método** que abre un diálogo para actualizar la contraseña, permitiendo al usuario
  /// cambiar su contraseña introduciendo la contraseña actual y luego la nueva dos veces.
  ///
  /// @param context → El contexto de la vista donde se abrirá el diálogo.
  /// @param usuario → El objeto `Usuario` cuya contraseña será actualizada.
  /// @param usuarioCRUD → El objeto `UsuarioCRUD` que maneja las operaciones CRUD en la base de datos.
  void actualizarContrasena(BuildContext context, Usuario usuario, UsuarioCRUD usuarioCRUD) {
    final formulario = GlobalKey<FormState>();
    final TextEditingController contrasenaActual = TextEditingController();
    final TextEditingController contrasenaNueva = TextEditingController();
    final TextEditingController contrasenaNuevaConf = TextEditingController();

    // Se muestra un diálogo para la actualización de la contraseña.
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
                  /// Campo para introducir la contraseña actual.
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
                      // Se comprueba que la contraseña introducida coincide con la almacenada en la base de datos
                      if (usuario.contrasena != value) {
                        return AppLocalizations.of(context)!.errorContrasenaIncorrecta;
                      }
                      return null;
                    }
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  /// Campo para introducir la nueva contraseña.
                  TextFormField(
                    controller: contrasenaNueva,
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
                      }
                      // Se comprueba que la contraseña introducida tenga al menos 6 caracteres
                      if (value.length < 6) {
                        return AppLocalizations.of(context)!.errorCaracteres;
                      }
                      return null;
                    }
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  /// Campo para confirmar la nueva contraseña.
                  TextFormField(
                    controller: contrasenaNuevaConf,
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
                      }
                      // Se comprueba que la contraseña introducida tenga al menos 6 caracteres
                      if (value.length < 6) {
                        return AppLocalizations.of(context)!.errorCaracteres;
                      }
                      // Comprobar que las dos contraseñas nuevas introducidas coinciden
                      if (contrasenaNueva != contrasenaNuevaConf) {
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
            // Botón para cancelar la acción
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.botonCancelar, style: Estilos.texto4),
            ),
            // Botón para confirmar y actualizar la contraseña
            TextButton(
              onPressed: () {
                if (formulario.currentState!.validate()) {
                  usuarioCRUD.actualizarContrasena(usuario.idUsuario, contrasenaNueva);
                  Navigator.pop(context);
                }
              },
              child: Text(AppLocalizations.of(context)!.botonActualizar, style: Estilos.texto4),
            ),
          ],
        );
      },
    );
  }
}