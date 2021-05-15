import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/lecturaBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/Pages/busquedas/resultBusqClientePage.dart.dart';
import 'package:toma_de_lectura/Pages/busquedas/resultBusquMedidorPage.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/responsive.dart';
import 'package:toma_de_lectura/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _secuenciacontroller = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lecturaBloc = ProviderBloc.lectura(context);
      lecturaBloc.datosLectura();
      lecturaBloc.lecturasPendientes();
      lecturaBloc.lecturasRegistradas();
      lecturaBloc.obtenerSector();
      lecturaBloc.obtenerDatosSecuencia();
    });
    super.initState();
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final prefs = new Preferences();
    final lecturaBloc = ProviderBloc.lectura(context);

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //color: Colors.red,
            height: responsive.hp(90),
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
                SizedBox(height: responsive.hp(3)),

                //Para llamar al total de los registros
                StreamBuilder(
                  stream: lecturaBloc.lecturaStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<LecturaModel>> snapshot) {
                    List<LecturaModel> lectura = snapshot.data;
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return _tablaResumen(responsive, lecturaBloc, lectura);
                      } else {
                        return Text("vacio");
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                Column(
                  children: [
                    Text("Secuencia", style: TextStyle(fontSize: 18)),
                    SizedBox(height: responsive.hp(1)),
                    Container(
                      width: responsive.wp(70),
                      height: responsive.hp(18),
                      // decoration: BoxDecoration(
                      //   border: Border.all(),
                      //color: Colors.purple,
                      // ),
                      child: StreamBuilder(
                        stream: lecturaBloc.secuenciaStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<LecturaModel>> snapshot) {
                          List<LecturaModel> secuencia = snapshot.data;

                          if (snapshot.hasData) {
                            if (snapshot.data.length > 0) {
                              return Column(
                                children: [
                                  TextField(
                                    //controller: _secuenciacontroller,
                                    controller: TextEditingController(
                                        text: secuencia[i].ordenenvio),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "N° de Correlativo",
                                        suffixIcon: Container(
                                          width: responsive.wp(7),
                                          height: responsive.hp(4),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (i <
                                                          secuencia.length -
                                                              1) {
                                                        i++;
                                                      } else {
                                                        utils.showToast1(
                                                            'Último registro',
                                                            2,
                                                            ToastGravity
                                                                .CENTER);
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      color: Colors.grey[300],
                                                      child: Icon(
                                                          Icons.arrow_drop_up,
                                                          color: Colors.black)),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  color: Colors.grey[300],
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (i > 0) {
                                                          i--;
                                                        } else {
                                                          utils.showToast1(
                                                              'Primer registro',
                                                              2,
                                                              ToastGravity
                                                                  .CENTER);
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  
                                  
                                  ),
                                  SizedBox(height: responsive.hp(1)),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'detalleBusquedaSecuencia',
                                            arguments:
                                                secuencia[i].ordenenvio);
                                      },
                                      child: Text("Ingresar"))
                                ],
                              );
                            } else {
                              return Text("vacioooo");
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.hp(3)),
                BusquedaWidgetPage()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tablaResumen(Responsive responsive, LecturaBloc lecturaBloc,
      List<LecturaModel> lectura) {
    return Table(
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(children: [
          TableCell(
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //sector
                Container(
                  height: responsive.hp(7),
                  width: responsive.wp(20),
                  child: StreamBuilder(
                    stream: lecturaBloc.sectorStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<LecturaModel>> snapshot) {
                      List<LecturaModel> sector = snapshot.data;
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: sector.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(sector[index].nombreSector);
                            },
                          );
                        } else {
                          return Text("data");
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                //registradas
                StreamBuilder(
                  stream: lecturaBloc.lecturaTerminadaStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<LecturaModel>> snapshot) {
                    List<LecturaModel> lecturaTerminada = snapshot.data;
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return Container(
                          child: Text(lecturaTerminada.length.toString()),
                        );
                      } else {
                        return Text("0");
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                //faltantes
                StreamBuilder(
                  stream: lecturaBloc.lecturaPendienteStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<LecturaModel>> snapshot) {
                    List<LecturaModel> lecturaPendiente = snapshot.data;
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return Container(
                            child: Text(lecturaPendiente.length.toString()));
                      } else {
                        return Text("0");
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),

                //total
                Container(child: Text(lectura.length.toString()))
              ],
            ),
          )
        ])
      ],
    );
  }
}

class BusquedaWidgetPage extends StatefulWidget {
  BusquedaWidgetPage({Key key}) : super(key: key);

  @override
  _BusquedaWidgetPageState createState() => _BusquedaWidgetPageState();
}

class _BusquedaWidgetPageState extends State<BusquedaWidgetPage> {
  TextEditingController _medidorcontroller = TextEditingController();
  TextEditingController _clientecontroller = TextEditingController();

  @override
  void dispose() {
    _medidorcontroller.dispose();
    _clientecontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final lecturaBloc = ProviderBloc.lectura(context);
    //lecturaBloc.busquedaPorMedidor();
    return Container(
      child: Column(
        children: [
          Text("Buscar:", style: TextStyle(fontSize: 18)),
          Divider(),
          //Busqueda por nro de medidor
          _busquedaXMedidor(responsive, lecturaBloc, context),
          SizedBox(height: responsive.hp(3)),
          //Busqueda por id del cliente
          _busquedaIdCliente(responsive, lecturaBloc, context)
        ],
      ),
    );
  }

  Widget _busquedaXMedidor(
      Responsive responsive, LecturaBloc lecturaBloc, BuildContext context) {
    return Container(
        width: responsive.wp(80),
        //height: responsive.hp(5),
        child: Column(
          children: [
            TextField(
              controller: _medidorcontroller,
              autocorrect: true,
              textCapitalization: TextCapitalization.characters,
              //obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'N° DE MEDIDOR',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      _medidorcontroller.clear();
                    },
                  )),
              onSubmitted: (String value) async {
                _submitMedidor(value, lecturaBloc, context);
                _medidorcontroller.clear();
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  _submitMedidor(_medidorcontroller.text, lecturaBloc, context);
                  _clientecontroller.clear();
                },
                child: Text("BUSCAR"))
          ],
        ));
  }

  Widget _busquedaIdCliente(
      Responsive responsive, LecturaBloc lecturaBloc, BuildContext context) {
    return Column(
      children: [
        Container(
          width: responsive.wp(80),
          child: TextField(
            controller: _clientecontroller,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CÓDIGO DEL CLIENTE',
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _clientecontroller.clear();
                  },
                )),
            onSubmitted: (String value) async {
              _submitIdCliente(value, lecturaBloc, context);
              _clientecontroller.clear();
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _submitIdCliente(_clientecontroller.text, lecturaBloc, context);
              _clientecontroller.clear();
            },
            child: Text("BUSCAR"))
      ],
    );
  }

  Future _submitIdCliente(
      String value, LecturaBloc lecturaBloc, BuildContext context) async {
    if (value.isNotEmpty) {
      final list = await lecturaBloc.busquedaPorCliente(value);
      // if (list.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BusquedaXIdClientePage()),
      );
      // } else {
      //   utils.showToast1(
      //       'No hay resultado para la búsqueda', 2, ToastGravity.CENTER);
      // }
    } else {
      utils.showToast1('Ingrese un código para buscar', 2, ToastGravity.CENTER);
    }
  }

  Future _submitMedidor(
      String valor, LecturaBloc lecturaBloc, BuildContext context) async {
    if (_medidorcontroller.text.isNotEmpty) {
      print(_medidorcontroller.text);

      final res = await lecturaBloc.busquedaPorMedidor(valor);

      // if (res.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BusquedaXMedidorPage()),
      );
      // } else {
      //   utils.showToast1(
      //       'No hay resultado para la búsqueda', 2, ToastGravity.CENTER);
      // }
    } else {
      utils.showToast1('Ingrese el número de medidor', 2, ToastGravity.CENTER);
    }
  }
}

// Container(
//     child: Row(
//   mainAxisAlignment:
//       MainAxisAlignment.spaceAround,
//   children: [
//     Container(
//         child: Text(
//       secuencia[i].ordenenvio,
//       style: TextStyle(fontSize: 20),
//     )),
//     Container(
//       width: responsive.wp(7),
//       height: responsive.hp(4),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 1,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   if (i < secuencia.length - 1) {
//                     i++;
//                   } else {
//                     utils.showToast1(
//                         'Último registro',
//                         2,
//                         ToastGravity.CENTER);
//                   }
//                 });
//               },
//               child: Container(
//                 color: Colors.red,
//                 child: Icon(Icons.arrow_drop_up),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: Colors.blue,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     if (i > 0) {
//                       i--;
//                     } else {
//                       utils.showToast1(
//                           'Primer registro',
//                           2,
//                           ToastGravity.CENTER);
//                     }
//                   });
//                 },
//                 child:
//                     Icon(Icons.arrow_drop_down),
//               ),
//             ),
//           ),
//         ],
//       ),
//     )
//   ],
// ));
