import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'Helper/constant.dart';
import 'Screens/firebase_notification.dart';
import 'Screens/splashscreen/splash_screen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await FCMHelper.shared.intializeFirebase();

  // try {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print("-----------token:-----${token}");
  // } on FirebaseException {
  //   print('__________FirebaseException_____________');
  // }
  // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true, // Required to display a heads up notification
  //   badge: true,
  //   sound: true,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${AppConfig.appName}',
      theme: ThemeData(),
      home: Splash(),
    );
  }
}
