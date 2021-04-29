import 'package:flutter/material.dart';
import 'package:toma_de_lectura/widgets/text_field_container.dart';
import 'package:toma_de_lectura/utils/constants.dart';

class TextfieldPassword extends StatelessWidget {
  final TextEditingController controlador;
  final ValueChanged<String> onChanged;
  const TextfieldPassword({
    Key key,
    this.onChanged, this.controlador,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controlador,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Contraseña",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
