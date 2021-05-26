import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/lecturaBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/Pages/Tabs/principal/detalle_lectura.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/responsive.dart';
import 'package:toma_de_lectura/utils/utils.dart' as utils;

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  TextEditingController _lecturaController = TextEditingController();

  int cant = 0;

  int indexLectura = 0;

  @override
  void dispose() {
    _lecturaController.dispose();
    super.dispose();
  }

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
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Salir",
                    style: TextStyle(
                        fontSize: responsive.ip(2), color: Colors.black),
                  ),
                  SizedBox(height: responsive.wp(5)),
                  Icon(Icons.exit_to_app, size: 26)
                ],
              ),
              onTap: () async {
                prefs.clearPreferences();

                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (route) => false);
              },
            ),

            //PopupMenuButton( itemBuilder: (BuildContext context) { return [ PopupMenuItem( child: IconButton( icon: const Icon(Icons.lock_open), onPressed: () {}, ), ), PopupMenuItem(child: Text('Text')), ]; }, )
          ],
          backgroundColor: Colors.transparent,
          //Colors.teal
          //Color(0Xff04682b4)

          //automaticallyImplyLeading: false,
        ),
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  SizedBox(height: responsive.hp(1)),
                  //Divider(),
                  _datosUsuario(responsive, prefs),
                  // SizedBox(
                  //   height: responsive.hp(2)
                  // ),
                  StreamBuilder(
                      stream: lecturaBloc.lecturaStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<LecturaModel>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length > 0) {
                            List<LecturaModel> lectura = snapshot.data;
                            //Definir el valor de la secuencia
                            _lecturaController.text =
                                lectura[indexLectura].ordenenvio;
                            return Container(
                              //color: Colors.red,
                              height: responsive.hp(90),
                              child: Column(
                                children: [
                                  //Para llamar al total de los registros
                                  _tablaResumen(
                                      responsive, lecturaBloc, lectura),

                                  //Secuencia/ orden de envio
                                  _secuencia(responsive, lectura, context),
                                  SizedBox(
                                    height: responsive.hp(2),
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
                              child: Column(
                                children: [
                                  Text("Espere un momento..."),
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                            // return Center(
                            //   child: Text("No hay registros para mostrar"),
                            // );
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _datosUsuario(Responsive responsive, Preferences prefs) {
    return Container(
      color: Colors.white,
      width: responsive.wp(97),
      height: responsive.hp(10),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8),
      // //color: Colors.blue[100],
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.5),
      //       spreadRadius: 1,
      //       blurRadius: 1,
      //       offset: Offset(0, 2), // changes position of shadow
      //     ),
      //   ],
      // ),

      child: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Inspector:",
                style: TextStyle(
                    fontSize: responsive.ip(2), color: Colors.blue[900])),
            Text(prefs.personName,
                style: TextStyle(
                    fontSize: responsive.ip(2),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900])),
          ],
        ),
      ),
    );
  }

  Widget _tablaResumen(Responsive responsive, LecturaBloc lecturaBloc,
      List<LecturaModel> lectura) {
    var lecturasPendientes =
        lectura.where((l) => l.estadoLecturaInterna == '0').toList();
    var lecturasTerminadas =
        lectura.where((l) => l.estadoLecturaInterna == '1').toList();

    return Container(
      color: Colors.white,
      width: responsive.wp(97),
      child: Table(
        border: TableBorder.all(width: 1, color: Colors.blue[900]),
        children: [
          TableRow(children: [
            TableCell(
              child: Container(
                color: Colors.greenAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("SECTOR",
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900])),
                    Text("REGISTRO",
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900])),
                    Text("FALTA",
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900])),
                    Text("TOTAL",
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900])),
                  ],
                ),
              ),
            ),
          ]),
          TableRow(
            children: [
              TableCell(
                child: Container(
                  height: responsive.hp(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //sector
                      Container(
                        width: responsive.wp(23),
                        child: Text(
                          lectura[0].nombreSector,
                          style: TextStyle(
                              fontSize: responsive.ip(2),
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Container(
                      //   height: responsive.hp(7),
                      //   width: responsive.wp(20),
                      //   child: StreamBuilder(
                      //     stream: lecturaBloc.sectorStream,
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<List<LecturaModel>> snapshot) {
                      //       List<LecturaModel> sector = snapshot.data;
                      //       if (snapshot.hasData) {
                      //         if (snapshot.data.length > 0) {
                      //           return ListView.builder(
                      //             shrinkWrap: true,
                      //             itemCount: sector.length,
                      //             itemBuilder: (BuildContext context, int index) {
                      //               return Text(sector[index].nombreSector);
                      //             },
                      //           );
                      //         } else {
                      //           return Text("data");
                      //         }
                      //       } else {
                      //         return CircularProgressIndicator();
                      //       }
                      //     },
                      //   ),
                      // ),
                      //registradas
                      Container(
                        child: Text(lecturasTerminadas.length.toString(),
                            style: TextStyle(
                                fontSize: responsive.ip(2.3),
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ),

                      //faltantes
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(lecturasPendientes.length.toString(),
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      //height: 1.5,
                                      fontSize: responsive.ip(2.3),
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ),
                            //Icon(FontAwesomeIcons.handHolding)
                            // IconButton(
                            //   mouseCursor: SystemMouseCursors.click,
                            //   icon: Icon(Icons.mouse_rounded), onPressed: (){})
                          ],
                        ),
                        onTap: () {
                          final buttonBloc = ProviderBloc.tabs(context);
                          buttonBloc.changePage(1);
                        },
                      ),

                      //total
                      Container(
                        child: Text(lectura.length.toString(),
                            style: TextStyle(
                                fontSize: responsive.ip(2.3),
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _secuencia(
      Responsive responsive, List<LecturaModel> lectura, BuildContext context) {
    return Container(
      //color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      width: responsive.wp(97),
      child: Column(
        children: [
          SizedBox(height: responsive.hp(3)),
          Text(
            "Secuencia",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: responsive.hp(1),
          ),
          Container(
            width: responsive.wp(70),
            height: responsive.hp(18),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: responsive.wp(60),
                        height: responsive.hp(8),
                        child: TextField(
                          controller: _lecturaController,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.green)
                            // ),
                            
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),

                            //filled: true,
                            hintText: "N° de Correlativo",
                          ),
                          onSubmitted: (value) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 700),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return DetalleLectura(
                                    lecturas: lectura,
                                    numeroSecuencia: value,
                                    indexLectura: indexLectura,
                                    codCliente: '',
                                    nMedidor: '',
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      //suffixIcon:
                      Container(
                        width: responsive.wp(6.5),
                        height: responsive.hp(8),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      if (indexLectura < lectura.length - 1) {
                                        indexLectura++;

                                        print(indexLectura);
                                      } else {
                                        utils.showToast1('Último registro', 2,
                                            ToastGravity.CENTER);
                                      }
                                    },
                                  );
                                },
                                child: Container(
                                  width: responsive.wp(6.5),
                                  color: Colors.blue[500],
                                  // Colors.greenAccent,
                                  child: Icon(Icons.arrow_drop_up,
                                      color: Colors.white, size: 26),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                color:
                                    //Colors.greenAccent,

                                    Colors.blue[500],
                                width: responsive.wp(6.5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        if (indexLectura > 0) {
                                          indexLectura--;
                                        } else {
                                          utils.showToast1('Primer registro', 2,
                                              ToastGravity.CENTER);
                                        }
                                      },
                                    );
                                  },
                                  child: Icon(Icons.arrow_drop_down,
                                      color: Colors.white, size: 26),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Text(lectura[indexLectura].ordenenvio),
                SizedBox(
                  height: responsive.hp(1),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                    side: BorderSide(width: 1, color: Colors.blue[500]),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 700),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return DetalleLectura(
                            lecturas: lectura,
                            numeroSecuencia: _lecturaController.text,
                            indexLectura: indexLectura,
                            codCliente: '',
                            nMedidor: '',
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Text("INGRESAR",
                      style: TextStyle(
                          fontSize: responsive.ip(2),
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
      ),
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
      //color: Colors.white,
      width: responsive.wp(95),
      height: responsive.hp(45),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: responsive.hp(2)),
          Text("BUSCAR:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(
            color: Colors.grey,
          ),
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
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
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
                  enabledBorder:  OutlineInputBorder(
                              borderSide:  BorderSide(
                                  color: Colors.blue, width: 1.0),
                            ),
                  labelText: 'N° DE MEDIDOR',
                  labelStyle: TextStyle(color: Colors.blue[900]),
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
              style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  side: BorderSide(width: 1, color: Colors.blue[500])),
              //color:Colors.greenAccent,

              onPressed: () {
                _submitBusquedaMedidor(
                    _medidorcontroller.text, lecturas, indexLectura);
                // _medidorcontroller.clear();
              },
              child: Text("BUSCAR",
                  style: TextStyle(
                      fontSize: responsive.ip(2),
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  void _submitBusquedaMedidor(
      String valor, List<LecturaModel> lecturas, int indexLectura) {
    if (valor.length > 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (context, animation, secondaryAnimation) {
            return DetalleLectura(
              lecturas: widget.lecturas,
              numeroSecuencia: '',
              indexLectura: widget.indexLectura,
              nMedidor: valor,
              codCliente: '',
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => BusquedaXMedidorPage(
      //               nroMedidor: _medidorcontroller.text,
      //               lecturas: lecturas,
      //               indexLectura: indexLectura,
      //             )));
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
              enabledBorder:  OutlineInputBorder(
                              borderSide:  BorderSide(
                                  color: Colors.blue, width: 1.0),
                            ),
              labelText: 'CÓDIGO DEL CLIENTE',
              labelStyle: TextStyle(color: Colors.blue[900]),
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
          style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent,
              side: BorderSide(width: 1, color: Colors.blue[500])),
          onPressed: () {
            _submitCliente(_clientecontroller.text, lecturas, indexLectura);
            _clientecontroller.clear();
          },
          child: Text("BUSCAR",
              style: TextStyle(
                  fontSize: responsive.ip(2),
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  void _submitCliente(
      String valor, List<LecturaModel> lecturas, int indexLectura) {
    if (valor.isNotEmpty) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (context, animation, secondaryAnimation) {
            return DetalleLectura(
              lecturas: widget.lecturas,
              numeroSecuencia: '',
              indexLectura: widget.indexLectura,
              nMedidor: '',
              codCliente: valor,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    } else {
      utils.showToast1('Ingrese el código del cliente', 2, ToastGravity.CENTER);
    }
  }
}
