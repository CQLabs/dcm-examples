import 'package:awesome/src/animal.dart';
import 'package:awesome/internal.dart';

class Awesome {
  bool get isAwesome => true;

  void doAwesomeThings() {
    SomeClass().someMethod();
    print('Doing awesome things!');
  }

  dogBark({bool isDog = true}) {
    return Dog('Lucy').speak();
  }
}
