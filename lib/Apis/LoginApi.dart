import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/constants.dart';

class LoginApi {
  final prefs = new Preferences();

  Future<int> login(String user, String pass) async {
    try {
      final  url = '$apiBaseURL/inspectores';

      final resp = await http.post(Uri.parse(url));

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];

      if (code == 1) {
        //final prodTemp = Data.fromJson(decodedData['data']);

        //agrego los datos de usuario al sharePreferences
        prefs.idUser = decodedData['data']['c_u'];
        prefs.idPerson = decodedData['data']['c_p'];
        prefs.userNickname = decodedData['data']['_n'];
        prefs.userEmail = decodedData['data']['u_e'];
        prefs.userImage = decodedData['data']['u_i'];
        prefs.personName = decodedData['data']['p_n'];
        prefs.personSurname = decodedData['data']['p_s'];
        prefs.idRoleUser = decodedData['data']['ru'];
        prefs.roleName = decodedData['data']['rn'];
        prefs.token = decodedData['data']['tn'];

        return code;
      } else {
        return code;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 0;
    }
  }
}
