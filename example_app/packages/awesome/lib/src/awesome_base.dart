import 'package:awesome/src/animal.dart';

class Awesome {
  bool get isAwesome => true;

  void doAwesomeThings() {
    print('Doing awesome things!');
  }

  dogBark() {
    return Dog('Lucy').speak();
  }
}
