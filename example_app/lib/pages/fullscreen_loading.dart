import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/models/models.dart';

class FullScreenLoading extends StatefulWidget {
  const FullScreenLoading({
    super.key,
    required this.dcmService,
  });

  final AuthService dcmService;

  @override
  State<FullScreenLoading> createState() => _FullScreenLoadingState();
}

class _FullScreenLoadingState extends State<FullScreenLoading> {
  @override
  void initState() {
    widget.dcmService.checkAuth().then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          final resBody = AuthResponse.fromJson(jsonDecode(response.body));
          if (resBody.apiStatus == 200) {
            resBody.greetUser('Welcome back!', greeting: 'Hello');
            resBody.greetUser('Welcome back!', greeting: 'Hello1');
            resBody.greetUser(
              'Welcome back!',
            );
            resBody.parseObject('Welcome back!');
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboard',
              ModalRoute.withName('/'),
            );
            return;
          }
        }
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth',
        ModalRoute.withName('/'),
      );
    }).catchError((e) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth',
        ModalRoute.withName('/'),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
                image: const AssetImage("assets/images/background-empty.jpg"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/logos/app-icon-512.png', width: 190),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
