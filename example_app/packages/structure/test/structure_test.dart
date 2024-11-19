import 'package:structure/structure.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final structure = Structure();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(structure.hasStructure, isTrue);
    });
  });
}
