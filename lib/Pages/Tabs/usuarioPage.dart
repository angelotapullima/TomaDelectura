import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Models/clienteModel.dart';
import 'package:toma_de_lectura/widgets/rounded_input_field.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({Key key}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  TextEditingController _clienteController = TextEditingController();

  @override
  void dispose() {
    _clienteController.dispose();
    _clienteController.text = '';
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final clienteBloc = ProviderBloc.cliente(context);
      //busquedaBloc.obtenerBusquedaGeneral('');
      clienteBloc.datosCliente('');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clienteBloc = ProviderBloc.cliente(context);
    //clienteBloc.datosCliente(_clienteController.text);

    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _clienteController,
                      decoration: InputDecoration(
                        hintText: 'Buscar',
                        hintStyle: TextStyle(
                            //fontSize: responsive.ip(1.6),
                            ),
                      ),
                      //onChanged: bloc.changeEmail
                      onSubmitted: (value) {
                        if (value.length >= 0 && value != ' ') {
                          clienteBloc.datosCliente('$value');
                        }
                      }),
                ),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (_clienteController.text.length >= 0 &&
                          _clienteController.text != ' ') {
                        // busquedaBloc.obtenerBusquedaGeneral(
                        //     '${_controllerBusquedaAngelo.text}');
                        clienteBloc.datosCliente('${_clienteController.text}');
                      }
                    }),
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      _clienteController.text = '';
                    }),
              ],
            ),
            StreamBuilder(
                stream: clienteBloc.clienteStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ClienteModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      List<ClienteModel> listCliente = snapshot.data;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: listCliente.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Text(listCliente[index].nombreCliente),
                            ],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Cargando información..."),
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
                          Text("no hay info"),
                          //CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                }),
          ],
        )),
      ),
    );
  }
}
