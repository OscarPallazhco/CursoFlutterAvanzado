import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {

  ServerStatus _status = ServerStatus.Connecting;

  get getServerStatus => this._status;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    IO.Socket socket = IO.io('http://192.168.100.42:3000', {
      'transports': ['websocket'],
      'autoconnect': true,
    });

    socket.onConnect((_) {
      print('connect');
      this._status = ServerStatus.Online;
      notifyListeners();  //manda a actualizar a los elementos que usen este servicio
    });

    socket.on('disconnect', (_) {
      print('disconnect');
      this._status = ServerStatus.Offline;
      notifyListeners();  
    });

  }
}
