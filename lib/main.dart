import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Pages/busquedas/detalleBusqClientePage.dart';
import 'package:toma_de_lectura/Pages/busquedas/detalleBusqMedidorPage.dart';
import 'package:toma_de_lectura/Pages/busquedas/detalleBusqSecuenciaPage.dart';
import 'package:toma_de_lectura/Pages/homePage.dart';
import 'package:toma_de_lectura/Pages/loginPage.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferences();
  await prefs.initPrefs();
   HttpOverrides.global = new MyHttpOverrides ();
  runApp(MyApp());

}

//Para acceder a la url cuando falla la config de algun certificado ssl
 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final prefs = new Preferences();
    return ProviderBloc(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          //home:  
          initialRoute:(prefs.idUser=="" || prefs.idUser==null)?'login':'home',
          //HomePage(),
          //LoginScreen(),
          routes: {
            "login": (BuildContext context) => LoginScreen(),
            "home": (BuildContext context) => HomePage(),
             "detalleBusquedaSecuencia": (BuildContext context) => DetalleBusquedaSecuenciaPage(),
            "detalleBusquedaMedidor": (BuildContext context) => DetalleBusquedaMedidorPage(),
             "detalleBusquedaCliente": (BuildContext context) => DetalleBusquedaclientePage(),
          }),
    );
  }
}
