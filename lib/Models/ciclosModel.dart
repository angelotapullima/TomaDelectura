class CiclosModel {
  String idCiclo;
  String idEmpresa;
  String cicloDescripcion;
  String anio;
  String mes;

  CiclosModel({
    this.idCiclo,
    this.idEmpresa,
    this.cicloDescripcion,
    this.anio,
    this.mes
  });

  factory CiclosModel.fromJson(Map<String, dynamic> json) => CiclosModel(
        idCiclo: json["id_ciclo"],
        idEmpresa: json["id_empresa"],
        cicloDescripcion: json["ciclo_descripcion"],
        anio: json["anio"],
        mes:json["mes"],
      );
}
