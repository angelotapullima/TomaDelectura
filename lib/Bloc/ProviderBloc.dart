import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ciclos_bloc.dart';
import 'package:toma_de_lectura/Bloc/lecturaBloc.dart';
import 'package:toma_de_lectura/Bloc/loginBloc.dart';
import 'package:toma_de_lectura/Bloc/sedesBloc.dart';
import 'package:toma_de_lectura/Bloc/tiposEstadoMedidor.dart';

class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  final loginBloc = LoginBloc();
  final sedesBloc = SedesBloc();
  final ciclosBloc = CiclosBloc();
  final lecturaBloc = LecturaBloc();
  final tipoEstadoMedidorBloc = TipoEstadoMedidorBloc();
  

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }

    return _instancia;
  }

  ProviderBloc._internal({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(ProviderBloc oldWidget) => true;

  static LoginBloc login(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .loginBloc;
  }

  static SedesBloc sedes(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .sedesBloc;
  }

  static CiclosBloc ciclo(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .ciclosBloc;
  }

  static LecturaBloc lectura(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .lecturaBloc;
  }

  static TipoEstadoMedidorBloc tipoMedidor(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .tipoEstadoMedidorBloc;
  }
}
