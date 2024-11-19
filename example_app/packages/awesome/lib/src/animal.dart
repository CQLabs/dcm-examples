class Animal {
  Animal(this.name);

  String name;

  void speak() {
    print('Animal speaks');
  }
}

class Dog extends Animal {
  Dog(super.name);

  @override
  void speak() {
    print('Dog barks');
  }
}
