import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/lecturaBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
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
              "Lista de Lecturas",
              //style: titulotexto,
            ),
          ),
          //Text("Historial de Mantenimiento"),
          bottom: TabBar(
            //labelStyle:gridTitulo,
            controller: _controllerTab,
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
            PendientesPages(),
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
    lecturaBloc.datosLectura();
    return StreamBuilder(
        stream: lecturaBloc.lecturaStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<LecturaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              List<LecturaModel> lectura = snapshot.data;

              return Container(
                color: Colors.red,
                height: double.infinity,
                child: _tablaResumen(responsive, lecturaBloc, lectura),
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
        });
  }

  Widget _tablaResumen(Responsive responsive, LecturaBloc lecturaBloc,
      List<LecturaModel> lectura) {
    var lecturasPendientes =
        lectura.where((l) => l.estadoLecturaInterna == '0').toList();
    var lecturasTerminadas =
        lectura.where((l) => l.estadoLecturaInterna == '1').toList();

    return ListView.builder(
      itemCount: lecturasPendientes.length+1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return
          
          
           Column(
            children: [
              Container(
                height: responsive.hp(4),
                color: Colors.grey[400],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("N°",
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            fontWeight: FontWeight.bold)),
                    // Text("Ruta",
                    //     style: TextStyle(
                    //         fontSize: responsive.ip(2),
                    //         fontWeight: FontWeight.bold)),
                    Text("N° de Medidor",
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            fontWeight: FontWeight.bold)),
                    Text("Dirección",
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            fontWeight: FontWeight.bold)),
                    Text("Secuencia",
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            fontWeight: FontWeight.bold)),
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
            Text(
              (i+1).toString(),
              style: TextStyle(fontSize: responsive.ip(2)),
            ),
            Expanded(
              child: Text(
                lectura[i].nromedidor,
                style: TextStyle(fontSize: responsive.ip(2)),
              ),
            ),
            Expanded(
              child: Text(
                lectura[i].direccion,
                style: TextStyle(fontSize: responsive.ip(2)),
              ),
            ),
            Expanded(
              child: Text(
                lectura[i].ordenenvio,
                style: TextStyle(fontSize: responsive.ip(2)),
              ),
            ),
          ],
        );
      },
    );

    Table(
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(children: [
          TableCell(
            child: Container(
              height: responsive.hp(4),
              color: Colors.grey[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Ruta",
                      style: TextStyle(
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.bold)),
                  Text("N° de Medidor",
                      style: TextStyle(
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.bold)),
                  Text("Dirección",
                      style: TextStyle(
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.bold)),
                  Text("Secuencia",
                      style: TextStyle(
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ]),
        TableRow(
          children: [
            TableCell(
              child: 
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //sector
                  // Container(
                  //   child: Text(lecturasTerminadas.length.toString(),
                  //       style: TextStyle(fontSize: responsive.ip(2))),
                  // ),
                  Container(
                    height: responsive.hp(50),
                    width: responsive.wp(3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: lectura.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          lectura[0].nombreSector,
                          style: TextStyle(fontSize: responsive.ip(2)),
                        );
                      },
                    ),
                  ),

                  //registradas
                  Container(
                    height: responsive.hp(70),
                    width: responsive.wp(25),
                    color: Colors.yellow,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: lectura.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          lectura[index].nromedidor,
                          style: TextStyle(fontSize: responsive.ip(2)),
                        );
                      },
                    ),
                  ),

                  //faltantes
                  Container(
                    child: Text(lecturasPendientes.length.toString(),
                        style: TextStyle(fontSize: responsive.ip(2))),
                  ),

                  //total
                  Container(
                    child: Text(lectura.length.toString(),
                        style: TextStyle(fontSize: responsive.ip(2))),
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
