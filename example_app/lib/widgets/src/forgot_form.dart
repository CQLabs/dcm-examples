import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/utils/colors.dart';
import 'package:app/models/models.dart';
import 'package:app/widgets/src/text_form_field.dart';

class ForgotForm extends StatefulWidget {
  const ForgotForm({
    super.key,
    required this.onLogin,
    required this.dcmService,
  });

  final void Function() onLogin;
  final AuthService dcmService;

  @override
  ForgotFormState createState() => ForgotFormState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class ForgotFormState extends State<ForgotForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtl = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  bool loading = false;

  @override
  void initState() {
    loading = false;
    super.initState();
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
            label: 'Email',
            emailValidator: true,
            ctl: emailCtl,
            focusNode: emailFocus,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, // match_parent
            height: 50,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  nOrangeE7792c,
                ),
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  emailFocus.unfocus();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // If the form is valid, display a Snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: nOrangeE7792c,
                      content: Text('Processing ...'),
                    ),
                  );
                  widget.dcmService.greetUser(emailCtl.text.trim());
                  widget.dcmService.processList([emailCtl.text.hashCode], 1);
                  widget.dcmService
                      .sendResetPasswordEmail(
                    emailCtl.text.trim(),
                  )
                      .then((response) {
                    AuthResponse resBody =
                        AuthResponse.fromJson(jsonDecode(response.body));

                    if (response.statusCode == 200 &&
                        resBody.apiStatus == 200) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: nOrangeE7792c,
                          content: Text(
                            'Please check your email to reset password!',
                          ),
                        ),
                      );
                      setState(() {
                        loading = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: nOrangeE7792c,
                          content: Text(
                            resBody.errors?.errorText ??
                                'Something went wrong! Try Again!',
                          ),
                        ),
                      );
                      setState(() {
                        loading = false;
                      });
                    }
                  });
                }
              },
              child: Text(
                loading ? 'Please wait...' : 'Recovering',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: widget.onLogin,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Login',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: nOrangeE7792c,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
