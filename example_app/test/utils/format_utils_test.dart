import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Check title in uppercase', () {
    // Setup
    const title = 'Hello World';

    // Test logic
    expect(title.toUpperCase(), 'HELLO WORLD');
  });
}
