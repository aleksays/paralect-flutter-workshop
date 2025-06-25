import 'package:flutter/material.dart';

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
              CurvedAnimation(parent: animation, curve: Curves.elasticOut),
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
              CurvedAnimation(parent: animation, curve: Curves.elasticOut),
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
      appBar: AppBar(title: Text(title), backgroundColor: Colors.teal.shade100),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green.shade400),
            const SizedBox(height: 32),
            Text(
              'Transition Complete!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'You experienced a $title',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
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
