import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/lecturaBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/Pages/busqueda/busquedaClientePage.dart';
import 'package:toma_de_lectura/Pages/busqueda/busquedaMedidorPage.dart';
import 'package:toma_de_lectura/Pages/detalle_lectura.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/responsive.dart';
import 'package:toma_de_lectura/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cant = 0;

  int indexLectura = 0;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final prefs = new Preferences();
    final lecturaBloc = ProviderBloc.lectura(context);

    if (cant == 0) {
      final lecturaBloc = ProviderBloc.lectura(context);
      lecturaBloc.datosLectura();
      lecturaBloc.lecturasPendientes();
      lecturaBloc.lecturasRegistradas();
      lecturaBloc.obtenerSector();
      lecturaBloc.obtenerDatosSecuencia();

      cant++;
    }

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey),
      body: ListView(
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
                child: Icon(Icons.exit_to_app),
              )
            ],
          ),
          Text("Inspector:"),
          Text(prefs.personName),
          SizedBox(
            height: responsive.hp(3),
          ),
          StreamBuilder(
              stream: lecturaBloc.lecturaStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<LecturaModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    List<LecturaModel> lectura = snapshot.data;

                    return Container(
                      //color: Colors.red,
                      height: responsive.hp(90),
                      child: Column(
                        children: [
                          //Para llamar al total de los registros
                          _tablaResumen(responsive, lecturaBloc, lectura),
                          Column(
                            children: [
                              Text(
                                "Secuencia",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: responsive.hp(1),
                              ),
                              Container(
                                width: responsive.wp(70),
                                height: responsive.hp(18),
                                child: Column(
                                  children: [
                                    TextField(
                                      //controller: _secuenciacontroller,
                                      controller: TextEditingController(
                                          text:
                                              lectura[indexLectura].ordenenvio),
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
                                                    setState(
                                                      () {
                                                        if (indexLectura <
                                                            lectura.length -
                                                                1) {
                                                          indexLectura++;
                                                        } else {
                                                          utils.showToast1(
                                                              'Último registro',
                                                              2,
                                                              ToastGravity
                                                                  .CENTER);
                                                        }
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    color: Colors.grey[300],
                                                    child: Icon(
                                                        Icons.arrow_drop_up,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  color: Colors.grey[300],
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          if (indexLectura >
                                                              0) {
                                                            indexLectura--;
                                                          } else {
                                                            utils.showToast1(
                                                                'Primer registro',
                                                                2,
                                                                ToastGravity
                                                                    .CENTER);
                                                          }
                                                        },
                                                      );
                                                    },
                                                    child: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsive.hp(1),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 700),
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return DetalleLectura(
                                                  lecturas: lectura,
                                                  numeroSecuencia:
                                                      lectura[indexLectura]
                                                          .ordenenvio,
                                                  indexLectura: indexLectura,
                                                  codCliente: '',
                                                  nMedidor: '',
                                                );
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Text("Ingresar"),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: responsive.hp(3),
                          ),
                          BusquedaWidgetPage(
                            lecturas: lectura,
                            indexLectura: indexLectura,
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No hay registros para mostrar"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
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
        TableRow(
          children: [
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
                            child: Text(
                              lecturaTerminada.length.toString(),
                            ),
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
                            child: Text(
                              lecturaPendiente.length.toString(),
                            ),
                          );
                        } else {
                          return Text("0");
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),

                  //total
                  Container(
                    child: Text(
                      lectura.length.toString(),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class BusquedaWidgetPage extends StatefulWidget {
  BusquedaWidgetPage({
    Key key,
    @required this.lecturas,
    @required this.indexLectura,
  }) : super(key: key);

  final List<LecturaModel> lecturas;
  final int indexLectura;
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
    //lecturaBloc.busquedaPorCliente();
    return Container(
      child: Column(
        children: [
          Text("Buscar:", style: TextStyle(fontSize: 18)),
          Divider(),
          //Busqueda por nro de medidor
          _busquedaXMedidor(responsive, widget.lecturas, widget.indexLectura),
          SizedBox(height: responsive.hp(3)),
          //Busqueda por id del cliente
          _busquedaIdCliente(
              responsive, widget.lecturas, lecturaBloc, widget.indexLectura)
        ],
      ),
    );
  }

  Widget _busquedaXMedidor(
    Responsive responsive,
    List<LecturaModel> lecturas,
    int indexLectura,
  ) {
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
            onSubmitted: (value) {
              value = _medidorcontroller.text;
              _submitBusquedaMedidor(value, lecturas, indexLectura);
              // _medidorcontroller.clear();
            },
          ),
          ElevatedButton(
            onPressed: () {
              _submitBusquedaMedidor(
                  _medidorcontroller.text, lecturas, indexLectura);
              // _medidorcontroller.clear();
            },
            child: Text("BUSCAR"),
          )
        ],
      ),
    );
  }

  void _submitBusquedaMedidor(
      String valor, List<LecturaModel> lecturas, int indexLectura) {
    if (valor.length > 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BusquedaXMedidorPage(
                    nroMedidor: _medidorcontroller.text,
                    lecturas: lecturas,
                    indexLectura: indexLectura,
                  )));
    } else {
      utils.showToast1('Ingrese un código para buscar', 2, ToastGravity.CENTER);
    }
  }

  Widget _busquedaIdCliente(
    Responsive responsive,
    List<LecturaModel> lecturas,
    LecturaBloc lecturaBloc,
    int indexLectura,
  ) {
    return Column(
      children: [
        Container(
          width: responsive.wp(80),
          child: TextField(
            controller: _clientecontroller,
            keyboardType: TextInputType.number,
            autocorrect: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CÓDIGO DEL CLIENTE',
              suffixIcon: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _clientecontroller.clear();
                },
              ),
            ),
            onSubmitted: (value) {
              value = _clientecontroller.text;
              _submitCliente(value, lecturas, indexLectura);
              _clientecontroller.clear();
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _submitCliente(_clientecontroller.text, lecturas, indexLectura);
            _clientecontroller.clear();
          },
          child: Text("BUSCAR"),
        )
      ],
    );
  }

  void _submitCliente(
      String valor, List<LecturaModel> lecturas, int indexLectura) {
    if (valor.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BusquedaXIdClientePage(
                    idcliente: valor,
                    lecturas: lecturas,
                    indexLectura: indexLectura,
                  )));
    } else {
      utils.showToast1('Ingrese el código del cliente', 2, ToastGravity.CENTER);
    }
  }
}
