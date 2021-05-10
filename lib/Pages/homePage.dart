import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final prefs = new Preferences();
    final lecturaBloc = ProviderBloc.lectura(context);
    lecturaBloc.datosLectura();
    lecturaBloc.obtenerDatosSecuencia();

    // final loginBloc = ProviderBloc.login(context);
    // loginBloc.changeCargando(false);
    return Scaffold(
      // appBar: AppBar(
      //     iconTheme: IconThemeData(color: Colors.black),
      //     elevation: 0,
      //     title: Text(
      //       "Home",
      //       style: TextStyle(color: Colors.black),
      //     ),
      //     backgroundColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: responsive.hp(80),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Cerrar Sesión"),
                    GestureDetector(
                        onTap: () async {
                          prefs.clearPreferences();

                          Navigator.pushNamedAndRemoveUntil(
                              context, 'login', (route) => false);
                        },
                        child: Icon(Icons.exit_to_app))
                  ],
                ),
                Text("Inspector:"),
                Text(prefs.personName),
                StreamBuilder(
                  stream: lecturaBloc.lecturaStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<LecturaModel>> snapshot) {
                    List<LecturaModel> lectura = snapshot.data;
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return Column(children: [
                          Text(lectura.length.toString()),
                          Table(
                            border:
                                TableBorder.all(width: 1, color: Colors.black),
                            children: [
                              TableRow(children: [
                                TableCell(
                                  child: Container(
                                    color: Colors.grey,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Sector"),
                                        Text("Registro"),
                                        Text("Falta"),
                                        Text("Total"),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(lectura[0].nombreSector),
                                      Text("Registro"),
                                      Text("Falta"),
                                      Text("Total"),
                                    ],
                                  ),
                                )
                              ])
                            ],
                          )
                        ]);
                      } else {
                        return Text("data111");
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                StreamBuilder(
                  stream: lecturaBloc.secuenciaStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<LecturaModel>> snapshot) {
                    List<LecturaModel> secuencia = snapshot.data;
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: secuencia.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(secuencia[index].direccion.toString());
                          },
                        );
                      } else {
                        return Text("data111");
                      }
                    } else {
                      return Text("dataffff");
                    }

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
