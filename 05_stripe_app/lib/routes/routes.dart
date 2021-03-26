import 'package:flutter/material.dart';

// pages
import 'package:stripe_app/pages/home_page.dart';
import 'package:stripe_app/pages/credit_card_page.dart';
import 'package:stripe_app/pages/payment_completed_page.dart';
 
final Map<String, Widget Function(BuildContext)> routes = {
  'home_page': (_) => HomePage(),
  'credit_card_page': (_) => CreditCardPage(),
  'payment_completed_page': (_) => PaymentCompletedPage(),  
};