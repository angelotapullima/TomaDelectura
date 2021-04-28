





import 'package:toma_de_lectura/Database/databaseProvider.dart';
import 'package:toma_de_lectura/Models/ciclosModel.dart'; 

class CiclosDatabase{


   final dbprovider = DatabaseProvider.db;

  insertarCiclos(CiclosModel ciclos)async{
    try{
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Ciclo (id_ciclo,id_empresa,ciclo_descripcion) "
          "VALUES ('${ciclos.idCiclo}','${ciclos.idEmpresa}','${ciclos.cicloDescripcion}')");
      return res;

    }catch(exception){
      print(exception);
    }
  }

  Future<List<CiclosModel>> obtenerCiclos() async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Ciclo");

    List<CiclosModel> list = res.isNotEmpty
        ? res.map((c) => CiclosModel.fromJson(c)).toList()
        : [];

    return list;
  }
}