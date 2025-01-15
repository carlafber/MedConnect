import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_final/DAO/usuarioDAO.dart';
import 'clases/usuario.dart';
import 'estilos.dart';
import 'guardar.dart';

class PerfilApp extends StatefulWidget {
  const PerfilApp({super.key});

  @override
  State<PerfilApp> createState() => _PerfilApp();
}

class _PerfilApp extends State<PerfilApp> {
  Guardar guardar = Guardar();
  UsuarioDAO usuarioDAO = UsuarioDAO();
  
  
  @override
  Widget build(BuildContext context) {
    Usuario? usuario = guardar.get();

    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Padding (
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
                        print("Volver");
                        Navigator.pop(context);
                      },
                      backgroundColor: Estilos.dorado_oscuro,
                      child: const Icon(Icons.arrow_back, color: Colors.white)
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
                      child: const Text(
                        'DETALLES DEL PERFIL',
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
                          'Nombre:',
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
                          'Correo:',
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
                          'Número de tarjeta:',
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
                          'Compañía:',
                          style: Estilos.texto,
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Text(
                          usuario.compania,
                          style: Estilos.texto,
                        ),
                      ],
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.all(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await usuarioDAO.eliminarUsuario(usuario.idUsuario as int);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Usuario eliminado correctamente")),
                        );
                        await Navigator.pushNamed(context, '/inicio_sesion');
                      },
                      child: Container(
                        height: 75,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Estilos.dorado_claro,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Text(
                          'Eliminar cuenta',
                          textAlign: TextAlign.center,
                          style: Estilos.texto3,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(30)),
                    GestureDetector(
                      onTap: () async {
                        //
                      },
                      child: Container(
                        height: 75,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Estilos.dorado_claro,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Text(
                          'Actualizar contraseña',
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
    );
  }
}