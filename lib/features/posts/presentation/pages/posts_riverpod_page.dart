import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post.dart';
import '../providers/posts_providers.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_card.dart';
import 'post_riverpod_detail_page.dart';

class PostsRiverpodPage extends ConsumerWidget {
  const PostsRiverpodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Посты (Riverpod)'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: postsAsync.when(
        loading: () => const LoadingWidget(message: 'Загрузка постов...'),
        error: (error, stackTrace) => ErrorDisplayWidget(
          message: error.toString(),
          onRetry: () => ref.read(postsNotifierProvider.notifier).refresh(),
        ),
        data: (posts) => _buildPostsList(context, ref, posts),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(postsNotifierProvider.notifier).fetchPosts(),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildPostsList(
    BuildContext context,
    WidgetRef ref,
    List<Post> posts,
  ) {
    if (posts.isEmpty) {
      return const Center(child: Text('Нет доступных постов'));
    }

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
          post: post,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostRiverpodDetailPage(postId: post.id),
              ),
            );
          },
        );
      },
    );
  }
}
