import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/posts_providers.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class PostRiverpodDetailPage extends ConsumerStatefulWidget {
  final int postId;

  const PostRiverpodDetailPage({Key? key, required this.postId})
    : super(key: key);

  @override
  ConsumerState<PostRiverpodDetailPage> createState() =>
      _PostRiverpodDetailPageState();
}

class _PostRiverpodDetailPageState
    extends ConsumerState<PostRiverpodDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load post on initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postNotifierProvider.notifier).fetchPost(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final postAsync = ref.watch(postNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Post #${widget.postId} (Riverpod)'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: postAsync.when(
        loading: () => const LoadingWidget(message: 'Loading post...'),
        error: (error, stackTrace) => ErrorDisplayWidget(
          message: error.toString(),
          onRetry: () =>
              ref.read(postNotifierProvider.notifier).fetchPost(widget.postId),
        ),
        data: (post) {
          if (post == null) {
            return const Center(child: Text('Post not found'));
          }

          return SingleChildScrollView(
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Author: ${post.userId}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
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
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clear selected post when closing the page
    ref.read(postNotifierProvider.notifier).clear();
    super.dispose();
  }
}
