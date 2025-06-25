// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'dart_examples/variables.dart';
import 'dart_examples/functions.dart';
import 'dart_examples/classes.dart' as dart_classes;

void main() {
  runApp(const DartBasicsApp());

  // Demonstrating Dart examples in console
  print('\n🎯 Starting Dart basics demonstration...\n');

  demonstrateVariables();
  print('\n' + '=' * 50 + '\n');

  demonstrateFunctions();
  print('\n' + '=' * 50 + '\n');

  dart_classes.demonstrateClasses();
  print('\n' + '=' * 50 + '\n');

  print('✅ Dart basics demonstration completed!');
  print('🔍 Explore the code in lib/dart_examples/ folder');
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
        title: const Text('Dart Basics'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.code, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'Dart Language Fundamentals',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to learning Dart language fundamentals! '
              'In this part of the workshop, we will study the core concepts of the language.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildTopicSection(context, '1. Variables and Data Types', [
              'Explicit and automatic type inference',
              'Nullable and Non-nullable types',
              'Constants (const and final)',
              'Collections (List, Map, Set)',
              'String interpolation',
            ], Colors.blue.shade600),
            const SizedBox(height: 24),
            _buildTopicSection(context, '2. Functions', [
              'Function declaration and invocation',
              'Parameters (positional, named, optional)',
              'Anonymous functions and lambdas',
              'Higher-order functions',
              'Asynchronous programming',
            ], Colors.green.shade600),
            const SizedBox(height: 24),
            _buildTopicSection(context, '3. Classes and OOP', [
              'Creating classes and objects',
              'Constructors (default, named, factory)',
              'Inheritance and polymorphism',
              'Abstract classes and interfaces',
              'Mixins and generics',
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
                          'Practical Examples',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'All code examples are executed when the app starts '
                      'and output to the console. Open the console in your IDE '
                      'to see the execution results.',
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Explore the code in the following files:',
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
                          'What\'s Next?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'After learning Dart basics, proceed to studying Flutter:',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'git checkout 03-rest-api-futurebuilder',
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
                Container(width: 4, height: 24, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
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
