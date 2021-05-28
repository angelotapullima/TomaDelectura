import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Bloc/principal_bloc.dart';
import 'package:toma_de_lectura/Pages/Tabs/registrosInfo.dart';
import 'package:toma_de_lectura/Pages/Tabs/principal/principalPage.dart';
import 'package:toma_de_lectura/Pages/Tabs/clientePage.dart';
import 'package:toma_de_lectura/preferencias/preferencias_usuario.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> listPages = [];
  final prefs = new Preferences(); 

  @override
  void initState() {
    listPages.add(PrincipalPage());
    listPages.add(TabRegistrosLecturaPage());
    listPages.add(ClientePage());
    // listPages.add(NegociosPage());
    // listPages.add(UserPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     
    final Responsive responsive = new Responsive.of(context);
    final buttonBloc = ProviderBloc.tabs(context);
    if (buttonBloc.page == null) {
      buttonBloc.changePage(0);
    }

    return Scaffold(
      body: StreamBuilder(
          stream: buttonBloc.selectPageStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return IndexedStack(
              index: buttonBloc.page,
              children: listPages,
            );
          }),
      bottomNavigationBar: buttonNaviga(responsive, buttonBloc),
    );
  }

 Widget buttonNaviga(Responsive responsive, TabNavigationBloc buttonBloc) {
    return StreamBuilder(
        stream: buttonBloc.selectPageStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20)),
                      child: BottomNavigationBar(
                backgroundColor: Colors.white,
                               // Colors.teal,
                //Color(0Xff0097a7),
                elevation: 2,
                selectedItemColor: Colors.blue[500],
                unselectedItemColor: Colors.grey[600],
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: responsive.ip(3),
                    ),
                    label: 'Principal',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.pages_sharp,
                      size: responsive.ip(3),
                    ),
                    //title: Text('Registros'),
                    label: 'Reporte',
                    
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.supervised_user_circle_sharp,
                      size: responsive.ip(3),
                    ),
                   // title: Text('Usuarios'),
                    label: 'Cliente',
                            
                  ),
                  
                 //( prefs.asigConsulta=='1')?
                  // BottomNavigationBarItem(
                  //   icon: Icon(
                  //     Icons.store,
                  //     size: responsive.ip(3),
                  //   ),
                  //   title: Text('Negocio'),
                  // )
                  // BottomNavigationBarItem(
                  //     title: Text('Cuenta'),
                  //     icon: Icon(
                  //       Icons.person,
                  //       size: responsive.ip(3),
                  //     )),
                ],
                currentIndex: buttonBloc.page,
                onTap: (index) => {buttonBloc.changePage(index)}),
          );
        });
  }

}
