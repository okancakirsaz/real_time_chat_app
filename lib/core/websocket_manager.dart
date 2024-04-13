import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final class WebSocketManager {
  static final WebSocketManager instance = WebSocketManager();

  String _fetchBaseUrl() {
    switch (kDebugMode) {
      case true:
        return "http://localhost:3000";
      default:
        //Product host url
        return "";
    }
  }

  IO.Socket get socket => IO.io(
      _fetchBaseUrl(), IO.OptionBuilder().setTransports(['websocket']).build());
  initializeSocketConnection() {
    try {
      socket.connect();
      socket.onConnect((_) {
        debugPrint("Websocket connection success");
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  disconnectFromSocket() {
    socket.disconnect();
    socket.onDisconnect((data) => debugPrint("Websocket disconnected"));
  }

  void webSocketReceiver(String eventName, Function(dynamic) onEvent) {
    socket.on(eventName, (data) {
      onEvent(data);
    });
  }

  void webSocketSender(String eventName, dynamic body) {
    socket.emit(eventName, body);
  }
}
