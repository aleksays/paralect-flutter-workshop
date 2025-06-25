// ignore_for_file: avoid_print

void demonstrateFunctions() {
  print('=== Dart Functions Basics ===\n');

  // Basic function call
  print('1. Basic Functions:');
  greet('Alice');
  int result = add(5, 3);
  print('5 + 3 = $result\n');

  // Functions with optional parameters
  print('2. Optional Parameters:');
  printPersonInfo('Bob');
  printPersonInfo('Charlie', 25);
  printPersonInfo('Diana', 30, 'Engineer');

  // Named parameters
  print('\n3. Named Parameters:');
  createUser(name: 'Eve', email: 'eve@example.com');
  createUser(name: 'Frank', email: 'frank@example.com', age: 28);

  // Anonymous functions and lambdas
  print('\n4. Anonymous Functions:');
  var numbers = [1, 2, 3, 4, 5];

  print('Original numbers: $numbers');

  var doubled = numbers.map((n) => n * 2).toList();
  print('Doubled: $doubled');

  var evenNumbers = numbers.where((n) => n % 2 == 0).toList();
  print('Even numbers: $evenNumbers');

  // Higher-order functions
  print('\n5. Higher-order Functions:');
  int multiplyResult = calculate(10, 5, (a, b) => a * b);
  print('10 * 5 = $multiplyResult');

  int divideResult = calculate(10, 5, (a, b) => a ~/ b);
  print('10 ~/ 5 = $divideResult');

  // Function as variable
  print('\n6. Functions as Variables:');
  var mathOperation = add;
  print('Using function variable: ${mathOperation(7, 3)}');

  // Closure example
  print('\n7. Closures:');
  var counter = createCounter();
  print('Counter: ${counter()}'); // 1
  print('Counter: ${counter()}'); // 2
  print('Counter: ${counter()}'); // 3

  // Arrow functions
  print('\n8. Arrow Functions:');
  square(int x) => x * x;
  print('Square of 4: ${square(4)}');

  isEven(int x) => x % 2 == 0;
  print('Is 7 even? ${isEven(7)}');
  print('Is 8 even? ${isEven(8)}');
}

// Basic function
void greet(String name) {
  print('Hello, $name!');
}

// Function with return value
int add(int a, int b) {
  return a + b;
}

// Function with optional positional parameters
void printPersonInfo(String name, [int? age, String? profession]) {
  String info = 'Name: $name';
  if (age != null) info += ', Age: $age';
  if (profession != null) info += ', Profession: $profession';
  print(info);
}

// Function with named parameters
void createUser({required String name, required String email, int? age}) {
  String userInfo = 'User created - Name: $name, Email: $email';
  if (age != null) userInfo += ', Age: $age';
  print(userInfo);
}

// Higher-order function
int calculate(int a, int b, int Function(int, int) operation) {
  return operation(a, b);
}

// Function that returns a function (closure)
Function createCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

// Generic function
T getFirst<T>(List<T> list) {
  if (list.isEmpty) {
    throw Exception('List is empty');
  }
  return list.first;
}

// Async function example (basic)
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Data fetched successfully!';
}
