import 'package:flutter/material.dart';
import 'package:notifications/src/pages/home_page.dart';
import 'package:notifications/src/pages/result_page.dart';
import 'package:notifications/src/services/pn_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushNotificationsProvider = PushNotificationsProvider();
    pushNotificationsProvider.init();

    pushNotificationsProvider.mensajeStream.listen((data) {
      print('mi nombre es: $data');
      //Navigator.pushNamed(context, 'result');
      navKey.currentState.pushNamed('result',arguments: data);
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home':(BuildContext context) => HomePage(),
        'result':(BuildContext context) => ResultPage(),
      },
    );
  }
}