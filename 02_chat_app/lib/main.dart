import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/routes/routes.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(   //provider global, todas las rutas tendrán en su context el AuthService
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => AuthService(),),
        ChangeNotifierProvider(create: (BuildContext context) => SocketService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: routes,
      ),
    );
  }
}
