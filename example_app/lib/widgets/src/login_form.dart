// Create a Form widget.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/utils/colors.dart';
import 'package:app/models/models.dart';
import 'package:app/widgets/src/text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.onForgotPassword,
    required this.dcmService,
  });

  final void Function() onForgotPassword;
  final AuthService dcmService;

  @override
  LoginFormState createState() => LoginFormState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameCtl.dispose();
    passwordCtl.dispose();
    passwordFocus.dispose();
    usernameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DcmTextFormField(
              label: 'Email / Username',
              focusNode: usernameFocus,
              emailValidator: false,
              ctl: usernameCtl),
          const SizedBox(height: 20),
          DcmTextFormField(
            label: 'Password',
            obscureText: true,
            focusNode: passwordFocus,
            ctl: passwordCtl,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: widget.onForgotPassword,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Forgot Password?',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: nOrangeE7792c,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, // match_parent
            height: 50,
            child: loading
                ? const Text('Please wait...')
                : ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        nOrangeE7792c,
                      ),
                    ),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState!.validate()) {
                        final String username = usernameCtl.text.trim();
                        final String password = passwordCtl.text.trim();

                        usernameFocus.unfocus();
                        passwordFocus.unfocus();
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        // If the form is valid, display a Snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: nOrangeE7792c,
                            content: Text('Processing ...'),
                          ),
                        );
                        setState(() {
                          loading = true;
                        });

                        widget.dcmService
                            .login(username, password)
                            .then((response) {
                          final resBody = AuthResponse.fromJson(
                            jsonDecode(response.body),
                          );

                          if (response.statusCode == 200 &&
                              resBody.apiStatus == 200) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            widget.dcmService
                                .saveToStorage(username, password)
                                .then((saved) {
                              if (saved) {
                                Navigator.of(context).pushReplacementNamed(
                                  '/dashboard',
                                );
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: nOrangeE7792c,
                                  content: Text(
                                    'Cannot store the data!',
                                  ),
                                ),
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: nOrangeE7792c,
                                content: Text(
                                  resBody.errors?.errorText ?? 'Unknown Error!',
                                ),
                              ),
                            );
                          }
                          setState(() {
                            loading = false;
                          });
                        });
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
