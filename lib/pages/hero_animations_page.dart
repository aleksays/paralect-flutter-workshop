import 'package:flutter/material.dart';

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
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
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
      ),
    );
  }
}

class HeroDetailPage extends StatefulWidget {
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
  State<HeroDetailPage> createState() => _HeroDetailPageState();
}

class _HeroDetailPageState extends State<HeroDetailPage>
    with SingleTickerProviderStateMixin {
  bool _showExtraContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showExtraContent = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color.withValues(alpha: 0.2),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Hero(
              tag: widget.heroTag,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _showExtraContent ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 80),
                  const SizedBox(height: 80),
                  const Text(
                    'Tap back to see\nthe hero animation',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
