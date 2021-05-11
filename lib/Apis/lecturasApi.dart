import 'dart:convert';
import 'package:toma_de_lectura/Database/lecturaDatabase.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/constants.dart';
import 'package:http/http.dart' as http;

class LecturaApi {
  final prefs = new Preferences();
  final lecturaDb = LecturaDatabase();

  Future<int> lectura() async {
    final String idInspector = prefs.idUser;
    final String empresa = prefs.idEmpresa;
    final String sede = prefs.idsede;
    final String ciclo = prefs.idCiclo;

    try {
      final url =
          '$apiBaseURL/emp/$empresa/sede/$sede/inspec/$idInspector/ciclo/$ciclo';

      final resp = await http.get(url);

      final decodedData = json.decode(resp.body);

      // final status = decodedData['status'];

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          final lecturaModel = LecturaModel();

          lecturaModel.idLectura = decodedData[i]["codcliente"];
          lecturaModel.idEmpresa = decodedData[i]["codemp"];
          lecturaModel.idSede = decodedData[i]["codsede"];
          lecturaModel.idSucursal = decodedData[i]["codsuc"];
          lecturaModel.idSector = decodedData[i]["codsector"];
          lecturaModel.idCliente = decodedData[i]["codcliente"];
          lecturaModel.propietario = decodedData[i]["propietario"];
          lecturaModel.estadoservicio = decodedData[i]["estadoservicio"];
          lecturaModel.catetar = decodedData[i]["catetar"];
          lecturaModel.direccion = decodedData[i]["direccion"];
          lecturaModel.codrutalectura = decodedData[i]["codrutalectura"];
          lecturaModel.nroordenrutalect = decodedData[i]["nroordenrutalect"];
          lecturaModel.codrutadistribucion =
              decodedData[i]["codrutadistribucion"];
          lecturaModel.nroordenrutadist = decodedData[i]["nroordenrutadist"];
          lecturaModel.codmza = decodedData[i]["codmza"];
          lecturaModel.nrolote = decodedData[i]["nrolote"];
          lecturaModel.nrosublote = decodedData[i]["nrosublote"];
          lecturaModel.catastro = decodedData[i]["catastro"];
          lecturaModel.nromedidor = decodedData[i]["nromed"];
          lecturaModel.estadolectura = decodedData[i]["estadolectura"];
          lecturaModel.lecturaanterior = decodedData[i]["lecturaanterior"];
          lecturaModel.fechalecturaultima = decodedData[i]["fechalecturault"];
          lecturaModel.lecturaultima = decodedData[i]["lecturaultima"];
          lecturaModel.lecturapromedio = decodedData[i]["lecturapromedio"];
          lecturaModel.consumo = decodedData[i]["consumo"];
          lecturaModel.tipopromedio = decodedData[i]["tipopromedio"];
          lecturaModel.fechahoraregistro = decodedData[i]["fechahoraregistro"];
          lecturaModel.nrodias = decodedData[i]["nrodias"];
          lecturaModel.ordenenvio = decodedData[i]["ordenenvio"];
          lecturaModel.valorconsumoexc = decodedData[i]["valorconsumoexc"];
          lecturaModel.codurbaso = decodedData[i]["codurbaso"];
          lecturaModel.web = decodedData[i]["web"];
          lecturaModel.fechamovil = decodedData[i]["fechamovil"];
          lecturaModel.obslectura = decodedData[i]["obslectura"];
          lecturaModel.idciclo = decodedData[i]["codciclo"];
          lecturaModel.altoconsumo = decodedData[i]["altocon"];
          lecturaModel.situacionmed = decodedData[i]["situacionmed"];
          lecturaModel.variasunidadesuso = decodedData[i]["variasunidadesuso"];
          lecturaModel.unidaddom = decodedData[i]["unidaddom"];
          lecturaModel.unidTarifa = decodedData[i]["unid_tarifa"];
          lecturaModel.mostrarlectant = decodedData[i]["mostrarlectant"];
          lecturaModel.registrado = decodedData[i]["registrado"];
          lecturaModel.latitud = decodedData[i]["latitud"];
          lecturaModel.longitud = decodedData[i]["longitud"];
          lecturaModel.imgBase64 = decodedData[i]["img_base64"];
          lecturaModel.tiposervicio = decodedData[i]["tiposervicio"];
          lecturaModel.estadomed = decodedData[i]["estadomed"];
          lecturaModel.anio = decodedData[i]["anio"];
          lecturaModel.mes = decodedData[i]["mes"];
          lecturaModel.padroncritica = decodedData[i]["padroncritica"];
          lecturaModel.idInspectorMovil = decodedData[i]["codinspectormovil"];
          lecturaModel.cPermitemodif = decodedData[i]["c_permitemodif"];
          lecturaModel.nombreSector = decodedData[i]["nomre_sector"];
          lecturaModel.vivhabitada = decodedData[i]["vivhabitada"];

          await lecturaDb.insertarLectura(lecturaModel);
        }

        return 1;
      } else {
        return 0;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 0;
    }
  }
}
