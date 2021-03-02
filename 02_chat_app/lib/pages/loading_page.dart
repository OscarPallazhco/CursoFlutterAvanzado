import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';

import 'package:chat_app/widgets/custom_logo.dart';

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
                // Container(
                //   child: Text("Ingresando"),
                //   padding: EdgeInsets.only(bottom: 30),
                // ),
                Logo(
                  titulo: '',
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
    final socketService = Provider.of<SocketService>(context, listen: false);
    final authenticated = await authService.isLogedIn();
    if (authenticated) {
      socketService.connect();
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
