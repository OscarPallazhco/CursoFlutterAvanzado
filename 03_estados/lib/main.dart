import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:estados/routes/routes.dart';

import 'package:estados/services/user_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(create: (_) => new UserService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'page1',
        routes: routes,
      ),
    );
  }
}
