void demonstrateClasses() {
  print('=== Dart Classes and OOP Basics ===\n');

  // Basic class usage
  print('1. Basic Classes:');
  var person = Person('Alice', 30);
  person.introduce();
  person.celebrateBirthday();
  print('');

  // Class with different constructors
  print('2. Different Constructors:');
  var student1 = Student('Bob', 20, 'Computer Science');
  var student2 = Student.withGrade('Charlie', 22, 'Mathematics', 85.5);
  var student3 = Student.graduate('Diana', 24, 'Physics');

  student1.study();
  student2.showGrade();
  student3.study();
  print('');

  // Inheritance
  print('3. Inheritance:');
  var employee = Employee('Frank', 35, 'Engineer', 75000);
  employee.introduce(); // Inherited from Person
  employee.work();
  print('Salary: \$${employee.salary}');
  print('');

  // Abstract classes and polymorphism
  print('4. Abstract Classes and Polymorphism:');
  var shapes = <Shape>[Circle(5.0), Rectangle(4.0, 6.0), Triangle(3.0, 4.0)];

  for (var shape in shapes) {
    print('${shape.name} area: ${shape.calculateArea().toStringAsFixed(2)}');
  }
  print('');

  // Mixins
  print('5. Mixins:');
  var swimmer = Swimmer('Grace', 25);
  swimmer.introduce();
  swimmer.swim();
  swimmer.dive();
  print('');

  // Getters and Setters
  print('6. Getters and Setters:');
  var car = Car('Toyota', 'Camry');
  print('Full name: ${car.fullName}');

  car.speed = 60;
  print('Current speed: ${car.speed} km/h');
  car.accelerate(20);
  print('Speed after acceleration: ${car.speed} km/h');
  print('');

  // Static members
  print('7. Static Members:');
  print('Math constants: π = ${MathUtils.pi}, e = ${MathUtils.e}');
  print('Circle area (radius 3): ${MathUtils.circleArea(3)}');
  print('Rectangle area (4x5): ${MathUtils.rectangleArea(4, 5)}');
}

// Basic class
class Person {
  String name;
  int age;

  // Constructor
  Person(this.name, this.age);

  // Method
  void introduce() {
    print('Hi, I\'m $name and I\'m $age years old.');
  }

  void celebrateBirthday() {
    age++;
    print('$name is now $age years old. Happy Birthday!');
  }
}

// Class with multiple constructors
class Student extends Person {
  String major;
  double? grade;

  // Default constructor
  Student(String name, int age, this.major) : super(name, age);

  // Named constructor
  Student.withGrade(String name, int age, this.major, this.grade)
    : super(name, age);

  // Factory constructor
  factory Student.graduate(String name, int age, String major) {
    return Student.withGrade(name, age, major, 95.0);
  }

  void study() {
    print('$name is studying $major.');
  }

  void showGrade() {
    if (grade != null) {
      print('$name has a grade of ${grade!.toStringAsFixed(1)} in $major.');
    } else {
      print('$name has no grade recorded yet.');
    }
  }
}

// Inheritance example
class Employee extends Person {
  String position;
  double salary;

  Employee(String name, int age, this.position, this.salary) : super(name, age);

  void work() {
    print('$name is working as a $position.');
  }
}

// Abstract class
abstract class Shape {
  String get name;
  double calculateArea();
}

// Concrete implementations
class Circle extends Shape {
  final double radius;

  Circle(this.radius);

  @override
  String get name => 'Circle';

  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  String get name => 'Rectangle';

  @override
  double calculateArea() {
    return width * height;
  }
}

class Triangle extends Shape {
  final double base;
  final double height;

  Triangle(this.base, this.height);

  @override
  String get name => 'Triangle';

  @override
  double calculateArea() {
    return 0.5 * base * height;
  }
}

// Mixins
mixin Swimming {
  void swim() {
    print('Swimming in the water...');
  }

  void dive() {
    print('Diving underwater...');
  }
}

class Swimmer extends Person with Swimming {
  Swimmer(String name, int age) : super(name, age);
}

// Class with getters and setters
class Car {
  String brand;
  String model;
  double _speed = 0;

  Car(this.brand, this.model);

  // Getter
  String get fullName => '$brand $model';

  // Getter and setter for speed
  double get speed => _speed;

  set speed(double value) {
    if (value >= 0 && value <= 200) {
      _speed = value;
    } else {
      print('Invalid speed. Must be between 0 and 200 km/h.');
    }
  }

  void accelerate(double amount) {
    speed = _speed + amount;
  }
}

// Class with static members
class MathUtils {
  static const double pi = 3.14159;
  static const double e = 2.71828;

  static double circleArea(double radius) {
    return pi * radius * radius;
  }

  static double rectangleArea(double width, double height) {
    return width * height;
  }
}
