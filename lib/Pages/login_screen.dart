import 'package:flutter/material.dart';
import 'package:toma_de_lectura/widgets/rounded_button.dart';
import 'package:toma_de_lectura/widgets/rounded_input_field.dart';
import 'package:toma_de_lectura/widgets/rounded_password_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),

              Image.asset('assets/images/logo_sedaayacucho.png',
                  height: size.height * 0.35),
              // SvgPicture.asset(
              //   "assets/icons/login.svg",
              //   height: size.height * 0.35,
              // ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Email",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "INGRESAR",
                press: () {},
              ),
              SizedBox(height: size.height * 0.03),
              // AlreadyHaveAnAccountCheck(
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) {
              //           return SignUpScreen();
              //         },
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
