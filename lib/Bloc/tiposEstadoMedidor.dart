



import 'package:rxdart/rxdart.dart';
import 'package:toma_de_lectura/Apis/estadoMedidorApi.dart';
import 'package:toma_de_lectura/Database/estado_medidor_database.dart';
import 'package:toma_de_lectura/Models/tipoMedidorModel.dart';

class TipoEstadoMedidorBloc{
  


  final tipoEstadoMedidorApi = TipoEstadoMedidorApi();
  final tipoEstadoMedidorDatabase=TipoEstadoMedidorDatabase();

  final _tipoEstadoMedidorController = BehaviorSubject<List<TipoEstadoMedidorModel>>();

  Stream<List<TipoEstadoMedidorModel>> get tiposEstadoMedidorStream => _tipoEstadoMedidorController.stream;

  dispose() {
    _tipoEstadoMedidorController?.close();
  }

  void obtenerTipoEstadoMedidor() async {
    _tipoEstadoMedidorController.sink.add(await tipoEstadoMedidorDatabase.obtenerTiposMedidor());
    /* await tipoEstadoMedidorApi.obtenerEstadoMedidor();
    _tipoEstadoMedidorController.sink.add(await tipoEstadoMedidorDatabase.obtenerTiposMedidor()); */
  }
 
}
