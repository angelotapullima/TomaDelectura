class LecturaModel {
  LecturaModel({
    this.idLectura,
    this.idEmpresa,
    this.idSede,
    this.idSucursal,
    this.idSector,
    this.idCliente,
    this.idInspectorMovil,
    this.propietario,
    this.estadoservicio,
    this.catetar,
    this.direccion,
    this.codrutalectura,
    this.nroordenrutalect,
    this.codrutadistribucion,
    this.nroordenrutadist,
    this.codmza,
    this.nrolote,
    this.nrosublote,
    this.catastro,
    this.nromedidor,
    this.estadolectura,
    this.lecturaanterior,
    this.fechalecturaultima,
    this.lecturaultima,
    this.lecturapromedio,
    this.consumo,
    this.tipopromedio,
    this.fechahoraregistro,
    this.nrodias,
    this.ordenenvio,
    this.valorconsumoexc,
    this.codurbaso,
    this.web,
    this.fechamovil,
    this.obslectura,
    this.idciclo,
    this.altoconsumo,
    this.situacionmed,
    this.variasunidadesuso,
    this.unidaddom,
    this.unidTarifa,
    this.mostrarlectant,
    this.siinco,
    this.registrado,
    this.latitud,
    this.longitud,
    this.imgBase64,
    this.tiposervicio,
    this.estadomed,
    this.anio,
    this.mes,
    this.padroncritica,
    this.nombreSector,
    this.cPermitemodif,
    this.vivhabitada,
    this.estadoLectura,
    this.estadoEnviado,
    this.fechaLectura,
  });

  String idLectura;
  String idEmpresa;
  String idSede;
  String idSucursal;
  String idSector;
  String idCliente;
  String idInspectorMovil;
  String propietario;
  String estadoservicio;
  String catetar;
  String direccion;
  String codrutalectura;
  String nroordenrutalect;
  String codrutadistribucion;
  String nroordenrutadist;
  String codmza;
  String nrolote;
  String nrosublote;
  String catastro;
  String nromedidor;
  String estadolectura;
  String lecturaanterior;
  String fechalecturaultima;
  String lecturaultima;
  String lecturapromedio;
  String consumo;
  String tipopromedio;
  String fechahoraregistro;
  String nrodias;
  String ordenenvio;
  String valorconsumoexc;
  String codurbaso;
  String web;
  String fechamovil;
  String obslectura;
  String idciclo;
  String altoconsumo;
  String situacionmed;
  String variasunidadesuso;
  String unidaddom;
  String unidTarifa;
  String mostrarlectant;
  String siinco;
  String registrado;
  String latitud;
  String longitud;
  String imgBase64;
  String tiposervicio;
  String estadomed;
  String anio;
  String mes;
  String padroncritica;
  String nombreSector;
  String cPermitemodif;
  String vivhabitada;
  String estadoLectura;
  String estadoEnviado;
  String fechaLectura;

  factory LecturaModel.fromJson(Map<String, dynamic> json) => LecturaModel(
        idLectura: json["idLectura"],
        idEmpresa: json["idEmpresa"],
        idSede: json["idSede"],
        idSucursal: json["idSucursal"],
        idSector: json["idSector"],
        idCliente: json["idCliente"],
        idInspectorMovil: json["codinspectormovil"],
        propietario: json["propietario"],
        estadoservicio: json["estadoservicio"],
        catetar: json["catetar"],
        direccion: json["direccion"],
        codrutalectura: json["codrutalectura"],
        nroordenrutalect: json["nroordenrutalect"],
        codrutadistribucion: json["codrutadistribucion"],
        nroordenrutadist: json["nroordenrutadist"],
        codmza: json["codmza"],
        nrolote: json["nrolote"],
        nrosublote: json["nrosublote"],
        catastro: json["catastro"],
        nromedidor: json["nromedidor"],
        estadolectura: json["estadolectura"],
        lecturaanterior: json["lecturaanterior"],
        fechalecturaultima: json["fechalecturaultima"],
        lecturaultima: json["lecturaultima"],
        lecturapromedio: json["lecturapromedio"],
        consumo: json["consumo"],
        tipopromedio: json["tipopromedio"],
        fechahoraregistro: json["fechahoraregistro"],
        nrodias: json["nrodias"],
        ordenenvio: json["ordenenvio"],
        valorconsumoexc: json["valorconsumoexc"],
        codurbaso: json["codurbaso"],
        web: json["web"],
        fechamovil: json["fechamovil"],
        obslectura: json["obslectura"],
        idciclo: json["idciclo"],
        altoconsumo: json["altoconsumo"],
        situacionmed: json["situacionmed"],
        variasunidadesuso: json["variasunidadesuso"],
        unidTarifa: json["unid_tarifa"],
        mostrarlectant: json["mostrarlectant"],
        siinco: json["siinco"],
        registrado: json["registrado"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        imgBase64: json["img_base64"],
        tiposervicio: json["tiposervicio"],
        estadomed: json["estadomed"],
        anio: json["anio"],
        mes: json["mes"],
        padroncritica: json["padroncritica"],
        nombreSector: json["nombre_sector"],
        cPermitemodif: json["c_permitemodif"],
        vivhabitada: json["vivhabitada"],
        estadoLectura: json["estado_lectura"],
        estadoEnviado: json["estado_enviado"],
        fechaLectura: json["fecha_lectura"],
      );
}
