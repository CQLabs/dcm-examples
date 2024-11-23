import 'dart:async';
import 'package:app/app.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/firebase_options.dart';
import 'package:app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:structure/structure.dart'
    if (kIsWeb) 'package:awesome/awesome.dart';

Future<void> main() async {
  if (kIsWeb) {
    debugPrint(Awesome().dogBark());
  }
  debugPrint(Structure().toString());
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    final sharedPreferences = await SharedPreferences.getInstance();

    final nService = AuthService(
      sharedPreferences: sharedPreferences,
      firebaseAnalytics: FirebaseAnalytics.instance,
      firebaseMessaging: FirebaseMessaging.instance,
      firebaseCrashlytics: FirebaseCrashlytics.instance,
      testConfig: 'test',
    );
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(
      App(
        dcmService: nService,
      ),
    );
  }, (error, stack) {
    debugPrint('runZonedGuarded: Caught error in my root zone.');
    debugPrintStack(stackTrace: stack);
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
