import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/CRUD/usuario_viewmodel.dart';
import '../model/usuario_model.dart';
import '../viewmodel/guardar_usuario_viewmodel.dart';
import '../viewmodel/guardar_usuario_viewmodel.dart';
import '../viewmodel/estilos__viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InicioSesionApp extends StatefulWidget {
  const InicioSesionApp({super.key});

  @override
  State<InicioSesionApp> createState() => _InicioSesionApp();
}

class _InicioSesionApp extends State<InicioSesionApp> {
  final _formulario = GlobalKey<FormState>();
  final _numTarjeta = TextEditingController();
  final List<String> companias = ['Asisa', 'Adeslas', 'Caser'];
  String? companiaSeleccionada;
  UsuarioCRUD usuarioCRUD = UsuarioCRUD();
  Usuario? usuario;
  Guardar guardar = Guardar();

  // Función para verificar si el número de tarjeta es válido
  Future<String?> _validarTarjeta(String value) async {
    double valor = double.tryParse(value) ?? 0.0;

    if (value.isEmpty) {
      return AppLocalizations.of(context)!.errorComplete;
    }

    if(valor == 0){
      return AppLocalizations.of(context)!.errorTarjeta;
    }

    // Esperamos la respuesta de la base de datos
    usuario = await usuarioCRUD.existeUsuario(value);

    if (usuario == null) {
      return AppLocalizations.of(context)!.errorUsuario;
    }

    if (usuario?.compania != companiaSeleccionada) {
      return AppLocalizations.of(context)!.errorCompania;
    }

    return null; // Si todo es válido
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formulario,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Estilos.fondo),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'MedConnect',
                        textAlign: TextAlign.center,
                        style: Estilos.titulo,
                      ),
                      const Padding(padding: EdgeInsets.all(1)),
                      Text(
                        AppLocalizations.of(context)!.textoGestor,
                        textAlign: TextAlign.center,
                        style: Estilos.texto,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.all(30)),
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Estilos.fondo),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Estilos.dorado_oscuro,
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Expanded(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: companiaSeleccionada,
                                hint: Text(AppLocalizations.of(context)!.campoCompania),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    companiaSeleccionada = newValue;
                                  });
                                },
                                items: companias.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(30)),
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Estilos.fondo),
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _numTarjeta,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.credit_card,
                              color: Estilos.dorado_oscuro,
                            ),
                            hintText: AppLocalizations.of(context)!.campoTarjeta,
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Estilos.dorado_oscuro,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(50)),
                      GestureDetector(
                        onTap: () async {
                          // Verificar la validez antes de continuar
                          String? tarjeta = _numTarjeta.text;
                          if (tarjeta.isEmpty || companiaSeleccionada == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(AppLocalizations.of(context)!.errorComplete)),
                            );
                            return;
                          }
                          // Validación asíncrona
                          String? mensajeError = await _validarTarjeta(tarjeta);
                          if (mensajeError != null) {
                            // Si hay error de validación, mostrar un mensaje
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(mensajeError)),
                            );
                          } else {
                            // Si la validación fue exitosa, guardar el usuario y navegamos
                            guardar.set(usuario!);
                            Navigator.pushNamed(context, '/main_bnb');
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(color: Estilos.dorado_claro),
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            AppLocalizations.of(context)!.botonAcceder,
                            textAlign: TextAlign.center,
                            style: Estilos.texto2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
