import 'dart:convert';

import 'package:farmapp2/global/enviroment.dart';
import 'package:farmapp2/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}


class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async {

    final token = await AuthService.getToken();
    final encodedToken = base64.encode(utf8.encode(':'+token));
    // Dart client
    this._socket = IO.io( Enviroment.socketUrl , {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'authorization': 'Basic $encodedToken'
      }
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }


  void disconnect() {
    this._socket.disconnect();
  }

}