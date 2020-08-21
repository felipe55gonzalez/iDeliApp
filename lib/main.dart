import 'package:el_gordo/Cuenta/LoginPage.dart';
import 'package:el_gordo/services/push_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:el_gordo/Navigation/home_Screen.dart';
import 'package:lottie/lottie.dart';

import 'Cuenta/UserIndb.dart';
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
        home: FutureBuilder(
          future: userIndb.isUsersignedin(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              FirebaseUser user = snapshot.data;
              if (user != null) {
                print("usuario logeado");
              UserInDb db =new UserInDb();
              db.revisarUsariologeado(user, context);
              } else {
                  print("usuario no logeado");
                return HomeScreen(islogged: false);
              }
            }
            if(snapshot.data==null){
              print("no data");
              return HomeScreen(islogged: false);
            }
            return Center(
              child:  Lottie.asset('assets/lotties/splash.json'),
            );
          },
        ),
        routes: <String, WidgetBuilder>{
          '/Data': (BuildContext context) => new CheckDataPage(),
          '/Home': (BuildContext context) => new HomeScreen(islogged: true),
          '/logout': (BuildContext context) => new HomeScreen(islogged: false)
        });
  }
}
