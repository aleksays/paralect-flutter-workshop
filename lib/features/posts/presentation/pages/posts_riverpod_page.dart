import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post.dart';
import '../providers/posts_providers.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_card.dart';
import 'post_riverpod_detail_page.dart';

class PostsRiverpodPage extends ConsumerWidget {
  const PostsRiverpodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts (Riverpod Annotations)'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Invalidate provider to refetch data
              ref.invalidate(postsProvider);
            },
          ),
        ],
      ),
      body: _buildBody(ref),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Using StateNotifier for more complex operations
          ref.read(postsNotifierProvider.notifier).refresh();
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.autorenew),
      ),
    );
  }

  Widget _buildBody(WidgetRef ref) {
    // Using simple FutureProvider
    final postsAsync = ref.watch(postsProvider);

    return postsAsync.when(
      loading: () => const LoadingWidget(message: 'Loading posts...'),
      error: (error, stackTrace) => ErrorDisplayWidget(
        message: error.toString(),
        onRetry: () {
          ref.invalidate(postsProvider);
        },
      ),
      data: (posts) => _buildPostsList(ref, posts),
    );
  }

  Widget _buildPostsList(WidgetRef ref, List<Post> posts) {
    if (posts.isEmpty) {
      return const Center(child: Text('No posts available'));
    }

    return Column(
      children: [
        // Demo section showing StateNotifier usage
        Container(
          color: Colors.purple.shade50,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text('StateNotifier Demo: '),
              TextButton(
                onPressed: () {
                  ref.read(postsNotifierProvider.notifier).refresh();
                },
                child: const Text('Refresh with StateNotifier'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(
                post: post,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PostRiverpodDetailPage(postId: post.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
