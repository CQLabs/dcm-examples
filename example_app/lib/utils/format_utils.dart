String capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

void printName() {
  String name = 'John'; // Statement 1
  print(name); // Statement 2
}
