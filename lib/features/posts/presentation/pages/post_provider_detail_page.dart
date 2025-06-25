import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posts_provider.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class PostProviderDetailPage extends StatefulWidget {
  final int postId;

  const PostProviderDetailPage({super.key, required this.postId});

  @override
  State<PostProviderDetailPage> createState() => _PostProviderDetailPageState();
}

class _PostProviderDetailPageState extends State<PostProviderDetailPage> {
  bool _hasLoaded = false;
  PostsProvider? _postsProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Сохраняем ссылку на Provider для безопасного использования в dispose
    _postsProvider = context.read<PostsProvider>();

    // Безопасно загружаем пост после того, как дерево виджетов стабилизировалось
    if (!_hasLoaded) {
      _hasLoaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _postsProvider != null) {
          _postsProvider!.fetchPost(widget.postId);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Пост #${widget.postId} (Provider)'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Consumer<PostsProvider>(
        builder: (context, postsProvider, child) {
          switch (postsProvider.status) {
            case PostsStatus.loading:
              return const LoadingWidget(message: 'Загрузка поста...');
            case PostsStatus.error:
              return ErrorDisplayWidget(
                message: postsProvider.errorMessage,
                onRetry: () {
                  if (mounted) {
                    postsProvider.fetchPost(widget.postId);
                  }
                },
              );
            case PostsStatus.loaded:
              final post = postsProvider.selectedPost;
              if (post == null) {
                return const Center(child: Text('Пост не найден'));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Пост #${post.id}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
                                      ),
                                      Text(
                                        'Автор: ${post.userId}',
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
            case PostsStatus.initial:
              return const Center(child: Text('Загружается...'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // Безопасно очищаем выбранный пост используя сохраненную ссылку
    if (_postsProvider != null) {
      _postsProvider!.clearSelectedPost();
    }
    super.dispose();
  }
}
