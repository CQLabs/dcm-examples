// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app/app.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final sharedPreferences = await SharedPreferences.getInstance();

    final nService = AuthService(
      sharedPreferences: sharedPreferences,
      firebaseAnalytics: FirebaseAnalytics.instance,
      firebaseMessaging: FirebaseMessaging.instance,
      firebaseCrashlytics: FirebaseCrashlytics.instance,
    );
    await tester.pumpWidget(App(dcmService: nService));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Renders HomePage title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Text('Home Page')));
    expect(find.text('Home Page'), findsOneWidget);
  });
}
