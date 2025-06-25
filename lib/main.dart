// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'dart_examples/variables.dart';
import 'dart_examples/functions.dart';
import 'dart_examples/classes.dart' as dart_classes;
import 'pages/basic_animations_page.dart';
import 'pages/custom_animations_page.dart';
import 'pages/hero_animations_page.dart';
import 'pages/page_transitions_page.dart';
import 'pages/tips_and_tricks_page.dart';
import 'pages/physics_animations_page.dart';
import 'widgets/animation_card.dart';

void main() {
  runApp(const FlutterAnimationsApp());

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

class FlutterAnimationsApp extends StatelessWidget {
  const FlutterAnimationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations Workshop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnimationsHomePage(),
    );
  }
}

class AnimationsHomePage extends StatelessWidget {
  const AnimationsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
          children: [
            AnimationCard(
              title: 'Basic\nAnimations',
              description: 'AnimatedContainer,\nAnimatedOpacity',
              icon: Icons.play_circle,
              color: Colors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BasicAnimationsPage(),
                ),
              ),
            ),
            AnimationCard(
              title: 'Custom\nAnimations',
              description: 'with\nAnimationController',
              icon: Icons.tune,
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomAnimationsPage(),
                ),
              ),
            ),
            AnimationCard(
              title: 'Hero\nAnimations',
              description: 'transitions between\nscreens',
              icon: Icons.flight_takeoff,
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HeroAnimationsPage(),
                ),
              ),
            ),
            AnimationCard(
              title: 'Page\nTransitions',
              description: 'animations',
              icon: Icons.swap_horiz,
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                _createCustomRoute(const PageTransitionsPage()),
              ),
            ),
            AnimationCard(
              title: 'Tips & Tricks',
              description: 'Performance\noptimization and best\npractices',
              icon: Icons.lightbulb,
              color: Colors.amber,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TipsAndTricksPage(),
                ),
              ),
            ),
            AnimationCard(
              title: 'Physics\nAnimations',
              description: 'based animations',
              icon: Icons.psychology,
              color: Colors.teal,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PhysicsAnimationsPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createCustomRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, _) => page,
      transitionsBuilder: (context, animation, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
