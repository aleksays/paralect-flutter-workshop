void demonstrateClasses() {
  print('=== Классы и ООП в Dart ===\n');

  // Создание объектов
  print('1. Создание объектов:');
  var person1 = Person('Алексей', 25);
  var person2 = Person.withoutAge('Мария');

  person1.introduce();
  person2.introduce();
  print('');

  // Использование геттеров и сеттеров
  print('2. Геттеры и сеттеры:');
  person1.age = 26;
  print('Возраст изменен на: ${person1.age}');
  print('Полное описание: ${person1.fullDescription}');
  print('');

  // Наследование
  print('3. Наследование:');
  var student = Student('Иван', 20, 'Компьютерные науки');
  student.introduce();
  student.study();
  print('');

  // Абстрактные классы
  print('4. Абстрактные классы:');
  var dog = Dog('Бобик');
  var cat = Cat('Мурка');

  dog.makeSound();
  cat.makeSound();
  dog.move();
  cat.move();
  print('');

  // Интерфейсы (implements)
  print('5. Интерфейсы:');
  var car = Car();
  var bicycle = Bicycle();

  car.start();
  bicycle.start();
  print('');

  // Миксины
  print('6. Миксины:');
  var bird = Bird('Воробей');
  bird.eat();
  bird.fly();
  bird.makeSound();
  print('');

  // Перечисления (Enums)
  print('7. Перечисления:');
  demonstrateEnums();
  print('');

  // Обобщения (Generics)
  print('8. Обобщения:');
  var stringBox = Box<String>('Привет');
  var intBox = Box<int>(42);

  print('Строковая коробка: ${stringBox.getValue()}');
  print('Числовая коробка: ${intBox.getValue()}');
  print('');

  // Фабричные конструкторы
  print('9. Фабричные конструкторы:');
  var logger1 = Logger.getInstance();
  var logger2 = Logger.getInstance();
  print('Один и тот же объект: ${identical(logger1, logger2)}');
}

// Базовый класс
class Person {
  String name;
  int _age;

  // Конструктор
  Person(this.name, this._age);

  // Именованный конструктор
  Person.withoutAge(this.name) : _age = 0;

  // Геттер
  int get age => _age;

  // Сеттер
  set age(int value) {
    if (value >= 0) {
      _age = value;
    }
  }

  // Вычисляемое свойство
  String get fullDescription => 'Имя: $name, Возраст: $_age';

  // Метод
  void introduce() {
    print('Привет! Меня зовут $name, мне $_age лет.');
  }
}

// Наследование
class Student extends Person {
  String major;

  Student(String name, int age, this.major) : super(name, age);

  @override
  void introduce() {
    super.introduce();
    print('Я изучаю $major.');
  }

  void study() {
    print('$name занимается изучением $major.');
  }
}

// Абстрактный класс
abstract class Animal {
  String name;

  Animal(this.name);

  void makeSound();

  void move() {
    print('$name движется.');
  }
}

// Реализация абстрактного класса
class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void makeSound() {
    print('$name говорит: Гав-гав!');
  }

  @override
  void move() {
    print('$name бежит на четырех лапах.');
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void makeSound() {
    print('$name говорит: Мяу!');
  }

  @override
  void move() {
    print('$name грациозно ступает.');
  }
}

// Интерфейс (класс для реализации)
abstract class Startable {
  void start();
}

// Реализация интерфейса
class Car implements Startable {
  @override
  void start() {
    print('Машина заводится с ключа.');
  }
}

class Bicycle implements Startable {
  @override
  void start() {
    print('Велосипед начинает движение при педалировании.');
  }
}

// Миксины
mixin Flyable {
  void fly() {
    print('Летаю в небе!');
  }
}

mixin Eatable {
  void eat() {
    print('Кушаю еду.');
  }
}

class Bird extends Animal with Flyable, Eatable {
  Bird(String name) : super(name);

  @override
  void makeSound() {
    print('$name поет: Чирик-чирик!');
  }
}

// Перечисления
enum Color { red, green, blue, yellow }

enum Status {
  pending('В ожидании'),
  approved('Одобрено'),
  rejected('Отклонено');

  const Status(this.description);
  final String description;
}

void demonstrateEnums() {
  var color = Color.red;
  print('Выбранный цвет: $color');
  print('Индекс цвета: ${color.index}');

  var status = Status.approved;
  print('Статус: ${status.description}');

  // Использование enum в switch
  switch (color) {
    case Color.red:
      print('Красный - цвет страсти');
      break;
    case Color.green:
      print('Зеленый - цвет природы');
      break;
    default:
      print('Другой цвет');
  }
}

// Обобщения (Generics)
class Box<T> {
  T _value;

  Box(this._value);

  T getValue() => _value;

  void setValue(T value) {
    _value = value;
  }
}

// Синглтон с фабричным конструктором
class Logger {
  static Logger? _instance;

  Logger._internal();

  factory Logger.getInstance() {
    return _instance ??= Logger._internal();
  }

  void log(String message) {
    print('[LOG] $message');
  }
}
