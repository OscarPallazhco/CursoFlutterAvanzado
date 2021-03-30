import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth App'),
        ),
        body: Center(
          child: Container(
            child: Text('Auth App'),
          ),
        ),
      ),
    );
  }
}