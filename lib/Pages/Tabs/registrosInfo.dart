import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/lecturaBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/Pages/Tabs/principal/detalle_lectura.dart';
import 'package:toma_de_lectura/utils/responsive.dart';


class TabRegistrosLecturaPage extends StatefulWidget {
  TabRegistrosLecturaPage({Key key}) : super(key: key);

  @override
  _TabRegistrosLecturaPageState createState() =>
      _TabRegistrosLecturaPageState();
}

class _TabRegistrosLecturaPageState extends State<TabRegistrosLecturaPage>
    with SingleTickerProviderStateMixin {
  TabController _controllerTab;
  @override
  void initState() {
    super.initState();
    _controllerTab = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: responsive.hp(30),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Reporte de Registros de Lecturas",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          //Color(0Xff04682b4),

          bottom: TabBar(
            labelStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            controller: _controllerTab,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.blue[500],
            tabs: [
              Tab(
                text: "Pendientes",
                // icon: Icon(FontAwesomeIcons.solidEdit, size: 20),
              ),
              Tab(
                text: "Terminadas",
                // icon: Icon(FontAwesomeIcons.crosshairs, size: 20),
              ),
            ],
          ),
        ),
        // drawer: MenuDrawer(),
        body: TabBarView(
          controller: _controllerTab,
          children: [
            PendientesPages(),
            TerminadasPages(),
          ],
        ),
      ),
    );
  }
}

class PendientesPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final lecturaBloc = ProviderBloc.lectura(context);
    lecturaBloc.lecturasPendientes();
    return StreamBuilder(
        stream: lecturaBloc.lecturaPendienteStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<LecturaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              List<LecturaModel> lectura = snapshot.data;

              return _tablaPendientes(responsive, lecturaBloc, lectura);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Cargando información..."),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Cargando información..."),
                    CircularProgressIndicator(),
                  ],
                ),
              );
          }
        });
  }

  Widget _tablaPendientes(Responsive responsive, LecturaBloc lecturaBloc,
      List<LecturaModel> lectura) {
    //int indice = 0;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        color: Colors.white,
        height: double.infinity,
        child: ListView.builder(
          itemCount: lectura.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(height: responsive.hp(2)),
                  Container(
                    // margin: EdgeInsets.all(2),
                    height: responsive.hp(4),
                    color: Colors.white,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            color: Colors.redAccent,
                            width: responsive.wp(8),
                            child: Center(
                              child: Text("N°",
                                  style: TextStyle(
                                      fontSize: responsive.ip(2),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        // Text("Ruta",
                        //     style: TextStyle(
                        //         fontSize: responsive.ip(2),
                        //         fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            color: Colors.redAccent,
                            width: responsive.wp(30),
                            child: Center(
                              child: Text("N° de Medidor",
                                  style: TextStyle(
                                      fontSize: responsive.ip(2),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              color: Colors.redAccent,
                              //width: responsive.wp(30),
                              child: Center(
                                child: Text("Dirección",
                                    style: TextStyle(
                                        fontSize: responsive.ip(2),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            color: Colors.redAccent,
                            width: responsive.wp(22),
                            child: Center(
                              child: Text("Secuencia",
                                  style: TextStyle(
                                      fontSize: responsive.ip(2),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            int i = index - 1;
            // print(i);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(
                //   lectura[i].codrutalectura,
                //   style: TextStyle(fontSize: responsive.ip(2)),
                // ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: Colors.white,
                    height: responsive.hp(5.6),
                    width: responsive.wp(8),
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(fontSize: responsive.ip(2)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: GestureDetector(
                    onTap: () async {
                      //Obtener los datos de la lista general de lecturas                      
                    List listaGeneral= await lecturaBloc.obtnerListaGeneralLecturas();
                    //obtener la posicion o indice del medidor dentro de la lista general
                      int indice = listaGeneral.indexWhere(
                          (l) => l.nromedidor == lectura[i].nromedidor);
                     // print(indice);

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 700),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return DetalleLectura(
                              lecturas: listaGeneral,
                              numeroSecuencia: '',
                              indexLectura: indice,
                              codCliente: '',
                              nMedidor: lectura[i].nromedidor,
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
                    child: Container(
                      color: Colors.white,
                      width: responsive.wp(30),
                      height: responsive.hp(5.6),
                      child: Text(
                        lectura[i].nromedidor,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                            fontSize: responsive.ip(2.2),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      lectura[i].direccion,
                      style: TextStyle(fontSize: responsive.ip(2)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: Colors.white,
                    width: responsive.wp(22),
                    height: responsive.hp(5.6),
                    child: Center(
                      child: Text(
                        lectura[i].ordenenvio,
                        style: TextStyle(fontSize: responsive.ip(2)),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    
  }
}

class TerminadasPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final lecturaBloc = ProviderBloc.lectura(context);
    lecturaBloc.lecturasRegistradas();
    return StreamBuilder(
        stream: lecturaBloc.lecturaTerminadaStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<LecturaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              List<LecturaModel> lectura = snapshot.data;

              return _tablaResumen(responsive, lecturaBloc, lectura);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No tiene ninguna lectura registrada"),
                    //CircularProgressIndicator(),
                  ],
                ),
              );
              // return Center(
              //   child: Text("No hay registros para mostrar"),
              // );
            }
          } else {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Cargando información..."),
                    CircularProgressIndicator(),
                  ],
                ),
              );
          }
        });
  }

  Widget _tablaResumen(Responsive responsive, LecturaBloc lecturaBloc,
      List<LecturaModel> lectura) {
    //var lecturasPendientes =lectura.where((l) => l.estadoLecturaInterna == '0').toList();
    //lecturasPendientes = lecturasPendientes.toList()..sort();
    var lecturasTerminadas =
        lectura.where((l) => l.estadoLecturaInterna == '1').toList();

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        color: Colors.white,
        height: double.infinity,
        child: ListView.builder(
          itemCount: lecturasTerminadas.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(height: responsive.hp(2)),
                  Container(
                    // margin: EdgeInsets.all(2),
                    height: responsive.hp(4),
                    color: Colors.white,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            color: Colors.green[400],
                            width: responsive.wp(8),
                            child: Center(
                              child: Text("N°",
                                  style: TextStyle(
                                      fontSize: responsive.ip(2),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        // Text("Ruta",
                        //     style: TextStyle(
                        //         fontSize: responsive.ip(2),
                        //         fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            color: Colors.green[400],
                            width: responsive.wp(30),
                            child: Center(
                              child: Text("N° de Medidor",
                                  style: TextStyle(
                                      fontSize: responsive.ip(2),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              color: Colors.green[400],
                              //width: responsive.wp(30),
                              child: Center(
                                child: Text("Dirección",
                                    style: TextStyle(
                                        fontSize: responsive.ip(2),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            color: Colors.green[400],
                            width: responsive.wp(22),
                            child: Center(
                              child: Text("Secuencia",
                                  style: TextStyle(
                                      fontSize: responsive.ip(2),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            int i = index - 1;
            // print(i);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(
                //   lectura[i].codrutalectura,
                //   style: TextStyle(fontSize: responsive.ip(2)),
                // ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: Colors.white,
                    height: responsive.hp(5.6),
                    width: responsive.wp(8),
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(fontSize: responsive.ip(2)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: Colors.white,
                    width: responsive.wp(30),
                    height: responsive.hp(5.6),
                    child: Text(
                      lectura[i].nromedidor,
                      style: TextStyle(
                          fontSize: responsive.ip(2.2),
                         // fontWeight: FontWeight.w500
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      lectura[i].direccion,
                      style: TextStyle(fontSize: responsive.ip(2)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: Colors.white,
                    width: responsive.wp(22),
                    height: responsive.hp(5.6),
                    child: Center(
                      child: Text(
                        lectura[i].ordenenvio,
                        style: TextStyle(fontSize: responsive.ip(2)),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    // Table(
    //   border: TableBorder.all(width: 1, color: Colors.black),
    //   children: [
    //     TableRow(children: [
    //       TableCell(
    //         child: Container(
    //           height: responsive.hp(4),
    //           color: Colors.grey[400],
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               Text("Ruta",
    //                   style: TextStyle(
    //                       fontSize: responsive.ip(2),
    //                       fontWeight: FontWeight.bold)),
    //               Text("N° de Medidor",
    //                   style: TextStyle(
    //                       fontSize: responsive.ip(2),
    //                       fontWeight: FontWeight.bold)),
    //               Text("Dirección",
    //                   style: TextStyle(
    //                       fontSize: responsive.ip(2),
    //                       fontWeight: FontWeight.bold)),
    //               Text("Secuencia",
    //                   style: TextStyle(
    //                       fontSize: responsive.ip(2),
    //                       fontWeight: FontWeight.bold)),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ]),
    //     TableRow(
    //       children: [
    //         TableCell(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               //sector
    //               // Container(
    //               //   child: Text(lecturasTerminadas.length.toString(),
    //               //       style: TextStyle(fontSize: responsive.ip(2))),
    //               // ),
    //               Container(
    //                 height: responsive.hp(50),
    //                 width: responsive.wp(3),
    //                 child: ListView.builder(
    //                   shrinkWrap: true,
    //                   itemCount: lectura.length,
    //                   itemBuilder: (BuildContext context, int index) {
    //                     return Text(
    //                       lectura[0].nombreSector,
    //                       style: TextStyle(fontSize: responsive.ip(2)),
    //                     );
    //                   },
    //                 ),
    //               ),

    //               //registradas
    //               Container(
    //                 height: responsive.hp(70),
    //                 width: responsive.wp(25),
    //                 color: Colors.yellow,
    //                 child: ListView.builder(
    //                   shrinkWrap: true,
    //                   itemCount: lectura.length,
    //                   itemBuilder: (BuildContext context, int index) {
    //                     return Text(
    //                       lectura[index].nromedidor,
    //                       style: TextStyle(fontSize: responsive.ip(2)),
    //                     );
    //                   },
    //                 ),
    //               ),

    //               //faltantes
    //               Container(
    //                 child: Text(lecturasTerminadas.length.toString(),
    //                     style: TextStyle(fontSize: responsive.ip(2))),
    //               ),

    //               //total
    //               Container(
    //                 child: Text(lectura.length.toString(),
    //                     style: TextStyle(fontSize: responsive.ip(2))),
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     )
    //   ],
    // );
  }
}
