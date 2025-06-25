// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'dart_examples/variables.dart';
import 'dart_examples/functions.dart';
import 'dart_examples/classes.dart' as dart_classes;

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
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildAnimationCard(
            context,
            'Basic Animations',
            'Implicit animations like AnimatedContainer, AnimatedOpacity',
            Icons.play_circle,
            Colors.blue,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BasicAnimationsPage(),
              ),
            ),
          ),
          _buildAnimationCard(
            context,
            'Custom Animations',
            'Explicit animations with AnimationController',
            Icons.tune,
            Colors.green,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomAnimationsPage(),
              ),
            ),
          ),
          _buildAnimationCard(
            context,
            'Hero Animations',
            'Shared element transitions between screens',
            Icons.flight_takeoff,
            Colors.orange,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HeroAnimationsPage(),
              ),
            ),
          ),
          _buildAnimationCard(
            context,
            'Page Transitions',
            'Custom page route animations',
            Icons.swap_horiz,
            Colors.purple,
            () => Navigator.push(
              context,
              _createCustomRoute(const PageTransitionsPage()),
            ),
          ),
          _buildAnimationCard(
            context,
            'Tips & Tricks',
            'Performance optimization and best practices',
            Icons.lightbulb,
            Colors.amber,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TipsAndTricksPage(),
              ),
            ),
          ),
          _buildAnimationCard(
            context,
            'Physics Animations',
            'Spring and gravity-based animations',
            Icons.psychology,
            Colors.teal,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PhysicsAnimationsPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createCustomRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}

// Basic Animations Page
class BasicAnimationsPage extends StatefulWidget {
  const BasicAnimationsPage({super.key});

  @override
  State<BasicAnimationsPage> createState() => _BasicAnimationsPageState();
}

class _BasicAnimationsPageState extends State<BasicAnimationsPage> {
  bool _isExpanded = false;
  double _opacity = 1.0;
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;
  double _borderRadius = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Animations'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'AnimatedContainer',
              'Animate size, color, border radius, and more',
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
              ),
              [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _width = _width == 100 ? 200 : 100;
                      _height = _height == 100 ? 150 : 100;
                    });
                  },
                  child: const Text('Change Size'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _color = _color == Colors.blue ? Colors.red : Colors.blue;
                    });
                  },
                  child: const Text('Change Color'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _borderRadius = _borderRadius == 0 ? 50 : 0;
                    });
                  },
                  child: const Text('Toggle Border Radius'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'AnimatedOpacity',
              'Animate transparency changes',
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _opacity,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Fade Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                    });
                  },
                  child: const Text('Toggle Opacity'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'AnimatedCrossFade',
              'Transition between two widgets',
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 600),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'First Widget',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                secondChild: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Second Widget',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: const Text('Switch Widgets'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    String description,
    Widget animation,
    List<Widget> controls,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        Center(child: animation),
        const SizedBox(height: 16),
        Wrap(spacing: 8, children: controls),
      ],
    );
  }
}

// Custom Animations Page
class CustomAnimationsPage extends StatefulWidget {
  const CustomAnimationsPage({super.key});

  @override
  State<CustomAnimationsPage> createState() => _CustomAnimationsPageState();
}

