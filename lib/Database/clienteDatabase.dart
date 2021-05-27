import 'package:toma_de_lectura/Database/databaseProvider.dart';
import 'package:toma_de_lectura/Models/clienteModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';

class ClienteDatabase {
  final prefs = new Preferences();

  final dbprovider = DatabaseProvider.db;

  insertarCliente(ClienteModel clienteModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Cliente (id_cliente,tipo_usuario,nombre_cliente,nromedidor,id_sucursal,"
          "id_estado_servicio,tipo_servicio,nombre_sucursal,id_sector,id_manzana,nro_lote,nro_sublote,"
          "descripcion_urba,descripcion_corta,descripcion_calle,nro_calle,cod_ruta_distribucion,nro_orden_ruta_distribucion,"
          "catetarifa,unidades_uso,actividad,tipo_promedio, lectura_anterior,lectura_ultima,consumo,situacion_medidor,"
          "consumo_facturacion,importe_mes_deuda,importe_deuda,importe_deuda_refinanci,fecha_corte)"
          "VALUES('${clienteModel.idcliente}','${clienteModel.tipousuario}', '${clienteModel.nombreCliente}','${clienteModel.nroMedidor}',"
          "'${clienteModel.idsucursal}','${clienteModel.idestadoservicio}','${clienteModel.tiposervicio}','${clienteModel.nombreSucusal}',"
          "'${clienteModel.idsector}', '${clienteModel.idmanzana}','${clienteModel.nrolote}',"
          "'${clienteModel.nrosublote}', '${clienteModel.descripcionurba}','${clienteModel.descripcioncorta}',"
          "'${clienteModel.descripcioncalle}', '${clienteModel.nrocalle}','${clienteModel.codrutadistribucion}',"
          "'${clienteModel.nroordenrutadist}', '${clienteModel.catetarifa}','${clienteModel.unidadesUso}',"
          "'${clienteModel.actividad}', '${clienteModel.tipopromedio}','${clienteModel.lecturaanterior}',"
          "'${clienteModel.lecturaultima}', '${clienteModel.consumo}','${clienteModel.situaciomed}',"
          "'${clienteModel.consumoFactura}','${clienteModel.importeMesDeuda}','${clienteModel.importeDeuda}',"
          "'${clienteModel.importeDeudaRefin}', '${clienteModel.fechacorte}')"
         
          );
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<ClienteModel>> obtenerCliente() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Cliente");

    List<ClienteModel> list =
        res.isNotEmpty ? res.map((c) => ClienteModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<ClienteModel>> obtenerClientePorIdCliente(String idCliente) async {
    final idInspector = prefs.idUser;
    final idsede = prefs.idsede;
    final idciclo = prefs.idCiclo;
    final idempresa = prefs.idEmpresa;
    final db = await dbprovider.database;
    final res = await db
        .rawQuery("SELECT * FROM Cliente where id_cliente='$idCliente'");

    List<ClienteModel> list =
        res.isNotEmpty ? res.map((c) => ClienteModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<ClienteModel>> obtenerLecturaPorIdLectura(
      String idLectura) async {
    final db = await dbprovider.database;
    final res = await db
        .rawQuery("SELECT * FROM Lectura where idLectura='$idLectura' ");

    List<ClienteModel> list =
        res.isNotEmpty ? res.map((c) => ClienteModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<ClienteModel>> obtenerSector() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery(
        "SELECT * FROM Lectura GROUP BY idSucursal,idSector,nombre_sector "
        "ORDER BY idSucursal,idSector,nombre_sector");

    List<ClienteModel> list =
        res.isNotEmpty ? res.map((c) => ClienteModel.fromJson(c)).toList() : [];
    print(list);
    return list;
  }

  Future<List<ClienteModel>> obtenerSecuencia() async {
    final db = await dbprovider.database;

    final res =
        await db.rawQuery("SELECT * FROM Lectura WHERE estado_lectura_interna = '0'"
            "ORDER BY estado_lectura_interna");
    //print(res);
    List<ClienteModel> list =
        res.isNotEmpty ? res.map((c) => ClienteModel.fromJson(c)).toList() : [];

    return list;
  }

// updateLecturaDb(ClienteModel carrito)async{
  //   final db = await dbprovider.database;

  //   final res = await db.rawUpdate("UPDATE Lectura SET " 
  //   "estado_lectura_interna='${carrito.estadoLecturaInterna}', "
  //   "estadolectura='${carrito.estadolectura}' "
  //   "WHERE ordenenvio = '${carrito.ordenenvio}' " 
  //   );

  //   return res;
  // }

  

}
