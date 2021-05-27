class ClienteModel {
  ClienteModel({
    this.tipousuario,
    this.idsucursal,
    this.nombreSucusal,
    this.idsector,
    this.idmanzana,
    this.nrolote,
    this.nrosublote,
    this.idcliente,
    this.nombreCliente,
    this.descripcionurba,
    this.descripcioncorta,
    this.descripcioncalle,
    this.nrocalle,
    this.codrutadistribucion,
    this.nroordenrutadist,
    this.idestadoservicio,
    this.tiposervicio,
    this.catetarifa,
    this.unidadesUso,
    this.actividad,
    this.nroMedidor,
    this.tipopromedio,
    this.lecturaanterior,
    this.lecturaultima,
    this.consumo,
    this.situaciomed,
    this.consumoFactura,
    this.importeMesDeuda,
    this.importeDeuda,
    this.importeDeudaRefin,
    this.fechacorte,
  });

  String tipousuario;
  String idsucursal;
  String nombreSucusal;
  String idsector;
  String idmanzana;
  String nrolote;
  String nrosublote;
  String idcliente;
  String nombreCliente;
  String descripcionurba;
  String descripcioncorta;
  String descripcioncalle;
  String nrocalle;
  String codrutadistribucion;
  String nroordenrutadist;
  String idestadoservicio;
  String tiposervicio;
  String catetarifa;
  String unidadesUso;
  String actividad;
  String nroMedidor;
  String tipopromedio;
  String lecturaanterior;
  String lecturaultima;
  String consumo;
  String situaciomed;
  String consumoFactura;
  String importeMesDeuda;
  String importeDeuda;
  String importeDeudaRefin;
  String fechacorte;

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        tipousuario: json["tipo_usuario"],
        idsucursal: json["id_sucursal"],
        nombreSucusal: json["nombre_sucursal"],
        idsector: json["id_sector"],
        idmanzana: json["id_manzana"],
        nrolote: json["nro_lote"],
        nrosublote: json["nro_sublote"],
        idcliente: json["id_cliente"],
        nombreCliente: json["nombre_cliente"],
        descripcionurba: json["descripcion_urba"],
        descripcioncorta: json["descripcion_corta"],
        descripcioncalle: json["descripcion_calle"],
        nrocalle: json["nro_calle"],
        codrutadistribucion: json["cod_ruta_distribucion"],
        nroordenrutadist: json["nro_orden_ruta_distribucion"],
        idestadoservicio: json["id_estado_servicio"],
        tiposervicio: json["tipo_servicio"],
        catetarifa: json["catetarifa"],
        unidadesUso: json["unidades_uso"],
        actividad: json["actividad"],
        nroMedidor: json["nromedidor"],
        tipopromedio: json["tipo_promedio"],
        lecturaanterior: json["lectura_anterior"],
        lecturaultima: json["lectura_ultima"],
        consumo: json["consumo"],
        situaciomed: json["situacion_medidor"],
        consumoFactura: json["consumo_facturacion"],
        importeMesDeuda: json["importe_mes_deuda"],
        importeDeuda: json["importe_deuda"],
        importeDeudaRefin: json["importe_deuda_refinanci"],
        fechacorte: json["fecha_corte"],
      );

  Map<String, dynamic> toJson() => {
        "tipousuario": tipousuario,
        "idsucursal": idsucursal,
        "suc": nombreSucusal,
        "idsector": idsector,
        "idmanzana": idmanzana,
        "nrolote": nrolote,
        "nrosublote": nrosublote,
        "idcliente": idcliente,
        "nombreCliente": nombreCliente,
        "descripcionurba": descripcionurba,
        "descripcioncorta": descripcioncorta,
        "descripcioncalle": descripcioncalle,
        "nrocalle": nrocalle,
        "codrutadistribucion": codrutadistribucion,
        "nroordenrutadist": nroordenrutadist,
        "idestadoservicio": idestadoservicio,
        "tiposervicio": tiposervicio,
        "catetarifa": catetarifa,
        "unidades_uso": unidadesUso,
        "actividad": actividad,
        "nroMedidor": nroMedidor,
        "tipopromedio": tipopromedio,
        "lecturaanterior": lecturaanterior,
        "lecturaultima": lecturaultima,
        "consumo": consumo,
        "situaciomed": situaciomed,
        "consumoFactura": consumoFactura,
        "ImporteMesDeuda": importeMesDeuda,
        "ImpDeuda": importeDeuda,
        "ImporteDeudaRefin": importeDeudaRefin,
        "fechacorte": fechacorte,
      };
}
