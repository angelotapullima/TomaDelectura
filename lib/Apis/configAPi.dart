import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:toma_de_lectura/Database/sedeDatabase.dart';
import 'package:toma_de_lectura/Models/sedesModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/constants.dart';

class ConfigApi {
  final prefs = new Preferences();
  final sedesDatabase = SedesDatabase();

  Future<http.Response> obtenerSedesHttp() async {
    final url = '$apiBaseURL/sedeoperacional';

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

  Future<bool> obtenerSedes() async {
    try {
      final resp = await obtenerSedesHttp();

      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          SedesModel sedesModel = SedesModel();

          sedesModel.idSede = decodedData[i]['codsede'];
          sedesModel.idEmpresa = decodedData[i]['codemp'];
          sedesModel.nombreSede = decodedData[i]['nombre'];
          await sedesDatabase.insertarSedes(sedesModel);
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
