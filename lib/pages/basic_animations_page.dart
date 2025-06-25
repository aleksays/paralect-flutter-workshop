import 'package:flutter/material.dart';

class BasicAnimationsPage extends StatefulWidget {
  const BasicAnimationsPage({super.key});

  @override
  State<BasicAnimationsPage> createState() => _BasicAnimationsPageState();
}

class _BasicAnimationsPageState extends State<BasicAnimationsPage> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;
  double _borderRadius = 0;
  double _opacity = 1.0;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Animations'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Implicit Animations',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'These animations automatically animate changes to their properties:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'AnimatedContainer',
            'Animate size, color, and border radius changes',
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
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
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Fade Me',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
                    _opacity = _opacity == 1.0 ? 0.3 : 1.0;
                  });
                },
                child: const Text('Toggle Opacity'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSection(
            'AnimatedCrossFade',
            'Smoothly transition between two widgets',
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.purple,
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
                  color: Colors.orange,
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
