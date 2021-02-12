import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import 'package:band_name_app/services/socket.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Text('Estado: ${ socketService.getServerStatus }'),
      ),
    );
  }
}