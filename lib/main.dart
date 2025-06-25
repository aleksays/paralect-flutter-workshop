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
            'Welcome to Flutter Workshop!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Choose a topic to explore:',
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
                'Switch to branch: ${topic.branch}\nThis feature is available in the corresponding branch',
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
    title: 'Clean Architecture + BLoC',
    description:
        'REST API with BLoC state management and event-driven architecture',
    branch: '03-rest-api-futurebuilder',
    icon: Icons.architecture,
    color: Colors.blue,
  ),
  const WorkshopTopic(
    title: 'Clean Architecture + Provider',
    description:
        'REST API with Provider state management and ChangeNotifier pattern',
    branch: '04-rest-api-provider',
    icon: Icons.layers,
    color: Colors.green,
  ),
  const WorkshopTopic(
    title: 'Clean Architecture + Riverpod',
    description:
        'REST API with Riverpod state management and modern reactive programming',
    branch: '05-rest-api-riverpod',
    icon: Icons.track_changes,
    color: Colors.purple,
  ),
];
