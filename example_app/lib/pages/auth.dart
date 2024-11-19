import 'package:flutter/material.dart';
import 'package:app/widgets/src/forgot_form.dart';
import 'package:app/widgets/src/login_form.dart';
import 'package:app/services/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
    required this.dcmService,
  });

  final AuthService dcmService;

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool loginPage = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/logos/app-icon-512.png', width: 190),
                  if (loginPage)
                    LoginForm(
                      onForgotPassword: () {
                        setState(() {
                          loginPage = false;
                        });
                      },
                      dcmService: widget.dcmService,
                    )
                  else
                    ForgotForm(
                      onLogin: () {
                        setState(() {
                          loginPage = true;
                        });
                      },
                      dcmService: widget.dcmService,
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
