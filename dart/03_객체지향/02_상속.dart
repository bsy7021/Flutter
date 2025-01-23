class Animal {
  void makeSound() {
    print('어흥');
  }
}

// 상속
class Dog extends Animal {
  @override
  void makeSound() {
    print('그르륽');
  }
}

void main() {
  var dog = Dog();
  dog.makeSound(); // 출력: 그르륽
}
