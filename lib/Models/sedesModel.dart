class SedesModel {
  String idSede;
  String idEmpresa;
  String nombreSede;

  SedesModel({this.idSede, this.idEmpresa, this.nombreSede});

  factory SedesModel.fromJson(Map<String, dynamic> json) => SedesModel(
        idSede: json["idSede"],
        idEmpresa: json["idEmpresa"],
        nombreSede: json["nombreSede"],
      );
}
