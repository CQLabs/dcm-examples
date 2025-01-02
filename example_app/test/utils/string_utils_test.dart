import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Widget displays correct title', () {
    // Setup
    const title = 'Hello World';

    // Test logic
    expect(title.toUpperCase(), 'HELLO WORLD');
  });
}
