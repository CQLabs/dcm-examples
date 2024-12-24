import 'package:app/pages/auth.dart';
import 'package:app/pages/dashboard.dart';
import 'package:app/pages/fullscreen_loading.dart';
import 'package:app/utils/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app/services/auth_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    final stream = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text(message.notification?.title ?? ''),
                const SizedBox(height: 10),
                Text(message.notification?.body ?? ''),
              ],
            ),
          ),
        );
        debugPrint(
          'Message also contained a notification: ${message.notification?.title}',
        );
      }
    });
    stream.onError((error) {
      stream.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      theme: ThemeData(primaryColor: nOrangeE7792c),
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: widget.dcmService.firebaseAnalytics,
        ),
      ],
      routes: {
        "/": (_) => FullScreenLoading(dcmService: widget.dcmService),
        "/dashboard": (_) => DashboardPage(
              dcmService: widget.dcmService,
              mode: MediaQuery.platformBrightnessOf(context) == Brightness.dark
                  ? "night"
                  : "day",
            ),
        "/auth": (_) => AuthPage(dcmService: widget.dcmService),
      },
    );
  }
}
