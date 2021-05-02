import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:toma_de_lectura/Apis/LoginApi.dart';
import 'package:toma_de_lectura/Bloc/validators.dart';

class LoginBloc with Validators {
  final loginApi = LoginApi();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _cargandoLoginController = new BehaviorSubject<bool>();

  //Recuperaer los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarname);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<bool> get cargandoStream => _cargandoLoginController.stream;

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //inserta valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(bool) get changeCargando => _cargandoLoginController.sink.add;

  //obtener el ultimo valor ingresado a los stream
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _cargandoLoginController?.close();
  }

  void cargandoFalse() {
    _cargandoLoginController.sink.add(false);
  }

  Future<bool> login(String user, String pass, String sede) async {
    _cargandoLoginController.sink.add(true);
    final res=await loginApi.login(email, pass, sede);
    _cargandoLoginController.sink.add(false);

    return res;
  }
}
