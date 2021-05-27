import 'dart:ui';

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
                  image: AssetImage('assets/images/fondod.jpg'), fit: BoxFit.cover),
            ),
            child: new BackdropFilter(
            filter:  ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.grey[200].withOpacity(.1),
        ),
          
      
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Seleccione una opción para ingresar',
                          style: TextStyle(
                              fontSize: responsive.ip(3),
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),

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
                  Colors.red[600],
                  Colors.red[400],
                  Colors.red[400],
                  Colors.red[400],
                  Colors.red[300],
                  
                ]),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: responsive.hp(2)),
            Icon(
              Icons.note,
              color: Colors.blue,
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


// decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         gradient: new LinearGradient(
//             colors: [
//               const Color(0xFF358814),
//               const Color(0xFF1BD854),
//             ],
//             begin: const FractionalOffset(0.0, 0.0),
//             end: const FractionalOffset(1.0, 0.0),
//             stops: [0.0, 1.0],
//             tileMode: TileMode.clamp),
//       ),

//rojo 
// decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         gradient: new LinearGradient(
//             colors: [
//               const Color(0xFFDB6F44),
//               const Color(0xFFD8211B),
//             ],
//             begin: const FractionalOffset(0.0, 0.0),
//             end: const FractionalOffset(1.0, 0.0),
//             stops: [0.0, 1.0],
//             tileMode: TileMode.clamp),
//       ),