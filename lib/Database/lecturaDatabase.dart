import 'package:toma_de_lectura/Database/databaseProvider.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';

class LecturaDatabase {
  final prefs = new Preferences();

  final dbprovider = DatabaseProvider.db;

  insertarLectura(LecturaModel lecturaModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Lectura (idLectura,idEmpresa,idSede,idSucursal,idSector,idCliente,idInspectormovil,propietario,"
          "estadoservicio,catetar,direccion,codrutalectura,nroordenrutalect,codrutadistribucion,"
          "nroordenrutadist,codmza,nrolote,nrosublote,catastro,nromedidor,estadolectura,lecturaanterior,"
          "fechalecturaultima,lecturaultima,lecturapromedio,consumo,tipopromedio,"
          "fechahoraregistro,nrodias,ordenenvio,valorconsumoexc,codurbaso,web,fechamovil,obslectura,"
          "idciclo,altoconsumo,situacionmed,variasunidadesuso,unid_tarifa,mostrarlectant,"
          "registrado,latitud,longitud,img_base64,tiposervicio,estadomed,anio,mes,"
          "padroncritica,c_permitemodif,nombre_sector,vivhabitada, estado_lectura_interna,"
          "estado_enviado,fecha_lectura) "
          "VALUES('${lecturaModel.idLectura}','${lecturaModel.idEmpresa}', '${lecturaModel.idSede}','${lecturaModel.idSucursal}',"
          "'${lecturaModel.idSector}','${lecturaModel.idCliente}','${lecturaModel.idInspectorMovil}','${lecturaModel.propietario}',"
          "'${lecturaModel.estadoservicio}', '${lecturaModel.catetar}','${lecturaModel.direccion}',"
          "'${lecturaModel.codrutalectura}', '${lecturaModel.nroordenrutalect}','${lecturaModel.codrutadistribucion}',"
          "'${lecturaModel.nroordenrutadist}', '${lecturaModel.codmza}','${lecturaModel.nrolote}',"
          "'${lecturaModel.nrosublote}', '${lecturaModel.catastro}','${lecturaModel.nromedidor}',"
          "'${lecturaModel.estadolectura}', '${lecturaModel.lecturaanterior}','${lecturaModel.fechalecturaultima}',"
          "'${lecturaModel.lecturaultima}', '${lecturaModel.lecturapromedio}','${lecturaModel.consumo}',"
          "'${lecturaModel.tipopromedio}','${lecturaModel.fechahoraregistro}','${lecturaModel.nrodias}',"
          "'${lecturaModel.ordenenvio}', '${lecturaModel.valorconsumoexc}','${lecturaModel.codurbaso}',"
          "'${lecturaModel.web}', '${lecturaModel.fechamovil}','${lecturaModel.obslectura}',"
          "'${lecturaModel.idciclo}', '${lecturaModel.altoconsumo}','${lecturaModel.situacionmed}',"
          "'${lecturaModel.variasunidadesuso}', '${lecturaModel.unidTarifa}','${lecturaModel.mostrarlectant}',"
          "'${lecturaModel.registrado}', '${lecturaModel.latitud}','${lecturaModel.longitud}',"
          "'${lecturaModel.imgBase64}', '${lecturaModel.tiposervicio}','${lecturaModel.estadomed}',"
          "'${lecturaModel.anio}', '${lecturaModel.mes}','${lecturaModel.padroncritica}',"
          "'${lecturaModel.cPermitemodif}','${lecturaModel.nombreSector}',"
          " '${lecturaModel.vivhabitada}', '${lecturaModel.estadoLecturaInterna}', '${lecturaModel.estadoEnviado}', '${lecturaModel.fechaLectura}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<LecturaModel>> obtenerLectura() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Lectura");

    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<LecturaModel>> obtenerLecturaPorIdIsnpector() async {
    final idInspector = prefs.idUser;
    final db = await dbprovider.database;
    final res = await db
        .rawQuery("SELECT * FROM Lectura where idInspectormovil='$idInspector' ");

    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<LecturaModel>> obtenerLecturaPorIdLectura(
      String idLectura) async {
    final db = await dbprovider.database;
    final res = await db
        .rawQuery("SELECT * FROM Lectura where idLectura='$idLectura' ");

    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<LecturaModel>> obtenerSector() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery(
        "SELECT * FROM Lectura GROUP BY idSucursal,idSector,nombre_sector "
        "ORDER BY idSucursal,idSector,nombre_sector");

    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];
    print(list);
    return list;
  }

  Future<List<LecturaModel>> obtenerSecuencia() async {
    final db = await dbprovider.database;

    final res =
        await db.rawQuery("SELECT * FROM Lectura WHERE estado_lectura_interna = '0'"
            "ORDER BY estado_lectura_interna");
    //print(res);
    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];

    return list;
  }

/* 
  Future<List<LecturaModel>> obtenerResumen() async {
    final db = await dbprovider.database;

    final String idInspector = prefs.idUser;
    final String idempresa = prefs.idEmpresa;
    final String idciclo = prefs.idCiclo;
    // final String anio = prefs.anio;
    // final String mes = prefs.mes;
    final res = await db.rawQuery("SELECT *, "
        "SUM((case when web = '1' then '1' else '0' end)), "
        "SUM((case when web = '0' then '1' else '0' end)),COUNT(idCliente)"
        "FROM Lectura WHERE idEmpresa='$idempresa' "
        "AND idciclo LIKE '%$idciclo%' AND anio='2021' AND mes='05'"
        " AND idSucursal LIKE '%'AND idCliente>='0' AND idInspectormovil='$idInspector'"
        " GROUP BY idSucursal,idSector,nombre_sector "
        " ORDER BY idSucursal,idSector,nombre_sector");
    //print(res);
    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];
    print(list);
    return list;
  }

   */
  Future<List<LecturaModel>> obtenerRegistrosFaltantes() async {
    final db = await dbprovider.database;

    final res =
        await db.rawQuery("SELECT * FROM Lectura WHERE estado_lectura_interna = '0'");
    //print(res);
    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<LecturaModel>> obtenerRegistrosTerminados() async {
    final db = await dbprovider.database;

    final res =
        await db.rawQuery("SELECT * FROM Lectura WHERE estado_lectura_interna = '1'");
    //print(res);
    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];

    return list;
  }

//obtener detalle de la lectura por numero se secuencia, idcliente,medidor
  Future<List<LecturaModel>> consultarDetalleLectura(
      String numeroSecuencia, String codCliente, String nmedidor) async {
    try {
      final db = await dbprovider.database;
      final res = await db.rawQuery(
          "SELECT * FROM Lectura WHERE nromedidor ='$nmedidor' or idCliente='$codCliente' or ordenenvio='$numeroSecuencia'");

      List<LecturaModel> list = res.isNotEmpty
          ? res.map((c) => LecturaModel.fromJson(c)).toList()
          : [];

      return list;
    } catch (e) {
      print(" $e Error en la base de datossss");
      print(e);
      return [];
    }
  }

