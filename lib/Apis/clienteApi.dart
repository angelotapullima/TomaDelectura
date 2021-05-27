import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:toma_de_lectura/Database/clienteDatabase.dart';
import 'package:toma_de_lectura/Models/clienteModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/constants.dart';

class ClienteApi {
  final prefs = Preferences();
  final clienteDb = ClienteDatabase();

  Future<int> cliente(String idcliente) async {
    final String idInspector = prefs.idUser;
    final String empresa = prefs.idEmpresa;
    final String sede = prefs.idsede;
    final String ciclo = prefs.idCiclo;

    //final String idcliente = '20173657';

    try {
      final url = "$apiBaseURL/cliente";

      final resp = await http.post(url, body: {
        'codcliente':'$idcliente'
      });

      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          final clienteModel = ClienteModel();

          clienteModel.idcliente = decodedData[0]["codcliente"];
          clienteModel.tipousuario = decodedData[0]["tipousuario"];
          clienteModel.idsucursal = decodedData[0]["codsuc"];
          clienteModel.nombreSucusal = decodedData[0]["suc"];
          clienteModel.idsector = decodedData[0]["codsector"];
          clienteModel.idmanzana = decodedData[0]["codmza"];
          clienteModel.nrolote = decodedData[0]["nrolote"];
          clienteModel.nrosublote = decodedData[0]["nrosublote"];
          clienteModel.nombreCliente = decodedData[0]["propietario"];
          clienteModel.descripcionurba = decodedData[0]["descripcionurba"];
          clienteModel.descripcioncorta = decodedData[0]["descripcioncorta"];
          clienteModel.descripcioncalle = decodedData[0]["descripcioncalle"];
          clienteModel.nrocalle = decodedData[0]["nrocalle"];
          clienteModel.codrutadistribucion =
              decodedData[0]["codrutadistribucion"];
          clienteModel.nroordenrutadist = decodedData[0]["nroordenrutadist"];
          clienteModel.idestadoservicio = decodedData[0]["idestadoservicio"];
          clienteModel.tiposervicio = decodedData[0]["tiposervicio"];
          clienteModel.catetarifa = decodedData[0]["catetar"];
          clienteModel.unidadesUso = decodedData[0]["unidades_uso"];
          clienteModel.actividad = decodedData[0]["actividad"];
          clienteModel.nroMedidor = decodedData[0]["nromed"];
          clienteModel.tipopromedio = decodedData[0]["tipopromedio"];
          clienteModel.lecturaanterior = decodedData[0]["lecturaanterior"];
          clienteModel.lecturaultima = decodedData[0]["lecturaultima"];
          clienteModel.consumo = decodedData[0]["consumo"];
          clienteModel.situaciomed = decodedData[0]["situaciomed"];
          clienteModel.consumoFactura = decodedData[0]["consumofac"];
          clienteModel.importeMesDeuda = decodedData[0]["ImpMesDeuda"];
          clienteModel.importeDeuda = decodedData[0]["ImpDeuda"];
          clienteModel.importeDeudaRefin = decodedData[0]["ImpDeudaRefin"];
          clienteModel.fechacorte = decodedData[0]["fechacorte"];

          await clienteDb.insertarCliente(clienteModel);
        }

        return 1;
      } else {
        return 0;
      }
    } catch (error, stacktrace) {
      print("Exception occured= stackTrace=trace");
      return 0;
    }
  }
}
