class Animal {
  Animal(this.name);

  String name;

  void speak() {
    print('Animal speaks');
  }

  void run() {
    print('Animal runs');
  }
}

class Dog extends Animal {
  Dog(super.name);

  @override
  void speak() {
    print('Dog barks');
  }

  @override
  void run() {
    print('Dog runs');
  }
}
