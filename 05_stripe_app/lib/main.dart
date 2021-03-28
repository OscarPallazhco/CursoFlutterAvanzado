import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';

import 'package:stripe_app/routes/routes.dart';

import 'package:stripe_app/services/stripe_service.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // inicializar el servicio de stripe
    new StripeService()..init();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PayBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StripeApp',      
        initialRoute: 'home_page',
        routes: routes,
        theme: ThemeData.light().copyWith(
          primaryColor: Color(0xff284879),
          scaffoldBackgroundColor: Color(0xff21232A),
        ),
      ),
    );
  }
}