import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterWorkshopApp());
}

class FlutterWorkshopApp extends StatelessWidget {
  const FlutterWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Workshop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WorkshopMenuPage(),
    );
  }
}

class WorkshopMenuPage extends StatelessWidget {
  const WorkshopMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Workshop'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Добро пожаловать в Flutter Workshop!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Выберите тему для изучения:',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ...workshopTopics.map((topic) => _buildTopicCard(context, topic)),
        ],
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, WorkshopTopic topic) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(topic.icon, color: topic.color, size: 32),
        title: Text(
          topic.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(topic.description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Переключитесь на ветку: ${topic.branch}\nЭта функция доступна в соответствующей ветке',
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        },
      ),
    );
  }
}

class WorkshopTopic {
  final String title;
  final String description;
  final String branch;
  final IconData icon;
  final Color color;

  const WorkshopTopic({
    required this.title,
    required this.description,
    required this.branch,
    required this.icon,
    required this.color,
  });
}

final List<WorkshopTopic> workshopTopics = [
  const WorkshopTopic(
    title: 'Основы Dart',
    description: 'Переменные, функции, классы, наследование',
    branch: '01-dart-basics',
    icon: Icons.code,
    color: Colors.blue,
  ),
  const WorkshopTopic(
    title: 'Основы Flutter',
    description: 'Виджеты, layout, stateful/stateless',
    branch: '02-flutter-basics',
    icon: Icons.widgets,
    color: Colors.green,
  ),
  const WorkshopTopic(
    title: 'REST API + FutureBuilder',
    description: 'Работа с API, json_serializable, FutureBuilder',
    branch: '03-rest-api-futurebuilder',
    icon: Icons.api,
    color: Colors.orange,
  ),
  const WorkshopTopic(
    title: 'REST API + Provider',
    description: 'Управление состоянием с Provider, posts feed',
    branch: '04-rest-api-provider',
    icon: Icons.layers,
    color: Colors.purple,
  ),
  const WorkshopTopic(
    title: 'REST API + BLoC',
    description: 'Управление состоянием с BLoC, posts feed',
    branch: '05-rest-api-bloc',
    icon: Icons.architecture,
    color: Colors.red,
  ),
  const WorkshopTopic(
    title: 'REST API + Riverpod',
    description: 'Управление состоянием с Riverpod, posts feed',
    branch: '06-rest-api-riverpod',
    icon: Icons.track_changes,
    color: Colors.teal,
  ),
  const WorkshopTopic(
    title: 'Темы + Provider',
    description: 'Переключение тем (system, light, dark) с Provider',
    branch: '07-theme-provider',
    icon: Icons.palette,
    color: Colors.indigo,
  ),
  const WorkshopTopic(
    title: 'Темы + BLoC',
    description: 'Переключение тем (system, light, dark) с BLoC',
    branch: '08-theme-bloc',
    icon: Icons.brightness_6,
    color: Colors.pink,
  ),
  const WorkshopTopic(
    title: 'Темы + Riverpod',
    description: 'Переключение тем (system, light, dark) с Riverpod',
    branch: '09-theme-riverpod',
    icon: Icons.dark_mode,
    color: Colors.brown,
  ),
  const WorkshopTopic(
    title: 'Анимации',
    description: 'Implicit и Explicit анимации, Hero анимации',
    branch: '10-animations',
    icon: Icons.animation,
    color: Colors.cyan,
  ),
  const WorkshopTopic(
    title: 'Tips & Tricks',
    description: 'Полезные советы и трюки для Flutter разработки',
    branch: '11-tips-tricks',
    icon: Icons.lightbulb,
    color: Colors.amber,
  ),
];
