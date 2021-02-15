import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {

  ServerStatus _status = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get getServerStatus => this._status;
  IO.Socket get getSocket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io('https://bandnamesserver.herokuapp.com/', {
      'transports': ['websocket'],
      'autoconnect': true,
    });

    this._socket.onConnect((_) {
      print('connect');
      this._status = ServerStatus.Online;
      notifyListeners();  //manda a actualizar a los elementos que usen este servicio
    });

    this._socket.on('disconnect', (_) {
      print('disconnect');
      this._status = ServerStatus.Offline;
      notifyListeners();  
    });

  }
}
