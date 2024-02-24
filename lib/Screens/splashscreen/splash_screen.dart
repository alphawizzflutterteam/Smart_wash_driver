import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/app_colors.dart';
import '../Auth/signin_screen.dart';
import '../firebase_notification.dart';
import '../homepage/homePageScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true, // Required to display a heads up notification
    //   badge: true,
    //   sound: true,

    // );

    // FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Future.delayed(
      Duration(seconds: 3),
      () {
        sessonManager();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gold,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 200,
          width: 240,
        ),
      ),
    );
  }

  Future<void> sessonManager() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var sesson = prefs.getString('venderId');
    print('-=========================${sesson.runtimeType}');
    print('-=========================${sesson}');

    if (sesson != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }
}
