import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentCompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago realizado'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.star, size: 100, color: Colors.white,),
            SizedBox(height: 20,),
            Text('Pago realizado existosamente!', style: TextStyle(color: Colors.white, fontSize: 22),)
          ],
        ),
      ),
    );
  }
}