import 'package:app/pages/auth.dart';
import 'package:app/pages/dashboard/dashboard.dart';
import 'package:app/pages/fullscreen_loading.dart';
import 'package:app/utils/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app/services/auth_service.dart';

class App extends StatefulWidget {
  const App({super.key, required this.dcmService});

  final AuthService dcmService;

  @override
  State<App> createState() => _DcmDevAppState();
}

class _DcmDevAppState extends State<App> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text(
                  message.notification?.title ?? '',
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message.notification?.body ?? '',
                )
              ],
            ),
          ),
        );
        debugPrint(
          'Message also contained a notification: ${message.notification?.title}',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DCM App',
      theme: ThemeData(
        primaryColor: nOrangeE7792c,
      ),
      navigatorObservers: <NavigatorObserver>[
        FirebaseAnalyticsObserver(
          analytics: widget.dcmService.firebaseAnalytics,
        ),
      ],
      routes: {
        "/": (_) => FullScreenLoading(
              dcmService: widget.dcmService,
            ),
        "/dashboard": (_) => DashboardPage(
              dcmService: widget.dcmService,
              mode: MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? "night"
                  : "day",
            ),
        "/auth": (_) => AuthPage(dcmService: widget.dcmService),
      },
    );
  }
}
