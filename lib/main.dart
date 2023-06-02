import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/resources/my_string.dart';
import 'package:soowgood/common/screen/splash_scree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soowgood/common/service/push_notification_service.dart';
import 'package:soowgood/firebase_options.dart';

import 'common/screen/notification_list_screen.dart'; //

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//below function used when notification receive in background then this function initialise firebase
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  log('A Notifications msg show:  ${message}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  PushNotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log("onMessage Background: ${message.data}");
  });

  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  Map<int, Color> color =
  {
    50: const Color.fromRGBO(48, 188, 237, 1.0),
    100:const Color.fromRGBO(48, 188, 237, .2),
    200:const Color.fromRGBO(48, 188, 237, .3),
    300:const Color.fromRGBO(48, 188, 237, .4),
    400:const Color.fromRGBO(48, 188, 237, .5),
    500:const Color.fromRGBO(48, 188, 237, .6),
    600:const Color.fromRGBO(48, 188, 237, .7),
    700:const Color.fromRGBO(48, 188, 237, .8),
    800:const Color.fromRGBO(48, 188, 237, .9),
    900:const Color.fromRGBO(48, 188, 237, 1.0),
  };


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    MaterialColor colorCustom = MaterialColor(0xFF30BCED, color);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyString.soowgood,
      theme: ThemeData(
          primaryColor: MyColor.themeTealBlue,
          primaryColorDark : MyColor.themeTealBlue,
          primarySwatch: colorCustom
      ),
        home: const SplashScreen(),
        // initialRoute: AppRoutes.splashScreen,
        // getPages: AppPages.pages,
        defaultTransition: Transition.rightToLeft
    );
  }
}

