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
          "padroncritica,c_permitemodif,nombre_sector,vivhabitada) "
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
          " '${lecturaModel.vivhabitada}')");
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

  Future<List<LecturaModel>> obtenerLecturaXIdInspector() async {
    final String idInspector = prefs.idUser;
    final db = await dbprovider.database;
    final res = await db.rawQuery(
        "SELECT * FROM Lectura where idInspectormovil= '$idInspector'");

    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];
    print(list);
    return list;
  }

  Future<List<LecturaModel>> obtenerSecuencia() async {
    // final String idInspector = prefs.idUser;
    // final String idempresa = prefs.idEmpresa;
    // final String idciclo = prefs.idCiclo;
    final db = await dbprovider.database;
    final res = await db.rawQuery(
        "SELECT min(ordenenvio) FROM Lectura WHERE idEmpresa='001' and idciclo LIKE '%001%' and anio='2021' and mes='05' and idCliente>0 and idInspectormovil='049' and estadolectura<>'000' and web='0' ");

    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];
    print(list);
    return list;
  }

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

  Future<List<LecturaModel>> obtenerRegistrosFaltantes() async {
    final db = await dbprovider.database;

    final String idInspector = prefs.idUser;
    final String idempresa = prefs.idEmpresa;
    final String idCiclo = prefs.idCiclo;
    //final String total;
    // final String anio = prefs.anio;
    // final String mes = prefs.mes;
    final res = await db.rawQuery("SELECT *, "
        "SUM((case when web = '1' then '1' else '0' end)) "
        "FROM Lectura WHERE idEmpresa='$idempresa' "
        "AND idciclo LIKE '%$idCiclo%' AND anio='2021' AND mes='05'"
        " AND idSucursal LIKE '%'AND idCliente>='0' AND idInspectormovil='$idInspector'"
        " GROUP BY idSucursal,idSector,nombre_sector "
        " ORDER BY idSucursal,idSector,nombre_sector");
    //print(res);
    List<LecturaModel> list =
        res.isNotEmpty ? res.map((c) => LecturaModel.fromJson(c)).toList() : [];
    print(list);
    return list;
  }

  Future<List<LecturaModel>> obtenerRegistrosTrabajados() async {
    final db = await dbprovider.database;

    final String idInspector = prefs.idUser;
    final String idempresa = prefs.idEmpresa;
    final String idciclo = prefs.idCiclo;
    // final String anio = prefs.anio;
    // final String mes = prefs.mes;
    final res = await db.rawQuery("SELECT *, "
        "SUM((case when web = '0' then '1' else '0' end)), "
        "COUNT(idCliente)"
        " FROM Lectura WHERE idEmpresa='$idempresa' "
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
}
