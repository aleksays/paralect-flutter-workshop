import 'package:flutter/material.dart';

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
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _gravityController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _springAnimation = Tween<double>(begin: 0, end: 140).animate(
      CurvedAnimation(parent: _springController, curve: Curves.elasticOut),
    );

    _gravityAnimation = Tween<double>(begin: 0, end: 230).animate(
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
        backgroundColor: Colors.indigo.shade100,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Physics-Based Animations',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Animations that simulate real-world physics:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Spring Animation',
            'Elastic spring physics simulation',
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _springAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: _springAnimation.value,
                        left: 50,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 30,
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
                  if (_springController.isCompleted) {
                    _springController.reverse();
                  } else {
                    _springController.forward();
                  }
                },
                child: const Text('Spring'),
              ),
              ElevatedButton(
                onPressed: () {
                  _springController.reset();
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Gravity Animation',
            'Bouncing ball with gravity effect',
            SizedBox(
              height: 280,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _gravityAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: _gravityAnimation.value,
                        left: 50,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
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
                  if (_gravityController.isCompleted) {
                    _gravityController.reverse();
                  } else {
                    _gravityController.forward();
                  }
                },
                child: const Text('Drop Ball'),
              ),
              ElevatedButton(
                onPressed: () {
                  _gravityController.reset();
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildInfoCard(),
          const SizedBox(height: 20),
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

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Colors.blue.shade600, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Physics Animation Tips',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '• Use SpringSimulation for natural spring effects\n'
              '• GravitySimulation creates realistic falling motion\n'
              '• Combine with gesture detection for interactive physics\n'
              '• Consider performance on lower-end devices\n'
              '• Test with different animation durations',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
