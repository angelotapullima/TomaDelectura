import 'package:flutter/material.dart';
import 'package:toma_de_lectura/utils/constants.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: responsive.hp(1)),
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(5), vertical: responsive.hp(.5)),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
