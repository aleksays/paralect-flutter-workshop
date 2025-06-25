void demonstrateVariables() {
  print('=== Основы работы с переменными в Dart ===\n');

  // Переменные с явным указанием типа
  int age = 25;
  double height = 175.5;
  String name = 'Алексей';
  bool isStudent = true;

  print('Явное указание типов:');
  print('int age = $age');
  print('double height = $height');
  print('String name = $name');
  print('bool isStudent = $isStudent\n');

  // Автоматический вывод типов с var
  var autoAge = 30;
  var autoName = 'Мария';
  var autoHeight = 165.0;

  print('Автоматический вывод типов с var:');
  print('var autoAge = $autoAge (${autoAge.runtimeType})');
  print('var autoName = $autoName (${autoName.runtimeType})');
  print('var autoHeight = $autoHeight (${autoHeight.runtimeType})\n');

  // Константы
  const pi = 3.14159;
  final currentTime = DateTime.now();

  print('Константы:');
  print('const pi = $pi (компайл-тайм константа)');
  print('final currentTime = $currentTime (рантайм константа)\n');

  // Nullable переменные
  String? nullableName;
  int? nullableAge;

  print('Nullable переменные:');
  print('String? nullableName = $nullableName');
  print('int? nullableAge = $nullableAge\n');

  // Присваивание значений nullable переменным
  nullableName = 'Иван';
  nullableAge = 28;

  print('После присваивания:');
  print('nullableName = $nullableName');
  print('nullableAge = $nullableAge\n');

  // Работа с nullable переменными
  print('Безопасная работа с nullable:');
  print('Длина имени: ${nullableName?.length ?? 0}');
  print('Возраст или 0: ${nullableAge ?? 0}\n');

  // Поздняя инициализация
  late String lateInitialized;
  lateInitialized = 'Инициализировано позже';

  print('Late переменная:');
  print('lateInitialized = $lateInitialized\n');

  // Работа со списками
  List<String> fruits = ['яблоко', 'банан', 'апельсин'];
  var numbers = [1, 2, 3, 4, 5];

  print('Списки:');
  print('fruits = $fruits');
  print('numbers = $numbers');
  print('Первый фрукт: ${fruits[0]}');
  print('Количество чисел: ${numbers.length}\n');

  // Работа с Map
  Map<String, int> ages = {'Алексей': 25, 'Мария': 30, 'Иван': 28};

  print('Map (словарь):');
  print('ages = $ages');
  print('Возраст Марии: ${ages['Мария']}\n');

  // Строковая интерполяция
  String greeting = 'Привет, меня зовут $name, мне $age лет';
  String calculation = '2 + 2 = ${2 + 2}';

  print('Строковая интерполяция:');
  print(greeting);
  print(calculation);
}
