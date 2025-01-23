import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../res/widgets/app_urls.dart';

class SocketService {
  static late IO.Socket socket;

  static void connect(String userId) {
    socket = IO.io(
      AppUrls.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .setAuth({'userId': userId})
          .build(),
    );

    socket.onConnect((_) {
      print('Connected to Socket.IO server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from Socket.IO server');
    });
  }

  static void joinRoom(String roomId) {
    socket.emit('joinRoom', roomId);
    socket.emit('getHistory', roomId);
  }

  static void leaveRoom(String roomId) {
    socket.emit('leaveRoom', roomId);
  }

  static void sendMessage(Map<String, dynamic> message) {
    socket.emit('sendMessage', message);
  }

  static void onNewMessage(Function(dynamic) callback) {
    socket.on('newMessage', callback);
  }

  static void onShowHistory(Function(dynamic) callback){
    socket.on('showHistory', callback);
  }

  static void disconnect() {
    socket.dispose();
  }
}
