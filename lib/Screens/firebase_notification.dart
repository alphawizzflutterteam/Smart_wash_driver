// /*
// import 'dart:math';
// */

// import 'dart:math';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';

// class LocalNotificationService {
//   BuildContext? context;
//   static final FlutterLocalNotificationsPlugin
//   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static final shared = LocalNotificationService();

//   intializeFirebase() async {
//     Firebase.initializeApp().then((value) {
//       requestPermission();
//       getToken();
//       initialize();
//     });
//   }
//   void requestPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       getToken();
//     }
//     print('User granted permission: ${settings.authorizationStatus}');
//   }

//   void getToken() {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     messaging.getToken().then((value) {
//       print("FCM token is $value");
//       if (value?.isNotEmpty ?? false) {
//         // PreferenceUtils.setString("FCMTOKEN", value!);
//         //  SharedPref.shared.pref?.setString("FCMToken", value!);
//       }
//     });
//   }

//   static void initialize() async {
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: AndroidInitializationSettings(
//           "@mipmap/ic_launcher"),
//       //iOS: DarwinInitializationSettings()
//     );
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     NotificationSettings settings =
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.instance.getInitialMessage().then(
//           (message) {
//         print("FirebaseMessaging.instance.getInitialMessage");
//         if (message != null) {
//           print("New Notification");
//           // if (message.data['_id'] != null) {
//           //   Navigator.of(context).push(
//           //     MaterialPageRoute(
//           //       builder: (context) => DemoScreen(
//           //         id: message.data['_id'],
//           //       ),
//           //     ),
//           //   );
//           // }
//         }
//       },
//     );

//     FirebaseMessaging.onMessage.listen(
//           (message) {
//         print("FirebaseMessaging.onMessage______________");
//         if (message.notification != null) {
//           print('${message.notification}_________________');
//           print('${message.notification!.body}_________body____');
//           print("message.data11 ${message.data}");

//           display(message);

//           //handleNotification(message.data);

//         }
//       },
//     );

//     FirebaseMessaging.onMessageOpenedApp.listen(
//           (message) {
//         print("FirebaseMessaging.onMessageOpenedApp___________");
//         if (message.notification != null) {
//           print('_____________${message.notification}_______________');
//           print('_____________${message.notification?.title}_______________');
//           print(message.notification!.body);
//           print("message.data22 ${message.data}");

//           //handleNotification(message.data);

//           // HomeScreenState().setSegmentValue(2) ;

//         }
//       },
//     );

//   }

//   static  Future<void> handleNotification(Map<String, dynamic> message) async {
//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//     await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

//     if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
//       // App was opened from a notification
//       // TODO: handle the notification

//     } else {
//       // App was opened normally
//     }
//   }

//   static void display(RemoteMessage message) async {
//     try {
//       print("In Notification method");
//       // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
//       Random random = Random();
//       int id = random.nextInt(1000);
//       const NotificationDetails notificationDetails = NotificationDetails(
//           android: AndroidNotificationDetails(
//             "DR.Apps",
//             "DR.Apps",
//             importance: Importance.max,
//             priority: Priority.high,
//           ));
//       //print("my id is ${id.toString()}");
//       await _flutterLocalNotificationsPlugin.show(
//           id,
//           message.notification!.title,
//           message.notification!.body,
//           notificationDetails,
//           payload: message.data['_id']);
//     } on Exception catch (e) {
//       print('Error>>>$e');
//     }
//   }

// }

// Future<dynamic> myForgroundMessageHandler(RemoteMessage message) async {
//   return Future<void>.value();
// }

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

class FCMHelper {
  static final shared = FCMHelper();
  late FlutterLocalNotificationsPlugin fltNotification;

  intializeFirebase() async {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) {
      requestPermission();
      getToken();
      initMessaging();
    });
  }

  void initMessaging() {
    var androiInit = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInit = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification.initialize(
      initSetting,
      // onDidReceiveNotificationResponse: (details) {},
      // onDidReceiveBackgroundNotificationResponse: (details) {
      //   print("fltNotification details $details");
      // },

      onDidReceiveNotificationResponse: (details) {
        print("details.payload here ${details.payload}");
        final payload = details.payload;
        final data = json.decode(payload!);
        //  print("data notification : ${data['nid']}");
        //if (data != "" || data != nul1112l) {
        // var notificationtype = data["ntype"];
        // print("notificationtype here $notificationtype");
        // var nid = data["nid"];
        //final controller = NotificationController();
        //   final albumDetailController = BaseController();
        // SharedPref.shared.pref
        //     ?.setString(PrefKeys.isComingFromNotification, "1");
        // SharedPref.shared.pref
        //     ?.setString(PrefKeys.notificationType, notificationtype);
        // SharedPref.shared.pref?.setString(PrefKeys.notId, nid);

        // Get.to(NotificationScreen());
      },
    );

    var androidDetails = const AndroidNotificationDetails(
      "1",
      "ALPHA Vendor",
      icon: "@mipmap/ic_launcher",
      playSound: true,
    );
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails,
            payload: json.encode(message.data));
      }
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      getToken();
    }
    print('User granted permission: ${settings.authorizationStatus}');
  }

  void getToken() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print("FCM token is $value");
      if (value?.isNotEmpty ?? false) {
        // PreferenceUtils.setString("FCMTOKEN", value!);
        //  SharedPref.shared.pref?.setString("FCMToken", value!);
      }
    });
  }

  void listenNotificationInForground() {
    print('Message also contained a notification:');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> listenNotificationInBackground(RemoteMessage message) async {
    // Firebase.initializeApp();
    print("Handling a background message: ${message.data}");
  }
}
