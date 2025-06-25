import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/posts_bloc.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_card.dart';
import 'post_detail_page.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const LoadingWidget(message: 'Loading posts...');
          } else if (state is PostsError) {
            return ErrorDisplayWidget(
              message: state.message,
              onRetry: () {
                context.read<PostsBloc>().add(const GetPostsEvent());
              },
            );
          } else if (state is PostsLoaded) {
            return _buildPostsList(context, state.posts);
          }
          return const Center(child: Text('Tap the button to load posts'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PostsBloc>().add(const GetPostsEvent());
        },
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
                builder: (context) => PostDetailPage(postId: post.id),
              ),
            );
          },
        );
      },
    );
  }
}
