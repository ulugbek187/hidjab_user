// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:hidjab_user/app/app.dart';
// import 'firebase_options.dart';
//
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   HttpOverrides.global = MyHttpOverrides();
//
//   runApp(
//     App(),
//   );
// }


import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hidjab_user/app/app.dart';
import 'package:hidjab_user/data/repo/storage_repository.dart';
import 'package:hidjab_user/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
    "BACKGROUND MODE DA PUSH NOTIFICATION KELDI:${message.notification!.title}",
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic(
    "news",
  );
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  await StorageRepository.init();
  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: const [
        Locale(
          'en',
          'US',
        ),
        Locale(
          'uz',
          'UZ',
        ),
        Locale(
          'ru',
          'RU',
        ),
      ],
      path: 'assets/translations',
      startLocale: const Locale(
        'uz',
        'UZ',
      ),
      child: App(),
    ),
  );
}
