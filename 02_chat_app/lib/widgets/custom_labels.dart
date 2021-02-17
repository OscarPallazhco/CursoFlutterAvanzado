import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  const Labels({Key key}) : super(key: key);

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
