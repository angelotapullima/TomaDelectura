



import 'package:toma_de_lectura/Database/databaseProvider.dart'; 
import 'package:toma_de_lectura/Models/tipoMedidorModel.dart'; 

class TipoEstadoMedidorDatabase{


   final dbprovider = DatabaseProvider.db;

  insertarTiposMedidor(TipoEstadoMedidorModel tipoMedidorModel)async{
    try{
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO EstadoMedidor (estadoMedidor,descripcion,impedimento,promedioAuto, permiteLectura,estadoRegistroMov) "
          "VALUES ('${tipoMedidorModel.estadoMedidor}','${tipoMedidorModel.descripcion}','${tipoMedidorModel.impedimento}','${tipoMedidorModel.promedioAuto}',"
          "'${tipoMedidorModel.permiteLectura}','${tipoMedidorModel.estadoRegistroMov}')");
      return res;

    }catch(exception){
      print(exception);
    }
  }

  Future<List<TipoEstadoMedidorModel>> obtenerTiposMedidor() async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM EstadoMedidor");

    List<TipoEstadoMedidorModel> list = res.isNotEmpty
        ? res.map((c) => TipoEstadoMedidorModel.fromJson(c)).toList()
        : [];

    return list;
  }
}