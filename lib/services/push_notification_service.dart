import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  bool frist = true;
  initNotifications() {
    _fcm.requestNotificationPermissions();

    // _fcm.getToken().then((token) {
    //   print(token);
    // });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
          if (frist) {
          print("onlaunch: $message");
          frist = false;
        } else {
          frist = true;
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        if (frist) {
          print("onResume: $message");
          frist = false;
        } else {
          frist = true;
        }
      },
    );
  }
}
