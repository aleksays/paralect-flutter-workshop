import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/post.dart';
import '../providers/posts_provider.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_card.dart';
import 'post_provider_detail_page.dart';

class PostsProviderPage extends StatelessWidget {
  const PostsProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts (Provider)'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Consumer<PostsProvider>(
        builder: (context, postsProvider, child) {
          switch (postsProvider.status) {
            case PostsStatus.loading:
              return const LoadingWidget(message: 'Loading posts...');
            case PostsStatus.error:
              return ErrorDisplayWidget(
                message: postsProvider.errorMessage,
                onRetry: () => postsProvider.fetchPosts(),
              );
            case PostsStatus.loaded:
              return _buildPostsList(context, postsProvider.posts);
            case PostsStatus.initial:
              return const Center(child: Text('Tap the button to load posts'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PostsProvider>().fetchPosts(),
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildPostsList(BuildContext context, List<Post> posts) {
    if (posts.isEmpty) {
      return const Center(child: Text('No posts available'));
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
                builder: (context) => ChangeNotifierProvider.value(
                  value: context.read<PostsProvider>(),
                  child: PostProviderDetailPage(postId: post.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
