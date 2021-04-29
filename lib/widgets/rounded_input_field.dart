import 'package:flutter/material.dart';
import 'package:toma_de_lectura/widgets/text_field_container.dart';
import 'package:toma_de_lectura/utils/constants.dart';

class TextFieldRedondo extends StatelessWidget {
  final TextEditingController controlador;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const TextFieldRedondo({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged, this.controlador,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controlador,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
