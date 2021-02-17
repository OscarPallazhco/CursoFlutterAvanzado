import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String titulo;

  const Logo({Key key, @required this.titulo}) : super(key: key);

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
              this.titulo,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }
}
