import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';

enum ServerStatus { 
  online,
  offline,
  connecting
}

class SocketService with ChangeNotifier {
  
  late Socket _socket;
  ServerStatus _serverStatus = ServerStatus.connecting;

  Socket get socket => _socket;
  ServerStatus get serverStatus => _serverStatus;
  Function get emit => _socket.emit;

  void connect() async {
    
    final token = await AuthService.getToken();

    _socket = io(Environment.socketUrl,
      OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .enableForceNew()
        .setExtraHeaders( { 'x-token' : token } )
        .build()
    );

    _socket.onConnect((data) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((data) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', ( data ) {
    //   print('nuevo-mensaje: $data');
    // });
  }

  void disconnect() {
    socket.disconnect();
  }


}