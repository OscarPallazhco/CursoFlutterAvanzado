import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

// blocs
import 'package:stripe_app/bloc/pay/pay_bloc.dart';

// widgets
import 'package:stripe_app/widgets/total_pay_button.dart';

class CreditCardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final card = BlocProvider.of<PayBloc>(context).state.creditCard;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          iconSize: 26,
          icon: Icon(
            Platform.isAndroid
            ? Icons.arrow_back_rounded
            : Icons.arrow_back_ios_rounded
          ),
          onPressed: (){
            final payBloc = BlocProvider.of<PayBloc>(context);
            payBloc.add(OnCreditCardIsDeselected());
            Navigator.pop(context);
          },
        ),
        title: Text('Pagar'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(),          
          Hero(
            tag: card.cardNumber,
            child: CreditCardWidget(
              cardNumber: card.cardNumber,
              expiryDate: card.expiracyDate,
              cardHolderName: card.cardHolderName,
              cvvCode: card.cvv,
              showBackView: false,
            ),
          ),
          Positioned(
            bottom: 0,
            child: TotalPayButton()
          )
        ],
      ),
    );
  }
}
