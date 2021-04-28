







class CiclosModel {
  String idCiclo;
  String idEmpresa;
  String cicloDescripcion;

  CiclosModel({
    this.idCiclo,
    this.idEmpresa,
    this.cicloDescripcion,
  });

  factory CiclosModel.fromJson(Map<String, dynamic> json) => CiclosModel(
        idCiclo: json["id_ciclo"],
        idEmpresa: json["id_empresa"],
        cicloDescripcion: json["ciclo_descripcion"],
      );
}
