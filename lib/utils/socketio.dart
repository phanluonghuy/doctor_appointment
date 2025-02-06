import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../res/widgets/app_urls.dart';

class SocketService {
  static late IO.Socket socket;

  static List<String> usersOnline = [];

  static void connect(String userId) {
    socket = IO.io(
      AppUrls.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .build(),
    );

    socket.auth = {'userId': userId};

    socket.onConnect((_) {
      print('Connected to Socket.IO server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from Socket.IO server');
    });

    socket.on('onlineUsers', (users) {
      print('Online users: $users');
      usersOnline = users.cast<String>();
    });
  }

  static bool isUserOnline(String userId) {
    return usersOnline.contains(userId);
  }

  static void joinRoom(String roomId) {
    socket.emit('joinRoom', roomId);
    socket.emit('getHistory', roomId);
    socket.emit('seen', roomId);
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

  static void seen(String conversationId) {
    socket.emit('seen', conversationId);
  }

  static void onSeenResponse(Function(dynamic) callback) {
    socket.on('seenResponse', callback);
  }

  static void disconnect() {
    socket.dispose();
  }
}
