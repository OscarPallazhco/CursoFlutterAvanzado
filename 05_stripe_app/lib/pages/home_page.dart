import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import 'package:stripe_app/data/credit_cards.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/credit_card_page.dart';

import 'package:stripe_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Pagar'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){}
          ),
        ],
      ),
      body: Stack(
        children: [
          carouselCreditCards(context),
          Positioned(
            bottom: 0,
            child: TotalPayButton()
          )
        ],
      ),
    );
  }

  Positioned carouselCreditCards(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      width: width,
      height: height,
      top: 150,
      child: PageView.builder(
        itemCount: creditCards.length,
        controller: PageController(
          viewportFraction: 0.9,
        ),
        physics: BouncingScrollPhysics(), // curvatura que se ve en ios
        itemBuilder: (BuildContext context, int index) {
          final card = creditCards[index];
          return GestureDetector(
            child: Hero(
              tag: card.cardNumber,
              child: CreditCardWidget(
                cardNumber: card.cardNumber,
                expiryDate: card.expiracyDate,
                cardHolderName: card.cardHolderName,
                cvvCode: card.cvv,
                showBackView: false,
              ),
            ),
            onTap: (){
              Widget page = CreditCardPage(card: card,);
              Route route = navigateFadeInToPage(context, page);
              Navigator.push(context, route);
            },
          );
        },            
      ),
    );
  }

}