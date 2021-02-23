import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/helpers/show_alert.dart';

import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_labels.dart';
import 'package:chat_app/widgets/custom_logo.dart';
import 'package:chat_app/widgets/custom_terms.dart';
import 'package:chat_app/widgets/custom_input.dart';

import 'package:chat_app/services/auth_service.dart';

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
                Logo(
                  titulo: 'Login',
                ),
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
    final authService = Provider.of<AuthService>(context);

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
            onPressedButton: authService.authenticating ? null : ()async{
              FocusScope.of(context).unfocus();   //quitar el teclado al aplastar el botón ingresar
              if (emailInputController.text.trim().length < 1) {
                return showAlert(context, 'Campos incompletos', 'Email es necesario');
              }
              if (passwordInputController.text.trim().length < 1) {
                return showAlert(context, 'Campos incompletos', 'Password es necesario');
              }
              //TODO: comprobar que sea un mail valido
              final loginOk = await authService.login(emailInputController.text.trim(), passwordInputController.text.trim());
              if (loginOk) {
                // Navigator.pushReplacementNamed(context, 'users');
              }else{
                showAlert(context, 'Login incorrecto', 'Credenciales incorrectas');
              }
            },
          )
        ],
      ),
    );
  }
}
