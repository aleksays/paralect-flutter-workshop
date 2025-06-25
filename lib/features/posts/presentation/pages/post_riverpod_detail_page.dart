import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/posts_providers.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class PostRiverpodDetailPage extends ConsumerWidget {
  final int postId;

  const PostRiverpodDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using family provider with annotations
    final postAsync = ref.watch(postProvider(postId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Post #$postId (Riverpod Annotations)'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Invalidate specific family provider instance
              ref.invalidate(postProvider(postId));
            },
          ),
        ],
      ),
      body: postAsync.when(
        loading: () => const LoadingWidget(message: 'Loading post...'),
        error: (error, stackTrace) => ErrorDisplayWidget(
          message: error.toString(),
          onRetry: () {
            ref.invalidate(postProvider(postId));
          },
        ),
        data: (post) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(child: Text(post.id.toString())),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Post #${post.id}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  'Author: ${post.userId}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        post.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        post.body,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Demo section showing different refresh methods
              Card(
                color: Colors.purple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Riverpod Annotations Demo:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• This post is loaded using @riverpod annotation',
                      ),
                      const Text(
                        '• Family provider automatically handles parameters',
                      ),
                      const Text('• Type-safe generated providers'),
                      const Text('• Auto-completion and compile-time checks'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(postProvider(postId));
                            },
                            child: const Text('Refresh This Post'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(postsProvider);
                            },
                            child: const Text('Refresh Posts List'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
