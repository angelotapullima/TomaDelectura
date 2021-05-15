import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';

class DetalleBusquedaSecuenciaPage extends StatelessWidget {
  const DetalleBusquedaSecuenciaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String secuencia = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Container(
            child: Text(secuencia),)
          
      ),
    );
  }
}
