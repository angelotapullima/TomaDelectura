// import 'package:flutter/material.dart';
// import 'package:toma_de_lectura/utils/responsive.dart';

// class PaginaSedes extends StatefulWidget {
//   PaginaSedes({Key key}) : super(key: key);

//   @override
//   _PaginaSedesState createState() => _PaginaSedesState();
// }

// class _PaginaSedesState extends State<PaginaSedes> {

//   var list;
//   var listSedes;
//   @override
//   Widget build(BuildContext context) {
//     final responsive = Responsive.of(context);
//     return Scaffold(
//           body: 
//           Column(
//       children: [
//         Container(
//           width: responsive.wp(80),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Sede Operativa',
//                 style: TextStyle(
//                     fontSize: responsive.ip(1.9), fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: responsive.hp(.5),
//               ),
//               _sedes(context, responsive),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: responsive.hp(2),
//         ),
//         Container(
//           width: responsive.wp(80),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Ciclo',
//                 style: TextStyle(
//                     fontSize: responsive.ip(1.9), fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: responsive.hp(.5),
//               ),
//               _ciclos(context, responsive),
//             ],
//           ),
//         ),
//         // SizedBox(
//         //   height: responsive.hp(10),
//         // ),
//       ],
//     );
  
//     );
//   }
// }