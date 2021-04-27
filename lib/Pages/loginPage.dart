import 'package:flutter/material.dart';

import 'package:toma_de_lectura/utils/utils.dart' as utils;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/loginBloc.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final loginBloc = ProviderBloc.login(context);
    loginBloc.changeCargando(false);
    return Scaffold(
      body: StreamBuilder(
          stream: loginBloc.cargandoStream,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  _form(context, responsive, loginBloc),
                  (snapshot.data)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              );
            } else {
              return _form(context, responsive, loginBloc);
            }
          }),
    );
  }

  Widget _form(
      BuildContext context, Responsive responsive, LoginBloc loginBloc) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/fondo4.jpg"), fit: BoxFit.cover),
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: <Widget>[
                  //FlutterLogo(size: responsive.ip(20),),
                  Image(image: AssetImage("assets/logo.png"),
                  width: responsive.hp(40),),
                  // Text(
                  //   "Bienvenido",
                  //   style: TextStyle(
                  //       fontSize: responsive.ip(5),
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white),
                  // ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: responsive.ip(4),
                    ),
                    child: Text(
                      "Inicie Sesión",
                      style: TextStyle(
                          fontSize: responsive.ip(2.7),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  _nickName(loginBloc, responsive),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  _pass(loginBloc, responsive),

                  _botonLogin(context, loginBloc, responsive),

                  Padding(
                    padding: EdgeInsets.all(
                      responsive.ip(4.5),
                    ),
                    child: Text(
                      "Olvidé mi Contraseña",
                      style: TextStyle(
                          fontSize: responsive.ip(2.2), color: Colors.white),
                    ),
                  ),

                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(
                  //       "¿No tienes una cuenta?  ",
                  //       style: TextStyle(
                  //           fontSize: responsive.ip(2.2), color: Colors.white),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.pushNamed(
                  //           context,
                  //           'registroUsuario',
                  //         );
                  //       },
                  //       child: Text(
                  //         "Regístrate",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           //Theme.of(context).primaryColor,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: responsive.ip(2.4),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _nickName(LoginBloc bloc, Responsive responsive) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: responsive.hp(2),
            left: responsive.wp(10),
            right: responsive.wp(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lime[400],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              textAlign: TextAlign.left,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                //fillColor: Theme.of(context).dividerColor,
                hintText: 'Nombre de Usuario',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: responsive.ip(2),
                    fontFamily: 'Montserrat',
                    color: Colors.green[900]),
                //filled: true,
                contentPadding: EdgeInsets.all(
                  responsive.ip(2),
                ),
                errorText: snapshot.error,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Icon(Icons.person, color: Colors.green[900]),
                ),
              ),
              onChanged: bloc.changeEmail,
            ),
          ),
        );
      },
    );
  }

  Widget _pass(LoginBloc bloc, Responsive responsive) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: responsive.hp(2),
            left: responsive.wp(10),
            right: responsive.wp(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lime[400],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              obscureText: true,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                //fillColor: Theme.of(context).dividerColor,
                hintText: 'Contraseña',
                hintStyle: TextStyle(
                    fontSize: responsive.ip(1.8),
                    fontFamily: 'Montserrat',
                    color: Colors.green[900]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                //filled: true,
                contentPadding: EdgeInsets.all(
                  responsive.ip(2),
                ),
                errorText: snapshot.error,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.green[900],
                  ),
                ),
              ),
              onChanged: bloc.changePassword,
            ),
          ),
        );
      },
    );
  }

  Widget _botonLogin(
      BuildContext context, LoginBloc bloc, Responsive responsive) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Padding(
            padding: EdgeInsets.only(
              top: responsive.hp(8),
              left: responsive.wp(6),
              right: responsive.wp(6),
            ),
            child: SizedBox(
              width: responsive.wp(80),
              height: responsive.hp(7),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(0.0),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: responsive.ip(2), color: Colors.white),
                ),
                color: Colors.blue[800],
                textColor: Colors.white,
                onPressed:
                    (snapshot.hasData) ? () => _submit(context, bloc) : null,
              ),
            ),
          );
        });
  }

  _submit(BuildContext context, LoginBloc bloc) async {
    final int code = await bloc.login('${bloc.email}', '${bloc.password}');

    if (code == 1) {
      print(code);
      Navigator.pushReplacementNamed(context, 'home');
    } else if (code == 2) {
      print(code);
       utils.showToast1('Ocurrio un error', 2, ToastGravity.CENTER);
    } else if (code == 3) {
      print(code);
      utils.showToast1('Datos incorrectos', 2, ToastGravity.CENTER);
    }
  }
}
