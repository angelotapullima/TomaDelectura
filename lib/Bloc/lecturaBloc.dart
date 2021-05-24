import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:toma_de_lectura/Apis/lecturasApi.dart';
import 'package:toma_de_lectura/Database/lecturaDatabase.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';

class LecturaBloc {
  final lecturaApi = LecturaApi();
  final lecturaDb = LecturaDatabase();

  final _lecturaController = BehaviorSubject<List<LecturaModel>>();
  final _detalleLecturaController = BehaviorSubject<List<LecturaModel>>();
  final _lecturaPendienteController = BehaviorSubject<List<LecturaModel>>();
  final _lecturaTerminadaController = BehaviorSubject<List<LecturaModel>>();
  final _secuenciaController = BehaviorSubject<List<LecturaModel>>();
  final _sectorController = BehaviorSubject<List<LecturaModel>>();
  final busquedaXIdClienteController = BehaviorSubject<List<LecturaModel>>();
  final _cargandoLoginController = new BehaviorSubject<bool>();
  final busquedaMedidorController = BehaviorSubject<List<LecturaModel>>();
  final busquedaSecuenciaController = BehaviorSubject<List<LecturaModel>>();

  Stream<List<LecturaModel>> get busquedaXSecuenciaStream =>
      busquedaSecuenciaController.stream;

  Stream<List<LecturaModel>> get busquedaXMedidorStream =>
      busquedaMedidorController.stream;

  Stream<List<LecturaModel>> get lecturaStream => _lecturaController.stream;
  Stream<List<LecturaModel>> get detalleLecturaStream =>
      _detalleLecturaController.stream;
  Stream<List<LecturaModel>> get lecturaPendienteStream =>
      _lecturaPendienteController.stream;
  Stream<List<LecturaModel>> get lecturaTerminadaStream =>
      _lecturaTerminadaController.stream;
  Stream<List<LecturaModel>> get sectorStream => _sectorController.stream;

  Stream<List<LecturaModel>> get busquedaXIdClienteStream =>
      busquedaXIdClienteController.stream;
  Stream<List<LecturaModel>> get secuenciaStream => _secuenciaController.stream;

  dispose() {
    _lecturaController?.close();
    _detalleLecturaController?.close();
    _lecturaPendienteController?.close();
    _lecturaTerminadaController?.close();
    _secuenciaController?.close();
    _sectorController?.close();
    busquedaXIdClienteController?.close();
    busquedaMedidorController?.close();
    busquedaSecuenciaController?.close();
    _cargandoLoginController?.close();
  }

  void cargandoFalse() {
    _cargandoLoginController.sink.add(false);
  }

//Obtner todos los datos de todos los registros
  // void datosLectura() async {
  //   _cargandoLoginController.sink.add(true);
  //   _lecturaController.sink.add(await lecturaDb.obtenerLectura());
  //   await lecturaApi.lectura();
  //   _lecturaController.sink.add(await lecturaDb.obtenerLectura());
  //   _cargandoLoginController.sink.add(false);
  // }

  void datosLectura() async {
    _cargandoLoginController.sink.add(true);
    _lecturaController.sink.add(await lecturaDb.obtenerLecturaPorIdIsnpector());
    await lecturaApi.lectura();
    _lecturaController.sink.add(await lecturaDb.obtenerLecturaPorIdIsnpector());
    _cargandoLoginController.sink.add(false);
  }

//Obtener los datos de la lista general de lecturas 
  Future<List<LecturaModel>> obtnerListaGeneralLecturas() async {
    return await lecturaDb.obtenerLecturaPorIdIsnpector();
    
  }

//Pendientes de registro
  void lecturasPendientes() async {
    _cargandoLoginController.sink.add(true);
    _lecturaPendienteController.sink
        .add(await lecturaDb.obtenerRegistrosFaltantes());
    _cargandoLoginController.sink.add(false);
  }

//Lecturas registradas
  void lecturasRegistradas() async {
    _cargandoLoginController.sink.add(true);
    _lecturaTerminadaController.sink
        .add(await lecturaDb.obtenerRegistrosTerminados());
    _cargandoLoginController.sink.add(false);
  }

  void obtenerSector() async {
    _sectorController.sink.add(await lecturaDb.obtenerSector());
  }

//Datos de la secuencia de registros a tomar lectura
  void obtenerDatosSecuencia() async {
    _cargandoLoginController.sink.add(true);
    _secuenciaController.sink.add(await lecturaDb.obtenerSecuencia());
    _cargandoLoginController.sink.add(false);
  }

  void obtenerDetalleLectura(
      String numeroSecuencia, String codCliente, String nmedidor) async {
    _detalleLecturaController.sink.add(await lecturaDb.consultarDetalleLectura(
        numeroSecuencia, codCliente, nmedidor));
  }

  //Búsqueda por numero de secuencia
  void busquedaPorSecuencia(String query) async {
    _cargandoLoginController.sink.add(true);
    busquedaSecuenciaController.sink
        .add(await lecturaDb.consultarRegistroPorSecuencia(query));
    _cargandoLoginController.sink.add(false);
  }

  //Busqueda por el id del cliente
  void busquedaPorCliente(String query) async {
    _cargandoLoginController.sink.add(true);
    busquedaXIdClienteController.sink
        .add(await lecturaDb.consultarRegistroPorCliente(query));
    // _cargandoLoginController.sink.add(false);
  }

  //Búsqueda por numero de medidor
  void busquedaPorMedidor(String query) async {
    _cargandoLoginController.sink.add(true);
    busquedaMedidorController.sink
        .add(await lecturaDb.consultarRegistroPorMedidor(query));
    _cargandoLoginController.sink.add(false);
  }
}
