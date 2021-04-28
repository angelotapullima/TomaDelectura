import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Models/ciclosModel.dart';
import 'package:toma_de_lectura/Models/sedesModel.dart';
import 'package:toma_de_lectura/utils/responsive.dart';
import 'package:toma_de_lectura/widgets/rounded_button.dart';
import 'package:toma_de_lectura/widgets/rounded_input_field.dart';
import 'package:toma_de_lectura/widgets/rounded_password_field.dart';

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
      child: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset('assets/images/logo_sedaayacucho.png',
                  height: size.height * 0.25),
              SizedBox(height: size.height * 0.03),
              Container(
                width: responsive.wp(80),
                height: responsive.hp(10),
                child: RoundedInputField(
                  hintText: "Email",
                  onChanged: (value) {},
                ),
              ),
              Container(
                width: responsive.wp(80),
                height: responsive.hp(10),
                child: RoundedPasswordField(
                  onChanged: (value) {},
                ),
              ),
              Container(
                width: responsive.wp(80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sede Operativa',
                      style: TextStyle(
                          fontSize: responsive.ip(1.9),
                          fontWeight: FontWeight.w500),
                    ), SizedBox(height: responsive.hp(.5),),
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
                          fontSize: responsive.ip(1.9),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: responsive.hp(.5),),
                    _ciclos(context, responsive),
                  ],
                ),
              ),
              SizedBox(
                height: responsive.hp(2),
              ),
              Container(
                height: responsive.hp(6),
                child: RoundedButton(
                  text: "INGRESAR",
                  press: () {},
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  var list;

  Widget _sedes(BuildContext context, Responsive responsive) {
    final sedesBloc = ProviderBloc.sedes(context);
    return StreamBuilder(
      stream: sedesBloc.sedesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<SedesModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItems == 0) {
              list = List<String>();

              list.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreSedes = snapshot.data[i].nombreSede;
                list.add(nombreSedes);
              }
              dropdownSedes = "Seleccionar";
              //dropdownNegocio = snapshot.data[1].nombre;
            }
            return _sedesItem(responsive, snapshot.data, list);
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
}
