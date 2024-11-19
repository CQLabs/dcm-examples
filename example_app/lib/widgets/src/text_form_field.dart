import 'package:flutter/material.dart';
import 'package:app/utils/colors.dart';

class DcmTextFormField extends StatelessWidget {
  const DcmTextFormField({
    super.key,
    required this.label,
    required this.ctl,
    required this.focusNode,
    this.obscureText = false,
    this.emailValidator = false,
  });

  final String label;
  final bool emailValidator;
  final bool obscureText;
  final TextEditingController ctl;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctl,
      focusNode: focusNode,
      autocorrect: false,
      autofocus: false,
      enableSuggestions: false,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: nOrangeE7792c),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
      ),
      validator: textValidator,
    );
  }

  String? textValidator(String? value) {
    final hasValue = value != null;
    if (hasValue) {
      if (emailValidator) {
        final RegExp regExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!regExp.hasMatch(value)) {
          return 'Your $label is not valid!';
        }
      }
      if (value.isEmpty) {
        return 'Your $label is empty!';
      }
    }
    return null;
  }
}
