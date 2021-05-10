import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:toma_de_lectura/Apis/lecturasApi.dart';
import 'package:toma_de_lectura/Database/lecturaDatabase.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';

class LecturaBloc {
  final lecturaApi = LecturaApi();
  final lecturaDb = LecturaDatabase();

  final _lecturaController = BehaviorSubject<List<LecturaModel>>();
  final _secuenciaController = BehaviorSubject<List<LecturaModel>>();
  final _cargandoLoginController = new BehaviorSubject<bool>();

  
  Stream<List<LecturaModel>> get lecturaStream => _lecturaController.stream;
  Stream<List<LecturaModel>> get secuenciaStream => _secuenciaController.stream;
  // Stream<bool> get cargandoStream => _cargandoLoginController.stream;

  dispose() {
    _lecturaController?.close();
    _secuenciaController?.close();
    _cargandoLoginController?.close();
  }

  void cargandoFalse() {
    _cargandoLoginController.sink.add(false);
  }

  void datosLectura() async {
    _cargandoLoginController.sink.add(true);
    _lecturaController.sink.add(await lecturaDb.obtenerLectura());
    await lecturaApi.lectura();
     _lecturaController.sink.add(await lecturaDb.obtenerLectura());
        _cargandoLoginController.sink.add(false);
  }
  
   void obtenerDatosSecuencia() async {
    _cargandoLoginController.sink.add(true);
    _secuenciaController.sink.add(await lecturaDb.obtenerSecuencia());
  //   await lecturaApi.lectura();
  //  _secuenciaController.sink.add(await lecturaDb.obtenerSecuencia());
        _cargandoLoginController.sink.add(false);
  }
}
