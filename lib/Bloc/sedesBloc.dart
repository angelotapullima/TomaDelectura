


import 'package:rxdart/rxdart.dart';
import 'package:toma_de_lectura/Apis/configAPi.dart';
import 'package:toma_de_lectura/Database/sedeDatabase.dart';
import 'package:toma_de_lectura/Models/sedesModel.dart';

class SedesBloc{
  


  final configApi = ConfigApi();
  final sedesDatabase = SedesDatabase();

  final _sedesController = BehaviorSubject<List<SedesModel>>();

  Stream<List<SedesModel>> get sedesStream => _sedesController.stream;

  dispose() {
    _sedesController?.close();
  }

  void obtenerSedes() async {
    _sedesController.sink.add(await sedesDatabase.obtenerSedes());
    await configApi.obtenerSedes();
    _sedesController.sink.add(await sedesDatabase.obtenerSedes());
  }
 
}
