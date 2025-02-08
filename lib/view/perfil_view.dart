import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/model/usuario_model.dart';
import '/viewmodel/perfil_viewmodel.dart';
import '/viewmodel/CRUD/usuario_viewmodel.dart';
import '/viewmodel/estilos_viewmodel.dart';
import '/viewmodel/guardar_usuario_viewmodel.dart';


class PerfilApp extends StatefulWidget {
  const PerfilApp({super.key});

  @override
  State<PerfilApp> createState() => Perfil();
}

class Perfil extends State<PerfilApp> {
  Guardar guardar = Guardar();
  UsuarioCRUD usuarioCRUD = UsuarioCRUD();
  PerfilViewModel perfilvm = PerfilViewModel();

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
                      child: Semantics(
                        label: AppLocalizations.of(context)!.botonVolver,
                        button: true,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: Estilos.dorado_oscuro,
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: AppLocalizations.of(context)!.semFotoPerfil,
                    child: Image.asset('assets/perfil.png', width: 100, height: 100),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.tituloDetallesPerfil,
                      textAlign: TextAlign.center,
                      style: Estilos.titulo2,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(30)),
              Column(
                children: [
                  Semantics(
                    label: "${AppLocalizations.of(context)!.textoNombre} ${usuario!.nombre}",
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.user, color: Colors.black),
                        const Padding(padding: EdgeInsets.all(10)),
                        Flexible(
                          child: Text(
                            "${AppLocalizations.of(context)!.textoNombre} ${usuario.nombre}",
                            style: Estilos.texto,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Semantics(
                    label: "${AppLocalizations.of(context)!.textoCorreo} ${usuario.correo}",
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.envelope, color: Colors.black),
                        const Padding(padding: EdgeInsets.all(10)),
                        Flexible(
                          child: Text(
                            "${AppLocalizations.of(context)!.textoCorreo} ${usuario.correo}",
                            style: Estilos.texto,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Semantics(
                    label: "${AppLocalizations.of(context)!.campoTarjeta}: ${usuario.numeroTarjeta}",
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.creditCard, color: Colors.black),
                        const Padding(padding: EdgeInsets.all(10)),
                        Flexible(
                          child: Text(
                            "${AppLocalizations.of(context)!.campoTarjeta}: ${usuario.numeroTarjeta}",
                            style: Estilos.texto,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2, // Limita el número de líneas para evitar desbordamiento
                            softWrap: true, // Permite que el texto se divida en varias líneas
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Semantics(
                    label: "${AppLocalizations.of(context)!.textoCompania} ${usuario.compania}",
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.circleCheck, color: Colors.black),
                        const Padding(padding: EdgeInsets.all(10)),
                        Flexible(
                          child: Text(
                            "${AppLocalizations.of(context)!.textoCompania} ${usuario.compania}",
                            style: Estilos.texto,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2, // Limita el número de líneas para evitar desbordamiento
                            softWrap: true, // Permite que el texto se divida en varias líneas
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Semantics(
                          label: AppLocalizations.of(context)!.botonEliminarCuenta,
                          button: true,
                          child: GestureDetector(
                            onTap: () async {
                              bool? confirmacion = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context)!.mensajeConfirmarEliminacion),
                                    content: Text(AppLocalizations.of(context)!.mensajeEliminarCuenta),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false); // Cancelar
                                        },
                                        child: Text(AppLocalizations.of(context)!.botonCancelar, style: Estilos.texto4),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true); // Confirmar
                                        },
                                        child: Text(AppLocalizations.of(context)!.botonEliminar, style: Estilos.texto4),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (confirmacion == true) {
                                await usuarioCRUD.eliminarUsuario(usuario.idUsuario as int);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppLocalizations.of(context)!.exitoCuentaEliminada)),
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
                                AppLocalizations.of(context)!.botonEliminarCuenta,
                                textAlign: TextAlign.center,
                                style: Estilos.texto3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), // Espacio entre los botones
                      Expanded(
                        child: Semantics(
                          label: AppLocalizations.of(context)!.botonActualizarContrasena,
                          button: true,
                          child: GestureDetector(
                            onTap: () async {
                              perfilvm.actualizarContrasena(context, usuario, usuarioCRUD);
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
                                AppLocalizations.of(context)!.botonActualizarContrasena,
                                textAlign: TextAlign.center,
                                style: Estilos.texto3,
                              ),
                            ),
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
}
