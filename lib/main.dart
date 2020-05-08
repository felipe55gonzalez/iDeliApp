import 'package:el_gordo/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:el_gordo/Navigation/home_Screen.dart';
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
    final push= PushNotificationService();
    push.initNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iDeli Acuña',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
