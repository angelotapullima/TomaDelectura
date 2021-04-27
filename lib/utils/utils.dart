import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';



void showToast1(String msg, int duration, ToastGravity gravity) {
  Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}
/* 
TextStyle titulotexto =TextStyle(fontFamily: 'Syne', fontSize: 24, fontWeight: FontWeight.bold);
TextStyle subtitulotexto = TextStyle(fontFamily: 'Syne', fontSize: 20);
TextStyle gridTitulo =TextStyle(fontFamily: 'Syne', fontSize: 16, fontWeight: FontWeight.bold);
TextStyle formtexto = TextStyle(fontFamily: 'Syne', fontSize: 18,fontWeight: FontWeight.bold);
TextStyle form2 = TextStyle(fontFamily: 'Syne', fontSize: 16);

 */

// Widget getDatePickerEnabled(BuildContext context) {
//   final String _labelText = "Ingrese algo";

//   var _dateSelected = (DateTime.now());

//   return InkWell(
//     onTap: () {
//       _selectDate(context, _dateSelected);
//     },
//     child: InputDecorator(
//       decoration: InputDecoration(labelText: _labelText, enabled: true),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Text(
//             DateFormat.yMMMd().format(_dateSelected),
//             // style: CustomTheme.of(context).textTheme.subhead.copyWith(),
//           ),
//           Icon(Icons.arrow_drop_down,
//               color: Theme.of(context).brightness == Brightness.light
//                   ? Colors.grey.shade700
//                   : Colors.white70),
//         ],
//       ),
//     ),
//   );
// }

// Future<void> _selectDate(BuildContext context, _dateSelected) async {
//   final minYear = 2010;
//   final maxYear = 2021;
//   DateTime _onDateChange = (DateTime.now());
//   final DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: _dateSelected,
//       firstDate: new DateTime(minYear),
//       lastDate: new DateTime(maxYear));
//   if (picked != null && _onDateChange != null) {
//    // _onDateChange(picked);
//   }
// }
