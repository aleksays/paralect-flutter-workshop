// ignore_for_file: avoid_print

void demonstrateVariables() {
  print('=== Dart Variables and Data Types Basics ===\n');

  // Variables with explicit type declaration
  int age = 25;
  double height = 1.75;
  String name = 'Alex';
  bool isStudent = true;

  print('Explicit type declaration:');
  print('int age = $age');
  print('double height = $height');
  print('String name = $name');
  print('bool isStudent = $isStudent\n');

  // Automatic type inference with var
  var autoAge = 30; // Dart infers int
  var autoName = 'Maria'; // Dart infers String
  var autoPrice = 99.99; // Dart infers double

  print('Automatic type inference with var:');
  print('var autoAge = $autoAge (${autoAge.runtimeType})');
  print('var autoName = $autoName (${autoName.runtimeType})');
  print('var autoPrice = $autoPrice (${autoPrice.runtimeType})\n');

  // Constants
  const pi = 3.14159; // Compile-time constant
  final currentTime = DateTime.now(); // Runtime constant

  print('Constants:');
  print('const pi = $pi');
  print('final currentTime = $currentTime\n');

  // Nullable and Non-nullable types
  String nonNullableString = 'This cannot be null';
  String? nullableString; // Can be null
  nullableString = 'Now it has a value';

  print('Nullable types:');
  print('String nonNullableString = "$nonNullableString"');
  print('String? nullableString = "$nullableString"\n');

  // Collections
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  Map<String, int> scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};
  Set<String> uniqueColors = {'Red', 'Green', 'Blue', 'Yellow'};

  print('Collections:');
  print('List<String> fruits = $fruits');
  print('Map<String, int> scores = $scores');
  print('Set<String> uniqueColors = $uniqueColors\n');

  // String interpolation
  String studentName = 'John';
  int studentAge = 20;
  double studentGrade = 85.5;

  print('String interpolation:');
  print('Student: $studentName, Age: $studentAge, Grade: $studentGrade');
  print('Next year $studentName will be ${studentAge + 1} years old');
  print('Grade with 2 decimal places: ${studentGrade.toStringAsFixed(2)}\n');

  // Dynamic type
  dynamic flexibleVariable = 'Initially a string';
  print('Dynamic type:');
  print(
    'dynamic flexibleVariable = "$flexibleVariable" (${flexibleVariable.runtimeType})',
  );

  flexibleVariable = 42;
  print(
    'flexibleVariable = $flexibleVariable (${flexibleVariable.runtimeType})',
  );

  flexibleVariable = true;
  print(
    'flexibleVariable = $flexibleVariable (${flexibleVariable.runtimeType})\n',
  );
}
