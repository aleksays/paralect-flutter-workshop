# 🎯 Dart Fundamentals - Flutter Workshop

Welcome to the first part of the Flutter Workshop! Here we'll learn the fundamentals of the Dart programming language.

## 📖 What You'll Learn

### 1. Variables and Data Types
- Explicit and automatic type inference (`int`, `String`, `var`)
- Nullable and non-nullable types (`String?`, `int?`)
- Constants (`const` vs `final`)
- Collections (`List`, `Map`, `Set`)
- String interpolation

### 2. Functions
- Function declaration and invocation
- Parameters (positional, named, optional)
- Arrow functions
- Anonymous functions and lambdas
- Higher-order functions
- Asynchronous programming (`async/await`)

### 3. Classes and OOP
- Creating classes and objects
- Constructors (default, named, factory)
- Getters and setters
- Inheritance and polymorphism
- Abstract classes and interfaces
- Mixins (`mixin`)
- Generics

## 🚀 How to Run

1. Make sure you're on the correct branch:
```bash
git branch
# Should show: * 01-dart-basics
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

## 📱 What Happens

When you run the application:

1. **In the console** - all Dart code examples are executed
2. **In the app** - a beautiful interface displays topic descriptions

## 📚 Code Study

Open and explore the following files:

### `lib/dart_examples/01_variables.dart`
Variable examples:
- Declaring variables of different types
- Working with nullable variables
- Using constants
- Operations with collections

### `lib/dart_examples/02_functions.dart`
Function examples:
- Various ways to declare functions
- Working with parameters
- Asynchronous operations
- Generators

### `lib/dart_examples/03_classes.dart`
OOP examples:
- Creating classes
- Inheritance
- Abstract classes
- Mixins
- Enumerations (Enums)

## 🎓 Practical Exercises

After studying the examples, try to:

1. **Create your own class** `Car` with fields `brand`, `model`, `year`
2. **Add methods** to display car information
3. **Use inheritance** - create an `ElectricCar` class
4. **Write a function** to filter a list of cars by year

## 🔍 Useful Resources

- [Official Dart Documentation](https://dart.dev/language)
- [Dart Language Tour](https://dart.dev/language/tour)
- [DartPad - Online Editor](https://dartpad.dev/)

## ➡️ What's Next?

After learning Dart fundamentals, proceed to studying Flutter:

```bash
git checkout 03-rest-api-futurebuilder
```

## 💡 Tips

- **Experiment** - modify the code and see what happens
- **Use the console** - all examples output results to the console
- **Read errors** - they help understand code problems
- **Ask questions** - if something is unclear

---

**Next Topic**: [Clean Architecture + BLoC](../03-rest-api-futurebuilder)  
**Back**: [Main](../main)
