import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app/global/environments.dart';

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

  void connect() {
    // this._socket = IO.io('https://bandnamesserver.herokuapp.com/', {
    this._socket = IO.io(Environments.socketUrl, {
      'transports': ['websocket'],
      'autoconnect': true,
      'forceNew' : true,
    });

    this._socket.onConnect((_) {
      print('Device connected to socket server');
      this._status = ServerStatus.Online;
      notifyListeners();  //manda a actualizar a los elementos que usen este servicio
    });

    this._socket.on('disconnect', (_) {
      print('disconnect');
      this._status = ServerStatus.Offline;
      notifyListeners();  
    });

  }

  void disconnect(){
    print('disconnect');
    this._status = ServerStatus.Offline;
    notifyListeners();  
    this._socket.disconnect();
  }
}
