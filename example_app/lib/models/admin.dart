class BaseClass {
  const BaseClass();

  String displayMessage(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
