import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalPayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total a pagar: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('2559.99 ', style: TextStyle(fontSize: 20,)),
            ],
          ),
          _BtnPay(),
        ],
      ),
    );
  }

}

class _BtnPay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool condition = true;
    return condition
      ? buildCardButtonPay(context)
      : buildAppleOrGoogleButtonPay(context)
    ;
  }

  Widget buildCardButtonPay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      color: Colors.black,
      elevation: 0,
      onPressed: () {        
      },
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.creditCard,
            color: Colors.white,
            size: 22,
          ),
          Text('  Pay', style: TextStyle(color: Colors.white, fontSize: 22),),
        ],
      ),
    );
  }
  
  Widget buildAppleOrGoogleButtonPay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      color: Colors.black,
      elevation: 0,
      onPressed: () {        
      },
      child: Row(
        children: [
          Icon(
            Platform.isAndroid
            ? FontAwesomeIcons.google
            : FontAwesomeIcons.apple,
            color: Colors.white,
            size: 22,
          ),
          Text(' Pay', style: TextStyle(color: Colors.white, fontSize: 22),),
        ],
      ),
    );
  }
}