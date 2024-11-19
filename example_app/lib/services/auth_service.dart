import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService({
    required this.sharedPreferences,
    required this.firebaseMessaging,
    required this.firebaseAnalytics,
    required this.firebaseCrashlytics,
    this.usernameKey2,
  });

  final SharedPreferences sharedPreferences;

  final FirebaseMessaging firebaseMessaging;
  final FirebaseAnalytics firebaseAnalytics;
  final FirebaseCrashlytics firebaseCrashlytics;
  final String? usernameKey2;

  final String usernameKey = 'username';
  final String passwordKey = 'password';
  final String userAuthTokenKey = 'userauthtokenkey';

  final String intranetBaseUrl = 'https://dcm.dev';
  final String apiServerKey = '04caaa026874a2679f65e76251e32568';

  Uri getIntranetApiUri(String path) {
    return Uri.https('dcm.dev', path);
  }

  (String? username, String? password) getUserPass() {
    return (
      sharedPreferences.getString(usernameKey),
      sharedPreferences.getString(passwordKey)
    );
  }

  Future<bool> saveToStorage(usr, pass) async {
    try {
      await sharedPreferences.setString(usernameKey, usr);
      await sharedPreferences.setString(passwordKey, pass);
      return true;
    } catch (e) {
      return false;
    }
  }

  String? getUserAuthToken() {
    return sharedPreferences.getString(userAuthTokenKey);
  }

  Future<String?> getUserDeviceToken() async {
    try {
      final settings = await requestNotificationPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        final fcmToken = await firebaseMessaging.getToken();
        debugPrint('fcmToken: $fcmToken');
        return fcmToken;
      }
      return null;
    } catch (e, s) {
      firebaseCrashlytics.recordError(e, s);
      return null;
    }
  }

  Future<NotificationSettings> requestNotificationPermission() async {
    final NotificationSettings settings =
        await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');

    return settings;
  }

  Future<http.Response> sendResetPasswordEmail(email) async {
    final response = await http.post(
      getIntranetApiUri('/api/send-reset-password-email'),
      body: {
        'server_key': apiServerKey,
        'email': email,
      },
    );

    return response;
  }

  Future<bool> clearStorage() async {
    await sharedPreferences.remove(usernameKey);
    await sharedPreferences.remove(passwordKey);
    await sharedPreferences.remove(userAuthTokenKey);
    await sharedPreferences.clear();
    return true;
  }

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      getIntranetApiUri('/api/auth'),
      body: {
        'server_key': apiServerKey,
        'username': email,
        'password': password,
      },
    );
    debugPrint(response.body);
    return response;
  }

  Future<http.Response?> checkAuth() async {
    final String? username = sharedPreferences.getString(usernameKey);
    final String? password = sharedPreferences.getString(passwordKey);

    debugPrint('checkAuth $username , $password');

    final validData = username != null && password != null;

    if (validData) {
      firebaseCrashlytics.setUserIdentifier(username);
      final http.Response response = await login(username, password);
      return response;
    }
    return null;
  }
}
