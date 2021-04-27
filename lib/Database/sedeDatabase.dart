

import 'package:toma_de_lectura/Database/databaseProvider.dart';
import 'package:toma_de_lectura/Models/sedesModel.dart';

class SedesDatabase{


   final dbprovider = DatabaseProvider.db;

  insertarSedes(SedesModel sedes)async{
    try{
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Sedes (idSede,idEmpresa,nombreSede) "
          "VALUES ('${sedes.idSede}','${sedes.idEmpresa}','${sedes.nombreSede}')");
      return res;

    }catch(exception){
      print(exception);
    }
  }

  Future<List<SedesModel>> obtenerSedes() async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Sedes");

    List<SedesModel> list = res.isNotEmpty
        ? res.map((c) => SedesModel.fromJson(c)).toList()
        : [];

    return list;
  }
}