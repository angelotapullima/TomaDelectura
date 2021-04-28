








import 'package:rxdart/rxdart.dart';
import 'package:toma_de_lectura/Apis/configAPi.dart';
import 'package:toma_de_lectura/Database/ciclo_database.dart';
import 'package:toma_de_lectura/Models/ciclosModel.dart';


class CiclosBloc{
  


  final configApi = ConfigApi();
  final ciclosDatabase = CiclosDatabase();

  final _ciclosController = BehaviorSubject<List<CiclosModel>>();

  Stream<List<CiclosModel>> get ciclosStream => _ciclosController.stream;

  dispose() {
    _ciclosController?.close();
  }

  void obtenerCiclos() async {
    _ciclosController.sink.add(await ciclosDatabase.obtenerCiclos());
    await configApi.obtenerCiclos();
    _ciclosController.sink.add(await ciclosDatabase.obtenerCiclos());
  }
 
}
