import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/loginBloc.dart';
import 'package:toma_de_lectura/Models/ciclosModel.dart';
import 'package:toma_de_lectura/Models/sedesModel.dart';
import 'package:toma_de_lectura/Pages/loginPage.dart';
import 'package:toma_de_lectura/utils/responsive.dart';
import 'package:toma_de_lectura/widgets/rounded_button.dart';
import 'package:toma_de_lectura/widgets/rounded_input_field.dart';
import 'package:toma_de_lectura/widgets/rounded_password_field.dart';
import 'package:toma_de_lectura/utils/utils.dart' as utils;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int cantItems = 0;
  String dropdownSedes = '';
  String dropdownCiclos = '';

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
    Size size = MediaQuery.of(context).size;
    final responsive = Responsive.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: responsive.hp(15)),
            _seleccion(responsive),
            // SizedBox(height: responsive.hp(10)),
            LoginPage(),
          ],
        ),
      ),
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
              //dropdownNegocio = snapshot.data[1].nombre;
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
            //obtenerIdNegocios(data, negocios);
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
      Responsive responsive, List<CiclosModel> sedes, List<String> canche) {
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
            //obtenerIdNegocios(data, negocios);
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
        // SizedBox(
        //   height: responsive.hp(10),
        // ),
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final loginBloc = ProviderBloc.login(context);
    loginBloc.changeCargando(false);
    return StreamBuilder(
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
              height: responsive.hp(90),
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
                  _botonLogin2(context, loginBloc, responsive),
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

  Widget _botonLogin2(
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
                  style:
                      TextStyle(fontSize: responsive.ip(2), color: Colors.white),
                ),
                color: Colors.blue[800],
               // textColor: Colors.white,
                onPressed:
                    (snapshot.hasData) ? () => _submit(context, bloc) : null,
              ),
            ),
          );
        });
  }

  _submit(BuildContext context, LoginBloc bloc) async {
    final  res = await bloc.login('${bloc.email}', '${bloc.password}');

    if (res) {
      print(res);
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      print(res);
      utils.showToast1('Datos incorrectos', 2, ToastGravity.CENTER);
    }
  }
}
