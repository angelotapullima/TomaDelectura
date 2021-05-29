import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/clienteBloc.dart';
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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme: IconThemeData(
      //     color: Colors.black,
      //   ),
      //   // title:
      //   //     Text("Búsqueda de Clientes", style: TextStyle(color: Colors.black)),
      //
      // ),
      body: SafeArea(
        child: CustomScrollView(
          primary: true,
          slivers: <Widget>[
            SliverAppBar(
              toolbarHeight: responsive.hp(18),
              pinned: true,
              backgroundColor: Colors.white,
              // title: Column(
              //     children: [
              //       SizedBox(height: responsive.hp(3)),
              //       Container(
              //           height: responsive.hp(4),
              //           child: Text('BÚSQUEDA DE CLIENTES',
              //               style: TextStyle(
              //                   fontSize: responsive.ip(2),
              //                   color: Colors.black))),
              //       SizedBox(height: responsive.hp(1)),
              //       _busqueda(responsive, clienteBloc),
              //     ],
              //   ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Column(
                  children: [
                    SizedBox(height: responsive.hp(3)),
                    Container(
                        height: responsive.hp(4),
                        child: Text('BÚSQUEDA DE CLIENTES',
                            style: TextStyle(
                                fontSize: responsive.ip(2),
                                color: Colors.black))),
                    SizedBox(height: responsive.hp(1)),
                    _busqueda(responsive, clienteBloc),
                  ],
                ),
                // background: _busqueda(responsive, clienteBloc),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                StreamBuilder(
                    stream: clienteBloc.clienteStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ClienteModel>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          List<ClienteModel> listCliente = snapshot.data;

                          return Column(
                            children: [
                              Container(
                                width: responsive.wp(96),
                                height: responsive.hp(7),
                                color: Color(0xFF546e89),
                                child: Center(
                                  child: Text('${listCliente[0].nombreCliente}',
                                      style: TextStyle(
                                          fontSize: responsive.ip(2),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ),
                              //Divider(),
                              WidgetContainer(
                                child: Center(
                                  child: Text(
                                      'ID CLIENTE: ${listCliente[0].idcliente}',
                                      style: TextStyle(
                                          fontSize: responsive.ip(2),
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                ),
                              ),
                              WidgetContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('SECTOR',
                                        style: TextStyle(
                                            fontSize: responsive.ip(2),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                    Text('MZA',
                                        style: TextStyle(
                                            fontSize: responsive.ip(2),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                    Text('LOTE',
                                        style: TextStyle(
                                            fontSize: responsive.ip(2),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                    Text('CONEX',
                                        style: TextStyle(
                                            fontSize: responsive.ip(2),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                              // Divider(
                              //   height: responsive.ip(2),
                              // ),
                              WidgetContainer(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _rowDatosCliente(responsive,
                                          '${listCliente[0].idsector}'),
                                      _rowDatosCliente(responsive,
                                          '${listCliente[0].idmanzana}'),
                                      _rowDatosCliente(responsive,
                                          '${listCliente[0].nrolote}'),
                                      _rowDatosCliente(responsive,
                                          '${listCliente[0].idsector}'),
                                    ],
                                  ),
                                ),
                              ),
                              // Divider(
                              //   height: responsive.ip(2),
                              // ),
                              WidgetContainer(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          'Ruta: ${listCliente[0].codrutadistribucion}',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      SizedBox(width: responsive.wp(3)),
                                      Text(
                                          'Secuencia: ${listCliente[0].codrutadistribucion}',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              //Divider(height: responsive.ip(2)),
                              WidgetContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('DIRECCIÓN',
                                        style: TextStyle(
                                          fontSize: responsive.ip(2),
                                          fontWeight: FontWeight.w600,
                                          // color: Colors.black54
                                        )),
                                    _buttonVerde(responsive,
                                        '${listCliente[0].nombreSucusal}')
                                  ],
                                ),
                              ),
                              SizedBox(height: responsive.hp(1.5)),
                              Container(
                                height: responsive.hp(17),
                                width: responsive.wp(88),
                                //color: Colors.grey[200],
                                //margin: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: responsive.wp(2)),
                                    Container(
                                      width: responsive.wp(88),
                                      height: responsive.hp(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.grey[200],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                          '${listCliente[0].descripcioncorta}',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              color: Colors.black87)),
                                    ),
                                    SizedBox(height: responsive.hp(.5)),
                                    Container(
                                      width: responsive.wp(88),
                                      height: responsive.hp(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.grey[200],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                          '${listCliente[0].descripcioncalle}',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              color: Colors.black87)),
                                    ),
                                    SizedBox(height: responsive.hp(.5)),
                                    Container(
                                      width: responsive.wp(88),
                                      height: responsive.hp(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.grey[200],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Text('${listCliente[0].nrocalle}',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              color: Colors.black87)),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                //color: Color(0xff7eae14),
                                width: responsive.wp(96),
                                child: Column(
                                  children: [
                                    WidgetContainer(
                                      child: Center(
                                        child: Text(
                                            'HABILITACION/ASOCIACIÓN/SECTOR ',
                                            style: TextStyle(
                                                fontSize: responsive.ip(2),
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    // SizedBox(height: responsive.hp(.5)),
                                    WidgetContainer(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: responsive.wp(88),
                                            height: responsive.hp(4.5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Colors.grey[200],
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      2), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              '${listCliente[0].descripcionurba}',
                                              style: TextStyle(
                                                fontSize: responsive.ip(2),
                                                fontWeight: FontWeight.w400,

                                                // color: Colors
                                                //     .black
                                              ),
                                              //textAlign: TextAlign.center,
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: responsive.hp(2)),
                              WidgetContainer(
                                child: Center(
                                  child: Text('DATOS COMPLEMENTARIOS ',
                                      style: TextStyle(
                                          fontSize: responsive.ip(2),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ),
                              ),
                              WidgetContainer(
                                child: Row(
                                  children: [
                                    _buttonVerde(responsive, 'SITUACIÓN'),
                                    SizedBox(width: responsive.wp(3)),
                                    Container(
                                      width: responsive.wp(61),
                                      height: responsive.hp(4),
                                      //color: Colors.grey[200],
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.grey[200],
                                          border: Border.all(
                                              color: Colors.grey[300])),
                                      child: Text(
                                          '${listCliente[0].idestadoservicio}',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),

                              WidgetContainer(
                                child: Row(
                                  children: [
                                    _buttonVerde(responsive, 'SERVICIO'),
                                    SizedBox(width: responsive.wp(3)),
                                    Container(
                                      width: responsive.wp(61),
                                      height: responsive.hp(4),
                                      //color: Colors.grey[200],
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.grey[200],
                                          border: Border.all(
                                              color: Colors.grey[300])),
                                      child: Text(
                                          '${listCliente[0].tiposervicio}',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _busqueda(Responsive responsive, ClienteBloc clienteBloc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsive.wp(8)),
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
      height: responsive.hp(7),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              //color: Colors.blue,
              child: TextField(
                  controller: _clienteController,
                  keyboardType: TextInputType.number,
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
          ),
          //SizedBox(width: responsive.wp(5)),
          Container(
            height: responsive.hp(7),
            width: responsive.wp(18),
            //color: Colors.yellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    child: Icon(Icons.search),
                    onTap: () {
                      if (_clienteController.text.length >= 0 &&
                          _clienteController.text != ' ') {
                        // busquedaBloc.obtenerBusquedaGeneral(
                        //     '${_controllerBusquedaAngelo.text}');
                        clienteBloc.datosCliente('${_clienteController.text}');
                      }
                    }),
                SizedBox(width: responsive.wp(1)),
                GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () {
                      _clienteController.text = '';
                    }),
                SizedBox(width: responsive.wp(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonVerde(Responsive responsive, String text) {
    return Container(
      width: responsive.wp(30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff7eae14),
          side: BorderSide(width: 1, color: Color(0xff7eae14)),
        ),
        onPressed: () {},
        child: Text(text,
            style: TextStyle(
              fontSize: responsive.ip(1.8),
              color: Colors.white,
              //fontWeight: FontWeight.bold
            )),
      ),
    );
  }

  Widget _rowDatosCliente(Responsive responsive, String text) {
    return Container(
      width: responsive.wp(13),
      height: responsive.hp(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
              fontSize: responsive.ip(2),
              fontWeight: FontWeight.w400,
              //color: Colors.black
            )),
      ),
    );
  }
}

class WidgetContainer extends StatelessWidget {
  final Widget child;
  const WidgetContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      height: responsive.hp(7),
      width: responsive.wp(96),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.white,
          border: Border.all(color: Colors.grey[300])),
      child: child,
    );
  }
}
