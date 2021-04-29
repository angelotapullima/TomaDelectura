import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toma_de_lectura/Database/inspectorDatabase.dart';
import 'package:toma_de_lectura/Models/inspectoresModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/constants.dart';

class LoginApi {
  final prefs = new Preferences();
  final inspectorDb = InspectorDatabase();

  Future<bool> login(String user, String pass) async {
    try {
      final url = '$apiBaseURL/inspectores';

      final resp = await http.post(Uri.parse(url),
          body: {'login': '$user', 'clave': '$pass', 'codsede': '001'});

      final decodedData = json.decode(resp.body);

      //final status = decodedData['status'];

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          final inspectorModel = InspectorModel();

          //agrego los datos de usuario al sharePreferences
          prefs.idUser = decodedData[i]['login'];
          prefs.personName = decodedData[i]['nombres'];
          //Agregamos al modelo de inspectores
          //
          inspectorModel.idsede = decodedData[i]["codsede"];
          inspectorModel.idinspector = decodedData[i]["codinspector"];
          inspectorModel.nombres = decodedData[i]["nombres"];
          inspectorModel.dni = decodedData[i]["dni"];
          inspectorModel.fechareg = decodedData[i]["fechareg"];
          inspectorModel.usuario = decodedData[i]["login"];
          //inspectorModel.clave = decodedData[i]["clave"];
          inspectorModel.asignadoareclamos =
              decodedData[i]["asignadoareclamos"];
          inspectorModel.asignadoalectura = decodedData[i]["asignadoalectura"];
          inspectorModel.asignadoacortes = decodedData[i]["asignadoacortes"];
          inspectorModel.asignadocatastro = decodedData[i]["asignadocatastro"];
          inspectorModel.asignadoinspecciones =
              decodedData[i]["asignadoinspecciones"];
          inspectorModel.asignadoconsultas =
              decodedData[i]["asignadoconsultas"];
          inspectorModel.supervisor = decodedData[i]["supervisor"];
          inspectorModel.idempresa = decodedData[i]["codemp"];
          inspectorModel.idsede1 = decodedData[i]["codsede1"];
          inspectorModel.estareg = decodedData[i]["estareg"];

          await inspectorDb.insertarInspector(inspectorModel);
          
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
