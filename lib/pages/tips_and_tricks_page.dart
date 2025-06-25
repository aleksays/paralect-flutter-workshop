import 'package:flutter/material.dart';

class TipsAndTricksPage extends StatelessWidget {
  const TipsAndTricksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips & Tricks'),
        backgroundColor: Colors.teal.shade100,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Animation Tips & Tricks',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Best practices for smooth and performant animations:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          _buildTipCard(
            'Performance Optimization',
            [
              'Use RepaintBoundary to isolate animated widgets',
              'Prefer Transform widgets over changing layout properties',
              'Use const constructors for child widgets',
              'Dispose AnimationControllers properly',
              'Consider using AnimatedBuilder for complex animations',
            ],
            Icons.speed,
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildTipCard(
            'Animation Curves',
            [
              'Curves.easeInOut - Natural feeling animations',
              'Curves.elasticOut - Bouncy spring effect',
              'Curves.fastOutSlowIn - Material Design standard',
              'Curves.bounceOut - Ball bouncing effect',
              'Create custom curves for unique animations',
            ],
            Icons.timeline,
            Colors.green,
          ),
          const SizedBox(height: 16),
          _buildTipCard(
            'Common Mistakes',
            [
              'Don\'t animate layout properties unnecessarily',
              'Avoid animating expensive operations',
              'Don\'t forget to dispose controllers',
              'Use SingleTickerProviderStateMixin when possible',
              'Test animations on different devices',
            ],
            Icons.warning,
            Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildTipCard(
            'Accessibility',
            [
              'Respect user\'s motion preferences',
              'Provide alternative feedback for animations',
              'Use semantics labels for animated content',
              'Consider users with vestibular disorders',
              'Test with screen readers',
            ],
            Icons.accessibility,
            Colors.purple,
          ),
          const SizedBox(height: 16),
          _buildTipCard(
            'Platform Considerations',
            [
              'iOS prefers subtle, refined animations',
              'Android follows Material Design principles',
              'Web animations should be lightweight',
              'Consider battery usage on mobile',
              'Test on different screen sizes',
            ],
            Icons.devices,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(
    String title,
    List<String> tips,
    IconData icon,
    Color color,
  ) {
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
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                    Expanded(
                      child: Text(tip, style: const TextStyle(fontSize: 16)),
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
