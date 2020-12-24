import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();  
  Stream<String> get mensajeStream => _mensajesStreamController.stream;

   static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data']['name'];
    }
    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
    // Or do other work.
  }
  
  init() async{

    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print(token);

    _firebaseMessaging.configure(
        onMessage: onMessage,
        onBackgroundMessage: onBackgroundMessage,
        onLaunch: onLaunch,
        onResume: onResume,
      );
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('onLaunch');
    final arg = message['data']['name'] ?? 'no-data';
    _mensajesStreamController.sink.add(arg);
  }
  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('onMessage');
    final arg = message['data']['name'] ?? 'no-data';
    _mensajesStreamController.sink.add(arg);
  }
  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('onResume');
    final arg = message['data']['name'] ?? 'no-data';
    _mensajesStreamController.sink.add(arg);
  }

  dispose(){
    _mensajesStreamController.close();
  }

}