  // para la busqueda por número de secuencia
  Future<List<LecturaModel>> consultarRegistroPorSecuencia(String query) async {
    try {
      final db = await dbprovider.database;
      final res = await db
          .rawQuery("SELECT * FROM Lectura WHERE ordenenvio LIKE '%$query%'");

      List<LecturaModel> list = res.isNotEmpty
          ? res.map((c) => LecturaModel.fromJson(c)).toList()
          : [];

      return list;
    } catch (e) {
      print(" $e Error en la base de datossss");
      print(e);
      return [];
    }
  }

  //busqueda por id del cliente
  Future<List<LecturaModel>> consultarRegistroPorCliente(String query) async {
    try {
      final db = await dbprovider.database;
      final res = await db
          .rawQuery("SELECT * FROM Lectura WHERE idCliente LIKE '%$query%'");

      List<LecturaModel> list = res.isNotEmpty
          ? res.map((c) => LecturaModel.fromJson(c)).toList()
          : [];

      return list;
    } catch (e) {
      print(" $e Error en la base de datossss");
      print(e);
      return [];
    }
  }

  //Se utiliza para la busqueda por número de medidor
  Future<List<LecturaModel>> consultarRegistroPorMedidor(String query) async {
    try {
      final db = await dbprovider.database;
      final res = await db
          .rawQuery("SELECT * FROM Lectura WHERE nromedidor LIKE '%$query%'");

      List<LecturaModel> list = res.isNotEmpty
          ? res.map((c) => LecturaModel.fromJson(c)).toList()
          : [];

      return list;
    } catch (e) {
      print(" $e Error en la base de datossss");
      print(e);
      return [];
    }
  }



  updateLecturaDb(LecturaModel carrito)async{
    final db = await dbprovider.database;

    final res = await db.rawUpdate("UPDATE Lectura SET " 
    "estado_lectura_interna='${carrito.estadoLecturaInterna}', "
    "estadolectura='${carrito.estadolectura}' "
    "WHERE ordenenvio = '${carrito.ordenenvio}' " 
    );

    return res;
  }

  

}
