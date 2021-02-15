import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Logo(),
            Form(),
            SizedBox(
              height: 40,
            ),
            _Labels(),
            Container(
                child: Text(
              "Terminos y condiciones",
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            margin: EdgeInsets.only(bottom: 20),
            )
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.50,
        //height: MediaQuery.of(context).size.height * 0.60,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/tag-logo.png'),
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
              'My ChatApp',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))
          ],
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(),
          SizedBox(
            height: 20,
          ),
          TextField(),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '¿No tienes cuenta?',
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontWeight: FontWeight.w300),
          ),
          Text(
            '!Crea una ahora!',
            style: TextStyle(
                fontSize: 25,
                color: Colors.blue[600],
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
