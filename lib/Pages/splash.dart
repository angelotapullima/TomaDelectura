import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toma_de_lectura/Apis/configAPi.dart';
import 'package:toma_de_lectura/Apis/estadoMedidorApi.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final preferences = Preferences();

      final configApi = ConfigApi();
      configApi.obtenerCiclos();
      configApi.obtenerSedes();

      final estadoMedidorApi = TipoEstadoMedidorApi();
      estadoMedidorApi.obtenerEstadoMedidor();

      if (preferences.idUser.toString().isEmpty || preferences.idUser == null) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'home');
      }
      /*if (preferences.estadoCargaInicial == null ||
        preferences.estadoCargaInicial == '0') {
      //await configApi.obtenerConfig();

      preferences.estadoCargaInicial = '1';
    } else {
      configApi.obtenerConfig();
    }

    if (preferences.idUser.toString().isEmpty || preferences.idUser == null) {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      if (preferences.ciudadID == null) {
        Navigator.pushReplacementNamed(context, 'seleccionarCiudad');
      } else {
        Navigator.pushReplacementNamed(context, 'home');
      }
    } */
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /* Container(
              height: double.infinity,
              width: double.infinity,
              child: Image(
                image: AssetImage('assets/images/logo_sedaayacucho.png'),
                fit: BoxFit.cover,
              )), */
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(.5),
          ),
          Center(
            child: Container(
              child: SvgPicture.asset(
                'assets/images/logo_sedaayacucho.png',
              ),
            ),
          ),
          Center(
            child: CupertinoActivityIndicator(),
          ),
        ],
      ),
    );
  }
}
