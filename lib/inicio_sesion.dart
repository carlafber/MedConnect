import 'package:flutter/material.dart';
import 'estilos.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilos.dorado,
      body: Center(
        child: Form(
          key: _formulario,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.all(10),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'MedConnect',
                      textAlign: TextAlign.center,
                      style: Estilos.titulo,
                    ),
                    Padding(padding: EdgeInsets.all(1)),
                    Text(
                      'gestor de citas',
                      textAlign: TextAlign.center,
                      style: Estilos.texto,
                    ),
                  ],
                )
              ),
              Padding (
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.all(30)),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: Colors.white),
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
                              isExpanded: true,  // Esto hace que el DropdownButton ocupe todo el ancho disponible
                              value: companiaSeleccionada,
                              hint: const Text("Seleccione su compañía"),
                              onChanged: (String? newValue) {
                                setState(() {
                                  companiaSeleccionada = newValue!;
                                });
                              },
                              items: companias.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ),
                        ],
                      )
                    ),
                    const Padding(padding: EdgeInsets.all(30)),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _numTarjeta,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.credit_card,
                            color: Estilos.dorado_oscuro,
                          ),
                          hintText: 'Número de la tarjeta',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Estilos.dorado_oscuro,  // Color del borde cuando está enfocado
                            ),
                          ),
                        ),
                      )
                    ),
                    const Padding(padding: EdgeInsets.all(50)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/main_bnb');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Estilos.dorado_claro),
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'Acceder',
                          textAlign: TextAlign.center,
                          style: Estilos.texto2,
                        ),
                      ),
                    ),
                  ]
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}