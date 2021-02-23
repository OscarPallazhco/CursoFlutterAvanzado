import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_labels.dart';
import 'package:chat_app/widgets/custom_logo.dart';
import 'package:chat_app/widgets/custom_terms.dart';
import 'package:chat_app/widgets/custom_input.dart';

import 'package:chat_app/helpers/show_alert.dart';

import 'package:chat_app/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
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
                Logo(titulo: 'Registro',),
                Form(),
                Labels(
                  label1: '¿Ya tienes cuenta?',
                  label2: '!Inicia sesión ahora!',
                  routeName: "login",
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
  final TextEditingController userInputController = TextEditingController();
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
            icon: Icons.account_circle_rounded,
            placeholder: 'Username',
            textController: userInputController,
            isAutocorrect: false,
          ),
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
            text: 'Registrar',
            onPressedButton: authService.authenticating ? null : () async{
              FocusScope.of(context).unfocus();   //quitar el teclado al aplastar el botón registrar
              if (userInputController.text.trim().length < 1) {
                return showAlert(context, 'Campos incompletos', 'User es necesario');
              }
              if (emailInputController.text.trim().length < 1) {
                return showAlert(context, 'Campos incompletos', 'Email es necesario');
              }
              if (passwordInputController.text.trim().length < 1) {
                return showAlert(context, 'Campos incompletos', 'Password es necesario');
              }
              //TODO: comprobar que sea un mail valido
              final registerOk = await authService.register(userInputController.text.trim(), emailInputController.text.trim(), passwordInputController.text.trim());
              if (registerOk == true) {
                Navigator.pushReplacementNamed(context, 'users');
              }else{
                showAlert(context, 'Registro incorrecto', registerOk);  //en este caso registerOk no es boolean sino String
              }
            },
          )
        ],
      ),
    );
  }
}
