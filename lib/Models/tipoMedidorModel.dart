class TipoEstadoMedidorModel {
  String estadoMedidor;
  String descripcion;
  String impedimento;
  String promedioAuto;
  String permiteLectura;
  String estadoRegistroMov;

  TipoEstadoMedidorModel({
    this.estadoMedidor,
    this.descripcion,
    this.impedimento,
    this.promedioAuto,
    this.permiteLectura,
    this.estadoRegistroMov,
  });

  factory TipoEstadoMedidorModel.fromJson(Map<String, dynamic> json) =>
      TipoEstadoMedidorModel(
        estadoMedidor: json["estadoMedidor"],
        descripcion: json["descripcion"],
        impedimento: json["impedimento"],
        promedioAuto: json["promedioAuto"],
        permiteLectura: json["permiteLectura"],
        estadoRegistroMov: json["estadoRegistroMov"],
      );
}
