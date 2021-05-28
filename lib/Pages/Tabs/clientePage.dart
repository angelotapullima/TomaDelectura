import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Models/clienteModel.dart';
import 'package:toma_de_lectura/utils/constants.dart';
import 'package:toma_de_lectura/utils/responsive.dart';
import 'package:toma_de_lectura/widgets/text_field_container.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({Key key}) : super(key: key);

  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
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
    final responsive = Responsive.of(context);
    final clienteBloc = ProviderBloc.cliente(context);
    //clienteBloc.datosCliente(_clienteController.text);

    return Scaffold(
      body: SafeArea(
        child: Container(
            child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            SizedBox(height: responsive.hp(3)),
            Container(
              //padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
               margin: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
            height: responsive.hp(8),
            width: responsive.wp(90),
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                    padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(5),
                        vertical: responsive.hp(.5)),
                    width: responsive.wp(70),
                    child: TextField(
                        controller: _clienteController,
                        decoration: InputDecoration(
                          hintText: 'Código de Cliente',
                          hintStyle: TextStyle(
                              //fontSize: responsive.ip(1.6),
                              color: Colors.grey),
                              border: InputBorder.none,
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
                          clienteBloc
                              .datosCliente('${_clienteController.text}');
                        }
                      }),
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        _clienteController.text = '';
                      }),
                ],
              ),
            ),
            SizedBox(height: responsive.hp(3)),
          // List lisclient= clienteBloc.datosCliente('${_clienteController.text}')? Container():
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
                          return Container(
                              width: responsive.wp(90),
                              height: responsive.hp(70),
                              decoration: BoxDecoration(
                                //color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child:
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Código de cliente'),
                                          Text(listCliente[index].idcliente),
                                        ],
                                      ),
                                      SizedBox(height: responsive.hp(1)),
                                      Text(listCliente[index].nombreCliente),
                                      SizedBox(height: responsive.hp(1)),
                                      Text('${listCliente[index].descripcioncorta}' + '${listCliente[index].descripcioncalle}'),
                                      // Text(listCliente[index].descripcioncalle),
                                      // Text(listCliente[index].nombreCliente),
                                      // Text(listCliente[index].nombreCliente),
                                    ],
                                  ));
                        },
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("No hay resultados para la búsqueda..."),
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
