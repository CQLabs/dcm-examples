import 'package:app/models/admin.dart';

class SubClass extends BaseClass {
  const SubClass();

  @override
  String displayMessage(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
