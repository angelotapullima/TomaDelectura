import 'package:flutter/material.dart';
import 'package:toma_de_lectura/utils/constants.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = Colors.blue,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final responsive = Responsive.of(context);
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: responsive.hp(1), horizontal: responsive.wp(5)),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor,fontSize: responsive.ip(1.8)),
          ),
        ),
      ),
    );
  }
}
