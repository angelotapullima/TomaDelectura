import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/loginBloc.dart';

class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  final loginBloc = LoginBloc();
  

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
}
