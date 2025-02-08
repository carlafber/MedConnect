import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// **Proveedor de funciones relacionadas con el inicio de la aplicación.**
///
/// Gestiona la lógica para abrir los cuadros médicos en formato PDF de las diferentes compañías.
class InicioViewModel {
  // Mapa con las URL's de las compañías
  Map<String, String> cuadrosMedicos = {
    'Asisa': 'https://www.asisa.es/empresas/icava/Cuadro_Medico_Valladolid_2011.pdf',
    'Adeslas': 'https://adeslas.numero1salud.es/wp-content/uploads/2024/04/Valladolid-Cuadro-Medico-General.pdf',
    'Caser': 'https://cuadromedico.de/web/viewer.html?file=/Cuadro%20m%C3%A9dico%20Caser%20Valladolid.pdf',
  };

  /// **Método** para abrir el PDF del cuadro médico de la compañía seleccionada
  /// del mapa `cuadrosMedicos`, y si la URL es válida, la abre en el navegador.
  /// Si no, muestra un mensaje de error en la interfaz de usuario.
  ///
  /// @param context → El contexto de la vista desde la cual se invoca el método.
  /// @param compania → El nombre de la compañía cuyo cuadro médico se quiere abrir.

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