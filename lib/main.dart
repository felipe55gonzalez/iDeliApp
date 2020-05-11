import 'package:el_gordo/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:el_gordo/Navigation/home_Screen.dart';

import 'Cuenta/checkdata.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final push = PushNotificationService();
    push.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'iDeli Acuña',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(logged: false),
        routes: <String, WidgetBuilder>{
          '/Data': (BuildContext context) => new CheckDataPage(),
          '/Home': (BuildContext context) => new HomeScreen(logged: true)
        });
  }
}
