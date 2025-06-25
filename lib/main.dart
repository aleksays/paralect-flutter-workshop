import 'package:flutter/material.dart';
import 'dart_examples/01_variables.dart';
import 'dart_examples/02_functions.dart';
import 'dart_examples/03_classes.dart' as dart_classes;

void main() {
  runApp(const DartBasicsApp());

  // Демонстрация Dart примеров в консоли
  print('\n🎯 Запуск демонстрации основ Dart...\n');

  demonstrateVariables();
  print('\n' + '=' * 50 + '\n');

  demonstrateFunctions();
  print('\n' + '=' * 50 + '\n');

  dart_classes.demonstrateClasses();
  print('\n' + '=' * 50 + '\n');

  print('✅ Демонстрация основ Dart завершена!');
  print('🔍 Изучите код в папке lib/dart_examples/');
}

class DartBasicsApp extends StatelessWidget {
  const DartBasicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart Basics Workshop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DartBasicsPage(),
    );
  }
}

class DartBasicsPage extends StatelessWidget {
  const DartBasicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Основы Dart'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.code, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'Основы языка Dart',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Добро пожаловать в изучение основ языка Dart! '
              'В этой части воркшопа мы изучим основные концепции языка.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildTopicSection(context, '1. Переменные и типы данных', [
              'Явное и автоматическое определение типов',
              'Nullable и Non-nullable типы',
              'Константы (const и final)',
              'Коллекции (List, Map, Set)',
              'Строковая интерполяция',
            ], Colors.blue.shade600),
            const SizedBox(height: 24),
            _buildTopicSection(context, '2. Функции', [
              'Объявление и вызов функций',
              'Параметры (позиционные, именованные, опциональные)',
              'Анонимные функции и лямбды',
              'Функции высшего порядка',
              'Асинхронное программирование',
            ], Colors.green.shade600),
            const SizedBox(height: 24),
            _buildTopicSection(context, '3. Классы и ООП', [
              'Создание классов и объектов',
              'Конструкторы (обычные, именованные, фабричные)',
              'Наследование и полиморфизм',
              'Абстрактные классы и интерфейсы',
              'Миксины и обобщения',
            ], Colors.orange.shade600),
            const SizedBox(height: 32),
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          'Практические примеры',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Все примеры кода выполняются при запуске приложения '
                      'и выводятся в консоль. Откройте консоль в вашей IDE, '
                      'чтобы увидеть результаты выполнения.',
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Исследуйте код в следующих файлах:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    ...[
                      'lib/dart_examples/01_variables.dart',
                      'lib/dart_examples/02_functions.dart',
                      'lib/dart_examples/03_classes.dart',
                    ].map(
                      (file) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            const Icon(Icons.file_copy, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              file,
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.arrow_forward, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          'Что дальше?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'После изучения основ Dart переходите к изучению Flutter:',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'git checkout 02-flutter-basics',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        backgroundColor: Colors.black12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicSection(
    BuildContext context,
    String title,
    List<String> items,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.circle, color: color, size: 12),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(item, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
