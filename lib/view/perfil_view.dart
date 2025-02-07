import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '/viewmodel/perfil_viewmodel.dart';
import '/viewmodel/CRUD/usuario_viewmodel.dart';
import '/model/usuario_model.dart';
import '/estilos.dart';
import '../viewmodel/provider_usuario_viewmodel.dart';


class PerfilApp extends StatefulWidget {
  const PerfilApp({super.key});

  @override
  State<PerfilApp> createState() => _PerfilApp();
}

class _PerfilApp extends State<PerfilApp> {
  UsuarioCRUD usuarioCRUD = UsuarioCRUD();
  PerfilViewModel perfilvm = PerfilViewModel();

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;

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
                          AppLocalizations.of(context)!.tituloDetallesPerfil,
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
                            AppLocalizations.of(context)!.textoNombre,
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
                            AppLocalizations.of(context)!.textoCorreo,
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
                            "${AppLocalizations.of(context)!.campoTarjeta}:",
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
                            AppLocalizations.of(context)!.textoCompania,
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
                      const Padding(padding: EdgeInsets.all(30)),
                      GestureDetector(
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