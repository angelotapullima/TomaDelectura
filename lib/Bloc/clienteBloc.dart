import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:toma_de_lectura/Apis/clienteApi.dart';
import 'package:toma_de_lectura/Database/clienteDatabase.dart';
import 'package:toma_de_lectura/Models/clienteModel.dart';

class ClienteBloc {
  final clienteApi = ClienteApi();
  final clienteDb = ClienteDatabase();

  final _clienteController = BehaviorSubject<List<ClienteModel>>();
  // final _detalleLecturaController = BehaviorSubject<List<ClienteModel>>();
  // final _lecturaPendienteController = BehaviorSubject<List<ClienteModel>>();
  // final _lecturaTerminadaController = BehaviorSubject<List<ClienteModel>>();
  // final _secuenciaController = BehaviorSubject<List<ClienteModel>>();
  // final _sectorController = BehaviorSubject<List<ClienteModel>>();
  // final busquedaXIdClienteController = BehaviorSubject<List<ClienteModel>>();
  // final _cargandoLoginController = new BehaviorSubject<bool>();
  // final busquedaMedidorController = BehaviorSubject<List<ClienteModel>>();
  // final busquedaSecuenciaController = BehaviorSubject<List<ClienteModel>>();

  Stream<List<ClienteModel>> get clienteStream =>
      _clienteController.stream;

  // Stream<List<ClienteModel>> get busquedaXMedidorStream =>
  //     busquedaMedidorController.stream;

  // Stream<List<ClienteModel>> get lecturaStream => _clienteController.stream;
  // Stream<List<ClienteModel>> get detalleLecturaStream =>
  //     _detalleLecturaController.stream;
  // Stream<List<ClienteModel>> get lecturaPendienteStream =>
  //     _lecturaPendienteController.stream;
  // Stream<List<ClienteModel>> get lecturaTerminadaStream =>
  //     _lecturaTerminadaController.stream;
  // Stream<List<ClienteModel>> get sectorStream => _sectorController.stream;

  // Stream<List<ClienteModel>> get busquedaXIdClienteStream =>
  //     busquedaXIdClienteController.stream;
  // Stream<List<ClienteModel>> get secuenciaStream => _secuenciaController.stream;

  dispose() {
    _clienteController?.close();
    // _detalleLecturaController?.close();
    // _lecturaPendienteController?.close();
    // _lecturaTerminadaController?.close();
    // _secuenciaController?.close();
    // _sectorController?.close();
    // busquedaXIdClienteController?.close();
    // busquedaMedidorController?.close();
    // busquedaSecuenciaController?.close();
    // _cargandoLoginController?.close();
  }

  // void cargandoFalse() {
  //   _cargandoLoginController.sink.add(false);
  // }


  void datosCliente(String idcliente) async {
    
    _clienteController.sink.add(await clienteDb.obtenerClientePorIdCliente(idcliente));
    await clienteApi.cliente(idcliente);
    _clienteController.sink.add(await clienteDb.obtenerClientePorIdCliente(idcliente));
    
  }


}
