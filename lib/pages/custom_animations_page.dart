import 'package:flutter/material.dart';

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

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.bounceOut),
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Explicit Animations',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'These animations use AnimationController for precise control:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Rotation Animation',
            'Rotate a widget with custom timing',
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
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
                      size: 50,
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
                child: const Text('Repeat'),
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
          _buildSection(
            'Scale Animation',
            'Scale with elastic effect',
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
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
          _buildSection(
            'Slide Animation',
            'Slide in with bounce effect',
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: 200,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.purple,
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
