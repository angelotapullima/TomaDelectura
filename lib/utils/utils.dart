import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Database/lecturaDatabase.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';

void showToast1(String msg, int duration, ToastGravity gravity) {
  Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration,
      backgroundColor: Colors.grey[300],
      textColor: Colors.black,
      fontSize: 16.0);
}

void cambiarEstadoLectura(BuildContext context, String ordenenvio,
    String lectura, String lecturaInterna) async {
  final lecturaDatabase = LecturaDatabase();
  final lecturaBloc = ProviderBloc.lectura(context);

  LecturaModel lecturaModel = LecturaModel();
  lecturaModel.ordenenvio = ordenenvio;
  lecturaModel.estadolectura = lectura;
  lecturaModel.estadoLecturaInterna = lecturaInterna;

  await lecturaDatabase.updateLecturaDb(lecturaModel);
  lecturaBloc.obtenerDetalleLectura(ordenenvio, '', '');
  lecturaBloc.datosLectura();
  lecturaBloc.lecturasPendientes();
  lecturaBloc.lecturasRegistradas();
  lecturaBloc.obtenerSector();
  lecturaBloc.obtenerDetalleLectura(ordenenvio, '', '');
  showToast1('Registro completado con éxito', 2, ToastGravity.CENTER);
}


