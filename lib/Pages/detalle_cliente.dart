import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/Models/tipoMedidorModel.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class DetalleCliente extends StatefulWidget {
  DetalleCliente({
    Key key,
    @required this.lecturas,
    @required this.idSecuencia,
    @required this.nMedidor,
    @required this.codCliente,
  }) : super(key: key);

  final List<LecturaModel> lecturas;
  final String idSecuencia;
  final String nMedidor;
  final String codCliente;

  @override
  _DetalleClienteState createState() => _DetalleClienteState();
}

class _DetalleClienteState extends State<DetalleCliente> {
  int cantItems = 0;
  int cantLlamada = 0;
  String dropdownSedes = '';
  String dropdownCiclos = '';
  String codSede = "";

  @override
  Widget build(BuildContext context) {
    if (cantLlamada == 0) {
      final tipoMedidor = ProviderBloc.tipoMedidor(context);

      tipoMedidor.obtenerTipoEstadoMedidor();
      cantLlamada++;
    }
    final responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                      child: Text(
                        'Anterior',
                        style: TextStyle(
                            fontSize: responsive.ip(2), color: Colors.white),
                      ),
                      color: Colors.red,
                      onPressed: () {}),
                  Text(
                    '181929393',
                    style: TextStyle(
                        fontSize: responsive.ip(2),
                        fontWeight: FontWeight.bold),
                  ),
                  MaterialButton(
                      child: Text(
                        'siguiente',
                        style: TextStyle(
                            fontSize: responsive.ip(2), color: Colors.white),
                      ),
                      color: Colors.red,
                      onPressed: () {})
                ],
              ),
              SizedBox(
                height: responsive.hp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Med:',
                    style: TextStyle(
                      fontSize: responsive.ip(2),
                    ),
                  ),
                  Text(
                    'EA19847514:',
                    style: TextStyle(
                      fontSize: responsive.ip(2),
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Ruta:',
                    style: TextStyle(
                      fontSize: responsive.ip(2),
                    ),
                  ),
                  Text(
                    '001 - 0138:',
                    style: TextStyle(
                      fontSize: responsive.ip(2),
                    ),
                  )
                ],
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                width: double.infinity,
                color: Colors.blue,
                child: Text(
                  'NO REGISTRO CONSUMO Y/O LECTURA',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: responsive.wp(2), vertical: responsive.hp(2)),
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.wp(2),
                ),
                width: double.infinity,
                height: responsive.hp(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                ),
                child: TextField(
                  cursorColor: Colors.transparent,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black54),
                      hintText: 'Lectura de medidor'),
                  enableInteractiveSelection: false,
                  //controller: montoPagarontroller,
                ),
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: () {},
                child: Text(
                  '5467457 >> Guardar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Unid. uso: 1 DOM',
                      style: TextStyle(
                        fontSize: responsive.ip(2),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Observaciones',
                      style: TextStyle(
                        fontSize: responsive.ip(2),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                child: _estadoMedidor(context, responsive),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Observaciones',
                      style: TextStyle(
                        fontSize: responsive.ip(2),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: responsive.wp(2),
                  vertical: responsive.hp(2),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.wp(2),
                ),
                width: double.infinity,
                height: responsive.hp(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                ),
                child: TextField(
                  cursorColor: Colors.transparent,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black54),
                      hintText: 'Lectura de medidor'),
                  enableInteractiveSelection: false,
                  //controller: montoPagarontroller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var listSedes;

  Widget _estadoMedidor(BuildContext context, Responsive responsive) {
    final tipoMedidor = ProviderBloc.tipoMedidor(context);
    return StreamBuilder(
      stream: tipoMedidor.tiposEstadoMedidorStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<TipoEstadoMedidorModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItems == 0) {
              listSedes = List<String>();

              listSedes.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreSedes = snapshot.data[i].descripcion;
                listSedes.add(nombreSedes);
              }
              dropdownSedes = "Seleccionar";
            }
            return _estadoMedidorItem(responsive, snapshot.data, listSedes);
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  Widget _estadoMedidorItem(Responsive responsive,
      List<TipoEstadoMedidorModel> sedes, List<String> canche) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.wp(4),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue[300]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropdownSedes,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: responsive.ip(1.5),
        ),
        underline: Container(),
        onChanged: (String data) {
          setState(() {
            dropdownSedes = data;
            cantItems++;
            print(data);
            obtenerIdEstadoMedidor(data, sedes);
          });
        },
        items: canche.map(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: responsive.ip(1.8),
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  void obtenerIdEstadoMedidor(String dato, List<TipoEstadoMedidorModel> list) {
    for (int i = 0; i < list.length; i++) {
      if (dato == list[i].descripcion) {
        codSede = list[i].estadoMedidor;
      }
    }

    print(codSede);
  }
}
