import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {

  const TermsAndConditions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Terminos y condiciones",
        style: TextStyle(fontWeight: FontWeight.w200),
      ),
      margin: EdgeInsets.only(bottom: 20),
    );
  }
}
