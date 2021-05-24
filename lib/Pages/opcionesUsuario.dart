import 'package:flutter/material.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class OpcionesUsuario extends StatelessWidget {
  const OpcionesUsuario({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
        body: SafeArea(
                  child: Stack(
      children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/fondoa.jpg'), fit: BoxFit.cover),
            ),
          ),
      
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Seleccione una opción para ingresar',
                          style: TextStyle(
                              fontSize: responsive.ip(2.2),
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),

               SizedBox(height: responsive.hp(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  _opciones(context, responsive, 'Registrar lecturas'),
                  // _opciones(responsive, 'Consultar clientes'),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: responsive.wp(45),
                      height: responsive.hp(20),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.green[600],
                                Colors.green[400],
                                Colors.green[400],
                                Colors.green[300],
                              ]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(height: responsive.hp(2)),
                          Icon(Icons.search, color: Colors.yellow),
                          SizedBox(height: responsive.hp(1)),
                          Text('Consultar clientes',
                              style: TextStyle(
                                  fontSize: responsive.ip(2.2),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'home');
                    },
                  )
                ],
              ),
            ],
          ),
      ],
    ),
        ));
  }

  Widget _opciones(BuildContext context, Responsive responsive, String titulo) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        width: responsive.wp(45),
        height: responsive.hp(20),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.blue[600],
                  Colors.blue[400],
                  Colors.blue[400],
                  Colors.blue[300],
                ]),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: responsive.hp(2)),
            Icon(
              Icons.note,
              color: Colors.orange,
            ),
            SizedBox(height: responsive.hp(1)),
            Text('Registrar Lecturas',
                style: TextStyle(
                    fontSize: responsive.ip(2.2),
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'home');
      },
    );
  }

  // GridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       childAspectRatio: 1.2,
  //       //crossAxisSpacing: 8
  //     ),
  //     itemCount: 2,
  //     itemBuilder: (BuildContext context, int index) {
  //       return GestureDetector(
  //         onTap: () {
  //           Navigator.pushNamed(context, 'home');
  //         },
  //         child: gridSedes( responsive),
  //       );
  //     }));
  Widget gridSedes(Responsive responsive) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue[500],
                  Colors.blue[300],
                  Colors.blue[300],
                  Colors.blue[200],
                ]),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_creation_outlined),
            SizedBox(height: responsive.hp(1)),
            Center(
              child: Text("Registrar Lecturas", textAlign: TextAlign.center
                  //  TextStyle(
                  //     fontSize: responsive.ip(1.7), fontWeight: FontWeight.w400),
                  ),
            ),
          ],
        ));
  }
}
