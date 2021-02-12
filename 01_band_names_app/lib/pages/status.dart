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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("mensaje enviado desde flutter:");
          print({'device':"app", 'mensaje':'mensaje desde flutter'});
          socketService.getSocket.emit("emitir-mensaje",{'device':"app", 'mensaje':'mensaje desde flutter'});
        },
        child: Icon(Icons.send),
      ),
    );
  }


}