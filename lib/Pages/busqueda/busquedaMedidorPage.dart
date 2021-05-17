import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/Pages/detalle_lectura.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class BusquedaXMedidorPage extends StatefulWidget {
  BusquedaXMedidorPage(
      {@required this.nroMedidor,
      @required this.lecturas,
      @required this.indexLectura});

  final String nroMedidor;
  final List<LecturaModel> lecturas;
  final int indexLectura;
  @override
  _BusquedaXMedidorPageState createState() => _BusquedaXMedidorPageState();
}

class _BusquedaXMedidorPageState extends State<BusquedaXMedidorPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final lecturaBloc = ProviderBloc.lectura(context);
    lecturaBloc.busquedaPorMedidor(widget.nroMedidor);
    return Scaffold(
      body: SafeArea(
              child: Container(
            child: StreamBuilder(
                stream: lecturaBloc.busquedaXMedidorStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<LecturaModel>> snapshot) {
                  List<LecturaModel> resultados = snapshot.data;
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return ListView.builder(
                        itemCount: resultados.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 700),
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return DetalleLectura(
                                      lecturas: widget.lecturas,
                                      numeroSecuencia: '',
                                      indexLectura: widget.indexLectura,
                                      nMedidor: resultados[index].nromedidor,
                                      codCliente: '',
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
                            title: Text(resultados[index].nromedidor),
                            subtitle: Text(resultados[index].propietario),
                          );

                          //Container(child: Text(resultados[index].nromedidor));
                        },
                      );
                    } else {
                      return Center(child: Text("No hay resultados para la búsqueda"));
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                })),
      ),
    );
  }
}
