String capitalizeText(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

void displayName() {
  String userName = 'Jane'; // Statement 1
  print(userName); // Statement 2
}