class _CustomAnimationsPageState extends State<CustomAnimationsPage>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.elasticOut),
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.bounceInOut),
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Animations'),
        backgroundColor: Colors.green.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCustomSection(
              'Rotation Animation',
              'Using AnimationController with rotation',
              AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * 3.14159,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
              [
                ElevatedButton(
                  onPressed: () {
                    if (_rotationController.isCompleted) {
                      _rotationController.reverse();
                    } else {
                      _rotationController.forward();
                    }
                  },
                  child: const Text('Rotate'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _rotationController.repeat();
                  },
                  child: const Text('Spin Forever'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _rotationController.stop();
                    _rotationController.reset();
                  },
                  child: const Text('Stop'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildCustomSection(
              'Scale Animation',
              'Bouncy scale animation with curves',
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  );
                },
              ),
              [
                ElevatedButton(
                  onPressed: () {
                    if (_scaleController.isCompleted) {
                      _scaleController.reverse();
                    } else {
                      _scaleController.forward();
                    }
                  },
                  child: const Text('Scale'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildCustomSection(
              'Slide Animation',
              'Slide transition with SlideTransition',
              ClipRect(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Sliding Widget',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              [
                ElevatedButton(
                  onPressed: () {
                    if (_slideController.isCompleted) {
                      _slideController.reverse();
                    } else {
                      _slideController.forward();
                    }
                  },
                  child: const Text('Slide'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomSection(
    String title,
    String description,
    Widget animation,
    List<Widget> controls,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        Center(child: animation),
        const SizedBox(height: 16),
        Wrap(spacing: 8, children: controls),
      ],
    );
  }
}

// Hero Animations Page
class HeroAnimationsPage extends StatelessWidget {
  const HeroAnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animations'),
        backgroundColor: Colors.orange.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hero Animations',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Hero animations create smooth transitions between screens by "flying" a widget from one page to another.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildHeroCard(context, '1', Colors.blue, 'Blue Hero'),
                _buildHeroCard(context, '2', Colors.red, 'Red Hero'),
                _buildHeroCard(context, '3', Colors.green, 'Green Hero'),
                _buildHeroCard(context, '4', Colors.purple, 'Purple Hero'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(
    BuildContext context,
    String tag,
    Color color,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HeroDetailPage(heroTag: tag, color: color, title: title),
          ),
        );
      },
      child: Hero(
        tag: tag,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  final String heroTag;
  final Color color;
  final String title;

  const HeroDetailPage({
    super.key,
    required this.heroTag,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color.withOpacity(0.2),
      ),
      body: Center(
        child: Hero(
          tag: heroTag,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 80),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap back to see\nthe hero animation',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Page Transitions Page
class PageTransitionsPage extends StatelessWidget {
  const PageTransitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Transitions'),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Custom Page Transitions',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Try different page transition animations:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildTransitionButton(
              context,
              'Slide Transition',
              'Slide from right to left',
              Icons.arrow_forward,
              () => _navigateWithSlide(context),
            ),
            const SizedBox(height: 16),
            _buildTransitionButton(
              context,
              'Fade Transition',
              'Fade in/out animation',
              Icons.opacity,
              () => _navigateWithFade(context),
            ),
            const SizedBox(height: 16),
            _buildTransitionButton(
              context,
              'Scale Transition',
              'Scale up from center',
              Icons.zoom_in,
              () => _navigateWithScale(context),
            ),
            const SizedBox(height: 16),
            _buildTransitionButton(
              context,
              'Rotation Transition',
              'Rotate while scaling',
              Icons.rotate_right,
              () => _navigateWithRotation(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransitionButton(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateWithSlide(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) =>
            const DemoPage(title: 'Slide Transition'),
        transitionsBuilder: (context, animation, _, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateWithFade(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) =>
            const DemoPage(title: 'Fade Transition'),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _navigateWithScale(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) =>
            const DemoPage(title: 'Scale Transition'),
        transitionsBuilder: (context, animation, _, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.bounceOut),
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateWithRotation(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) =>
            const DemoPage(title: 'Rotation Transition'),
        transitionsBuilder: (context, animation, _, child) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: ScaleTransition(scale: animation, child: child),
          );
        },
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  final String title;

  const DemoPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This page was opened with a custom transition animation.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Tips and Tricks Page
class TipsAndTricksPage extends StatelessWidget {
  const TipsAndTricksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips & Tricks'),
        backgroundColor: Colors.amber.shade100,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Flutter Animation Tips & Tricks',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTipCard('🚀 Performance Tips', [
            'Use const constructors when possible',
            'Avoid rebuilding animated widgets unnecessarily',
            'Use AnimatedBuilder for complex animations',
            'Dispose AnimationControllers properly',
            'Use RepaintBoundary for expensive widgets',
          ], Colors.green),
          _buildTipCard('🎨 Animation Best Practices', [
            'Keep animations between 200-500ms for UI feedback',
            'Use easing curves (Curves.easeInOut, Curves.bounceOut)',
            'Provide visual feedback for user interactions',
            'Test animations on different devices',
            'Consider accessibility (reduce motion settings)',
          ], Colors.blue),
          _buildTipCard('⚡ Optimization Techniques', [
            'Use implicit animations when possible (AnimatedContainer)',
            'Cache expensive calculations outside build methods',
            'Use SingleTickerProviderStateMixin for single animations',
            'Prefer Transform over changing widget properties',
            'Use Opacity widget instead of Container with opacity',
          ], Colors.orange),
          _buildTipCard('🔧 Common Mistakes', [
            'Not disposing AnimationControllers (memory leaks)',
            'Creating new Animation objects in build method',
            'Using setState when AnimatedBuilder is better',
            'Animating expensive properties like shadows',
            'Forgetting to add curves to animations',
          ], Colors.red),
          _buildTipCard('📱 Platform Considerations', [
            'iOS users expect bouncy animations (Curves.bounceOut)',
            'Android users prefer linear/ease animations',
            'Consider battery life on lower-end devices',
            'Test on both platforms for consistency',
            'Use Platform.isIOS/isAndroid for platform-specific animations',
          ], Colors.purple),
        ],
      ),
    );
  }

  Widget _buildTipCard(String title, List<String> tips, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 4, height: 24, color: color),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...tips.map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 6, right: 12),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(child: Text(tip)),
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

// Physics Animations Page
class PhysicsAnimationsPage extends StatefulWidget {
  const PhysicsAnimationsPage({super.key});

  @override
  State<PhysicsAnimationsPage> createState() => _PhysicsAnimationsPageState();
}

class _PhysicsAnimationsPageState extends State<PhysicsAnimationsPage>
    with TickerProviderStateMixin {
  late AnimationController _springController;
  late AnimationController _gravityController;
  late Animation<double> _springAnimation;
  late Animation<double> _gravityAnimation;

  @override
  void initState() {
    super.initState();

    _springController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _springAnimation = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(parent: _springController, curve: Curves.elasticOut),
    );

    _gravityController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _gravityAnimation = Tween<double>(begin: 0, end: 300).animate(
      CurvedAnimation(parent: _gravityController, curve: Curves.bounceOut),
    );
  }

  @override
  void dispose() {
    _springController.dispose();
    _gravityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Animations'),
        backgroundColor: Colors.teal.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Physics-Based Animations',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Animations that simulate real-world physics like springs and gravity.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildPhysicsSection(
              'Spring Animation',
              'Elastic bounce effect using Curves.elasticOut',
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: _springAnimation,
                      builder: (context, child) {
                        return Positioned(
                          left: _springAnimation.value,
                          top: 50,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.sports_basketball,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              [
                ElevatedButton(
                  onPressed: () {
                    _springController.reset();
                    _springController.forward();
                  },
                  child: const Text('Spring!'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildPhysicsSection(
              'Gravity Animation',
              'Bouncing ball effect using Curves.bounceOut',
              SizedBox(
                height: 350,
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: _gravityAnimation,
                      builder: (context, child) {
                        return Positioned(
                          left: 100,
                          top: _gravityAnimation.value,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              [
                ElevatedButton(
                  onPressed: () {
                    _gravityController.reset();
                    _gravityController.forward();
                  },
                  child: const Text('Drop!'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhysicsSection(
    String title,
    String description,
    Widget animation,
    List<Widget> controls,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        animation,
        const SizedBox(height: 16),
        Wrap(spacing: 8, children: controls),
      ],
    );
  }
}
