import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/custom_labels.dart';
import 'package:chat_app/widgets/custom_logo.dart';
import 'package:chat_app/widgets/custom_terms.dart';
import 'package:chat_app/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          //permite hacer scroll cuando se despliega el teclado en pantalla
          physics: BouncingScrollPhysics(), //efecto de rebote en el scroll
          child: Container(
            height: MediaQuery.of(context).size.height * .90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Login',),
                Form(),
                Labels(
                  label1: '¿No tienes cuenta?',
                  label2: '!Crea una ahora!',
                  routeName: "register",
                ),
                TermsAndConditions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailInputController,
            isAutocorrect: false,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Password',
            textController: passwordInputController,
            isPassword: true,
          ),
          LoginButton(
            text: 'Ingresar',
            onPressedButton: _ingresar,
          )
        ],
      ),
    );
  }

  _ingresar() {
    print(emailInputController.text);
    print(passwordInputController.text);
  }
}
