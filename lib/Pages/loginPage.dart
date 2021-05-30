import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/loginBloc.dart';

import 'package:toma_de_lectura/Models/ciclosModel.dart';
import 'package:toma_de_lectura/Models/sedesModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/responsive.dart';
import 'package:toma_de_lectura/widgets/rounded_input_field.dart';
import 'package:toma_de_lectura/widgets/rounded_password_field.dart';
import 'package:toma_de_lectura/utils/utils.dart' as utils;

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int cantItems = 0;
  String dropdownSedes = '';
  String dropdownCiclos = '';
  String codSede = "";
  String codCiclo = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final sedesBloc = ProviderBloc.sedes(context);
      sedesBloc.obtenerSedes();

      final ciclosBloc = ProviderBloc.ciclo(context);
      ciclosBloc.obtenerCiclos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final responsive = Responsive.of(context);

    final loginBloc = ProviderBloc.login(context);
    loginBloc.changeCargando(false);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
        //      Container(
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage('assets/images/fondof.jpg'), fit: BoxFit.cover),
        //     ),
        //     child: new BackdropFilter(
        //     filter:  ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        //     child: new Container(
        //       decoration: new BoxDecoration(
        //         color: Colors.white.withOpacity(0.1),
        //       ),
        //     ),
        //   ),
        // ),
        // Container(
        //   color: Colors.grey[200].withOpacity(.1),
        // ),
            ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                SizedBox(height: responsive.hp(15)),
                _seleccion(responsive),
                // SizedBox(height: responsive.hp(10)),

                LoginPage(loginBloc: loginBloc),

                _botonLogin(context, loginBloc, responsive),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _seleccion(Responsive responsive) {
    return Column(
    children: [
    Container(
      width: responsive.wp(80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sede Operativa',
            style: TextStyle(
                fontSize: responsive.ip(1.9), fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: responsive.hp(.5),
          ),
          _sedes(context, responsive),
        ],
      ),
    ),
    SizedBox(
      height: responsive.hp(2),
    ),
    Container(
      width: responsive.wp(80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ciclo',
            style: TextStyle(
                fontSize: responsive.ip(1.9), fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: responsive.hp(.5),
          ),
          _ciclos(context, responsive),
        ],
      ),
    ),
    SizedBox(
      height: responsive.hp(5),
    ),
    ],
      );
  }

  var list;
  var listSedes;

  Widget _sedes(BuildContext context, Responsive responsive) {
    final sedesBloc = ProviderBloc.sedes(context);
    return StreamBuilder(
      stream: sedesBloc.sedesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<SedesModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItems == 0) {
              listSedes = List<String>();

              listSedes.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreSedes = snapshot.data[i].nombreSede;
                listSedes.add(nombreSedes);
              }
              dropdownSedes = "Seleccionar";
            }
            return _sedesItem(responsive, snapshot.data, listSedes);
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  Widget _sedesItem(
      Responsive responsive, List<SedesModel> sedes, List<String> canche) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.wp(4),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue[300]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropdownSedes,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: responsive.ip(1.5),
        ),
        underline: Container(),
        onChanged: (String data) {
          setState(() {
            dropdownSedes = data;
            cantItems++;
            print(data);
            obtenerIdSede(data, sedes);
          });
        },
        items: canche.map(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: responsive.ip(1.8),
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  void obtenerIdSede(String dato, List<SedesModel> list) {
    for (int i = 0; i < list.length; i++) {
      if (dato == list[i].nombreSede) {
        codSede = list[i].idSede;
      }
    }

    print(codSede);
  }

  Widget _ciclos(BuildContext context, Responsive responsive) {
    final ciclosBloc = ProviderBloc.ciclo(context);
    return StreamBuilder(
      stream: ciclosBloc.ciclosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<CiclosModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItems == 0) {
              list = List<String>();

              list.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String descripcion = snapshot.data[i].cicloDescripcion;
                list.add(descripcion);
              }
              dropdownCiclos = "Seleccionar";
              //dropdownNegocio = snapshot.data[1].nombre;
            }
            return _ciclosItem(responsive, snapshot.data, list);
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  Widget _ciclosItem(
      Responsive responsive, List<CiclosModel> ciclos, List<String> canche) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.wp(4),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue[300]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropdownCiclos,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: responsive.ip(1.5),
        ),
        underline: Container(),
        onChanged: (String data) {
          setState(() {
            dropdownCiclos = data;
            cantItems++;
            //print(data);
            obtenerIdCiclo(data, ciclos);
          });
        },
        items: canche.map(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: responsive.ip(1.8),
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  void obtenerIdCiclo(String dato, List<CiclosModel> list) {
    for (int i = 0; i < list.length; i++) {
      if (dato == list[i].cicloDescripcion) {
        codCiclo = list[i].idCiclo;
      }
    }

    print(codCiclo);
  }

  Widget _botonLogin(
      BuildContext context, LoginBloc loginbloc, Responsive responsive) {
    return StreamBuilder(
        stream: loginbloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Padding(
            padding: EdgeInsets.only(
              //  top: responsive.hp(8),
              left: responsive.wp(6),
              right: responsive.wp(6),
            ),
            child: SizedBox(
              width: responsive.wp(80),
              //height: responsive.hp(7),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                // padding: EdgeInsets.all(0.0),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                      fontSize: responsive.ip(2), color: Colors.white),
                ),
                color: Colors.blue[800],
                // textColor: Colors.white,
                onPressed: (snapshot.hasData)
                    ? () => _submit(context, loginbloc, codSede, codCiclo)
                    : null,
              ),
            ),
          );
        });
  }

  _submit(BuildContext context, LoginBloc loginbloc, codSede, codCiclo) async {
    if (codSede != '') {
      if (codCiclo != '') {
        print(codCiclo);
        //Agregamos el cod del ciclo a las preferencias
        final prefs = new Preferences();
        prefs.idCiclo = codCiclo;

        print("fff" + prefs.idCiclo);

        //Respuesta de la api
        final bool res = await loginbloc.login(
            '${loginbloc.email}', '${loginbloc.password}', codSede);

        if (res) {
          print(res);
          //prefs.asigConsulta=='1'?
          //Navigator.pushReplacementNamed(context, 'opcionesUsuario'):
          Navigator.pushReplacementNamed(context, 'home');
        } else {
          print(res);
          utils.showToast1('Datos incorrectos', 2, ToastGravity.CENTER);
        }
      } else {
        utils.showToast1('Seleccione un ciclo', 2, ToastGravity.CENTER);
      }
    } else {
      utils.showToast1('Seleccione una sede', 2, ToastGravity.CENTER);
    }
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, @required this.loginBloc}) : super(key: key);
  final LoginBloc loginBloc;
  //final SedesBloc sedesBloc;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    // final loginBloc = ProviderBloc.login(context);
    // loginBloc.changeCargando(false);
    return StreamBuilder(
    stream: widget.loginBloc.cargandoStream,
    builder: (context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.hasData) {
        return Stack(
          children: [
            _form(context, responsive, widget.loginBloc),
            (snapshot.data)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ],
        );
      } else {
        return _form(context, responsive, widget.loginBloc);
      }
    });
  }

  Widget _form(
      BuildContext context, Responsive responsive, LoginBloc loginBloc) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: SafeArea(
            child: Container(
              //color: Colors.red,
              height: responsive.hp(30),
              width: double.infinity,
              padding: EdgeInsets.only(top: responsive.hp(4)),
              child: Column(
                children: <Widget>[
                  Text(
                    "Inicie Sesión",
                    style: TextStyle(
                        fontSize: responsive.ip(2.7),
                        fontWeight: FontWeight.bold),
                  ),
                  _usuario(loginBloc, responsive),
                  _pass(loginBloc, responsive),

                  // Text(
                  //   "Olvidé mi Contraseña",
                  //   style: TextStyle(
                  //       fontSize: responsive.ip(2.2), color: Colors.red),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _usuario(LoginBloc bloc, Responsive responsive) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          width: responsive.wp(80),
          height: responsive.hp(10),
          child: TextFieldRedondo(
              // controlador: _usercontroller,
              hintText: "Usuario",
              onChanged: bloc.changeEmail),
        );
      },
    );
  }

  Widget _pass(LoginBloc bloc, Responsive responsive) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          width: responsive.wp(80),
          height: responsive.hp(10),
          child: TextfieldPassword(onChanged: bloc.changePassword),
        );
      },
    );
  }
}
