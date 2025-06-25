void demonstrateFunctions() {
  print('=== Функции в Dart ===\n');

  // Простая функция
  print('1. Простые функции:');
  sayHello();
  print('');

  // Функция с параметрами
  print('2. Функции с параметрами:');
  greetPerson('Алексей');
  print('');

  // Функция с возвращаемым значением
  print('3. Функции с возвращаемым значением:');
  int sum = addNumbers(5, 3);
  print('Сумма 5 + 3 = $sum');
  print('');

  // Функция с именованными параметрами
  print('4. Функции с именованными параметрами:');
  createUser(name: 'Мария', age: 25);
  createUser(name: 'Иван', age: 30, city: 'Москва');
  print('');

  // Функция с опциональными позиционными параметрами
  print('5. Опциональные позиционные параметры:');
  print('Сумма двух чисел: ${calculate(10, 5)}');
  print('Сумма трех чисел: ${calculate(10, 5, 2)}');
  print('');

  // Функция со значениями по умолчанию
  print('6. Значения по умолчанию:');
  printMessage('Привет!');
  printMessage('Важное сообщение!', prefix: '[ВАЖНО]');
  print('');

  // Анонимные функции (лямбды)
  print('7. Анонимные функции:');
  var numbers = [1, 2, 3, 4, 5];
  var doubled = numbers.map((n) => n * 2).toList();
  print('Исходный список: $numbers');
  print('Удвоенные числа: $doubled');
  print('');

  // Функции высшего порядка
  print('8. Функции высшего порядка:');
  var evenNumbers = numbers.where((n) => n % 2 == 0).toList();
  print('Четные числа: $evenNumbers');

  numbers.forEach((n) => print('Число: $n'));
  print('');

  // Функция, возвращающая функцию
  print('9. Функция, возвращающая функцию:');
  var multiplier = createMultiplier(3);
  print('Умножение на 3: ${multiplier(4)}');
  print('');

  // Рекурсивная функция
  print('10. Рекурсивная функция:');
  print('Факториал 5 = ${factorial(5)}');
  print('');

  // Асинхронные функции
  print('11. Асинхронные функции:');
  demonstrateAsync();
}

// Простая функция без параметров
void sayHello() {
  print('Привет, мир!');
}

// Функция с параметром
void greetPerson(String name) {
  print('Привет, $name!');
}

// Функция с возвращаемым значением
int addNumbers(int a, int b) {
  return a + b;
}

// Краткая запись функции (стрелочная функция)
int multiply(int a, int b) => a * b;

// Функция с именованными параметрами
void createUser({required String name, required int age, String? city}) {
  print(
    'Пользователь: $name, возраст: $age${city != null ? ', город: $city' : ''}',
  );
}

// Функция с опциональными позиционными параметрами
int calculate(int a, int b, [int? c]) {
  return c != null ? a + b + c : a + b;
}

// Функция со значениями по умолчанию
void printMessage(String message, {String prefix = '[INFO]'}) {
  print('$prefix $message');
}

// Функция, возвращающая функцию
Function createMultiplier(int factor) {
  return (int value) => value * factor;
}

// Рекурсивная функция
int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

// Асинхронная функция
Future<void> demonstrateAsync() async {
  print('Начало асинхронной операции...');

  // Имитация асинхронной операции
  await Future.delayed(Duration(seconds: 1));

  print('Асинхронная операция завершена!');
}

// Генератор синхронный
Iterable<int> countTo(int max) sync* {
  for (int i = 1; i <= max; i++) {
    yield i;
  }
}

// Генератор асинхронный
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}
