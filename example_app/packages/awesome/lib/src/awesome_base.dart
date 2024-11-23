import 'package:awesome/src/animal.dart';

class Awesome {
  bool get isAwesome => true;

  void doAwesomeThings() {
    print('Doing awesome things!');
  }

  dogBark({bool isDog = true}) {
    return Dog('Lucy').speak();
  }
}
