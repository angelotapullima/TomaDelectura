class InspectorModel {
  InspectorModel({
    this.idsede,
    this.idinspector,
    this.nombres,
    this.dni,
    this.fechareg,
    this.usuario,
    //this.clave,
    this.asignadoareclamos,
    this.asignadoalectura,
    this.asignadoacortes,
    this.asignadocatastro,
    this.asignadoinspecciones,
    this.asignadoconsultas,
    this.supervisor,
    this.idempresa,
    this.idsede1,
    this.estareg,
  });

  String idsede;
  String idinspector;
  String nombres;
  String dni;
  String fechareg;
  String usuario;
 // String clave;
  String asignadoareclamos;
  String asignadoalectura;
  String asignadoacortes;
  String asignadocatastro;
  String asignadoinspecciones;
  String asignadoconsultas;
  String supervisor;
  String idempresa;
  String idsede1;
  String estareg;

  factory InspectorModel.fromJson(Map<String, dynamic> json) => InspectorModel(
        idsede: json["id_sede"],
        idinspector: json["id_inspector"],
        nombres: json["inspector_nombre"],
        dni: json["inspector_dni"],
        fechareg: json["inspector_fecha_registro"],
        usuario: json["inspector_usuario"],
        //clave: json["inspector_clave"],
        asignadoareclamos: json["inspector_asignado_reclamo"],
        asignadoalectura: json["inspector_asignado_lectura"],
        asignadoacortes: json["inspector_asignado_corte"],
        asignadocatastro: json["inspector_asignado_catastro"],
        asignadoinspecciones: json["inspector_asignado_inspecciones"],
        asignadoconsultas: json["inspector_asignado_consulta"],
        supervisor: json["inspector_supervisor"],
        idempresa: json["inspector_codigo_empresa"],
        idsede1: json["inspector_codigo_sede_1"],
        estareg: json["inspector_estado_registro"],
      );
}
