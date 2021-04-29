

import 'package:toma_de_lectura/Database/databaseProvider.dart';
import 'package:toma_de_lectura/Models/inspectoresModel.dart';


class InspectorDatabase{

   final dbprovider = DatabaseProvider.db;

  insertarInspector(InspectorModel inspectorModel)async{
    try{
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Inspector (id_inspector,id_sede,inspector_dni,inspector_nombre,inspector_fecha_registro,inspector_usuario,"
          "inspector_asignado_reclamo,inspector_asignado_lectura,inspector_asignado_corte,inspector_asignado_catastro,"
          "inspector_asignado_inspecciones,inspector_asignado_consulta,inspector_supervisor,inspector_codigo_empresa,"
          "inspector_codigo_sede_1,inspector_estado_registro) "
          "VALUES('${inspectorModel.idinspector}', '${inspectorModel.idsede}','${inspectorModel.dni}',"
          "'${inspectorModel.nombres}','${inspectorModel.fechareg}','${inspectorModel.usuario}',"
          "'${inspectorModel.asignadoareclamos}', '${inspectorModel.asignadoalectura}','${inspectorModel.asignadoacortes}',"
          "'${inspectorModel.asignadocatastro}', '${inspectorModel.asignadoinspecciones}','${inspectorModel.asignadoconsultas}',"
          "'${inspectorModel.supervisor}', '${inspectorModel.idempresa}','${inspectorModel.idsede1}',"
          " '${inspectorModel.estareg}')");
      return res;

    }catch(exception){
      print(exception);
    }
  }

  Future<List<InspectorModel>> obtenerinspectorModel() async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Inspector");

    List<InspectorModel> list = res.isNotEmpty
        ? res.map((c) => InspectorModel.fromJson(c)).toList()
        : [];

    return list;
  }
}