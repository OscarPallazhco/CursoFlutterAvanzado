import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:stripe_app/bloc/pay/pay_bloc.dart';

import 'package:stripe_app/helpers/helpers.dart';

import 'package:stripe_app/models/custom_credit_card.dart';

import 'package:stripe_app/services/stripe_service.dart';

class TotalPayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final payBloc = BlocProvider.of<PayBloc>(context);

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
              Text('${payBloc.state.amount} ${payBloc.state.currency} ', style: TextStyle(fontSize: 20,)),
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
    return BlocBuilder<PayBloc, PayState>(
      builder: (context, state) {
        return state.creditCardIsSelected
          ? buildCardButtonPay(context)
          : buildAppleOrGoogleButtonPay(context);
      },
    );
  }

  Widget buildCardButtonPay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      color: Colors.black,
      elevation: 0,
      onPressed: () async {
        showLoading(context);
        final StripeService stripeService = new StripeService();
        final PayBloc payBloc = BlocProvider.of<PayBloc>(context);
        final CustomCreditCard tarjeta = payBloc.state.creditCard;
        final mesAnio = tarjeta.expiracyDate.split('/');
        final CreditCard creditCard = new CreditCard(
          number: tarjeta.cardNumber,
          expMonth: int.parse(mesAnio[0]),
          expYear: int.parse(mesAnio[1]),
        );
        final resp = await stripeService.payWithExistentCard(
          amount: payBloc.state.stringOfAmount, 
          currency: payBloc.state.currency,
          creditCard: creditCard,
        );
        Navigator.pop(context);
        if (resp.ok) {
          showAlert(context, 'Pago completado', 'Pago realizado con éxito');
        } else {
          showAlert(context, 'Error', resp.msg);
        }
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
      onPressed: () async {
        final StripeService stripeService = new StripeService();
        final PayBloc payBloc = BlocProvider.of<PayBloc>(context);
        final resp = await stripeService.payWithNativePay(
          amount: payBloc.state.stringOfAmount, 
          currency: payBloc.state.currency,
        );
        if (resp.ok) {
          showAlert(context, 'Pago completado', 'Pago realizado con éxito');
        } else {
          showAlert(context, 'Error', resp.msg);
        }
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