import 'package:app/services/auth_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final nService = AuthService(
      sharedPreferences: sharedPreferences,
      firebaseMessaging: FirebaseMessaging.instance,
      firebaseAnalytics: FirebaseAnalytics.instance,
      firebaseCrashlytics: FirebaseCrashlytics.instance,
      testConfig: '',
    );
    expect(nService.apiServerKey, '04caaa026874a2679f65e76251e32568');
  });

  testWidgets('Checks HomePage header', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Text('Home Page')));
    expect(find.text('Home Page'), findsOneWidget);
  });
}
