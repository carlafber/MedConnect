import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class InicioViewModel {
  //Mapa con las URL's de las compañías
  Map<String, String> cuadrosMedicos = {
    'Asisa': 'https://www.asisa.es/empresas/icava/Cuadro_Medico_Valladolid_2011.pdf',
    'Adeslas': 'https://adeslas.numero1salud.es/wp-content/uploads/2024/04/Valladolid-Cuadro-Medico-General.pdf',
    'Caser': 'https://cuadromedico.de/web/viewer.html?file=/Cuadro%20m%C3%A9dico%20Caser%20Valladolid.pdf',
  };

  //Función para abrir el pdf del cuadro médico de la compañia del usuario
  void abrirPDF(BuildContext context, String compania) async{
    String? url = cuadrosMedicos[compania];

    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorCuadro(compania))),
      );
    }
  }
}