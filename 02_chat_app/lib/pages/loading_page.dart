import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/pages/users_page.dart';
import 'package:chat_app/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Ingresando"),
                  padding: EdgeInsets.only(bottom: 20),
                ),
                CircularProgressIndicator(),
              ],
          ));
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticated = await authService.isLogedIn();
    if (authenticated) {
      Navigator.pushReplacementNamed(context, 'users');
      // Navigator.pushReplacement(
      //   context,
      //   PageRouteBuilder(
      //     pageBuilder: (_, __, ___)=>UsersPage(),
      //     transitionDuration: Duration(milliseconds: 0),
      //   )
      // );
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
