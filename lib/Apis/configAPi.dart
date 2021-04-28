import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:toma_de_lectura/Database/ciclo_database.dart';
import 'package:toma_de_lectura/Database/sedeDatabase.dart';
import 'package:toma_de_lectura/Models/ciclosModel.dart';
import 'package:toma_de_lectura/Models/sedesModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/constants.dart';

class ConfigApi {
  final prefs = new Preferences();
  final sedesDatabase = SedesDatabase();
  final ciclosDatabase = CiclosDatabase();

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

  Future<bool> obtenerSedes() async {
    try {
      final url = '$apiBaseURL/sedeoperacional';
      final resp = await okHttp(url);

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




  Future<bool> obtenerCiclos() async {
    try {
      final url = '$apiBaseURL/ciclos';
      final resp = await okHttp(url);

      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          CiclosModel ciclosModel = CiclosModel();

          ciclosModel.idCiclo = decodedData[i]['codciclo'];
          ciclosModel.idEmpresa = decodedData[i]['codemp'];
          ciclosModel.cicloDescripcion = decodedData[i]['descripcion'];
          await ciclosDatabase.insertarCiclos(ciclosModel);
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
