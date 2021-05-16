


import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:toma_de_lectura/Database/estado_medidor_database.dart';
import 'package:toma_de_lectura/Models/tipoMedidorModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:toma_de_lectura/utils/constants.dart';

class TipoEstadoMedidorApi{



  final prefs = new Preferences();
  final tiposMedidorDatabase = TipoEstadoMedidorDatabase();

  Future<http.Response> okHttp(String url) async {
    //

    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);

    final response = await ioClient.get(
      Uri.parse('$url'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        //HttpHeaders.authorizationHeader: '',
      },
      //body: currencyRequestToJson(post)
    );
    return response;
  }

  Future<bool> obtenerEstadoMedidor() async {
    try {
      final url = '$apiBaseURL/tipoestmedidor';
      final resp = await okHttp(url);

      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          TipoEstadoMedidorModel tipoMedidorModel = TipoEstadoMedidorModel();

          tipoMedidorModel.estadoMedidor = decodedData[i]['estadomed'];
          tipoMedidorModel.descripcion = decodedData[i]['descripcion'];
          tipoMedidorModel.impedimento = decodedData[i]['impedimento'];
          tipoMedidorModel.promedioAuto = decodedData[i]['promedioauto'];
          tipoMedidorModel.permiteLectura = decodedData[i]['permitelectura'];
          tipoMedidorModel.estadoRegistroMov = decodedData[i]['estregmov'];
          await tiposMedidorDatabase.insertarTiposMedidor(tipoMedidorModel);
        }

        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }




}