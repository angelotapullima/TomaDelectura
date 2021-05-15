import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class BusquedaXMedidorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final lecturaBloc = ProviderBloc.lectura(context);
    // lecturaBloc.busquedaPorMedidor();
    return Scaffold(
      body: Container(
          child: StreamBuilder(
              stream: lecturaBloc.busquedaXMedidorStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<LecturaModel>> snapshot) {
                List<LecturaModel> resultados = snapshot.data;
                return ListView.builder(
                  itemCount: resultados.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, "detalleBusquedaMedidor",
                                arguments: resultados);
                          },
                          title: Text(resultados[index].nromedidor),
                          subtitle: Text(resultados[index].propietario),
                        );

                        //Container(child: Text(resultados[index].nromedidor));
                      } else {
                        return Text("vacio");
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              })),
    );
  }
}
