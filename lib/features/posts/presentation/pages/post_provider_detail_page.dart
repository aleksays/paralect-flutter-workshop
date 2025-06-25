import 'package:flutter/material.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_post.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class PostProviderDetailPage extends StatefulWidget {
  final int postId;

  const PostProviderDetailPage({super.key, required this.postId});

  @override
  State<PostProviderDetailPage> createState() => _PostProviderDetailPageState();
}

class _PostProviderDetailPageState extends State<PostProviderDetailPage> {
  bool _isLoading = true;
  Post? _post;
  String? _errorMessage;
  late final GetPost _getPost;

  @override
  void initState() {
    super.initState();
    _getPost = di.sl<GetPost>();
    _loadPost();
  }

  Future<void> _loadPost() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _getPost(GetPostParams(id: widget.postId));

    if (mounted) {
      result.fold(
        (failure) => setState(() {
          _isLoading = false;
          _errorMessage = failure.message;
          _post = null;
        }),
        (post) => setState(() {
          _isLoading = false;
          _post = post;
          _errorMessage = null;
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post #${widget.postId} (Provider)'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingWidget(message: 'Loading post...');
    }

    if (_errorMessage != null) {
      return ErrorDisplayWidget(message: _errorMessage!, onRetry: _loadPost);
    }

    if (_post == null) {
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
                      CircleAvatar(child: Text(_post!.id.toString())),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Post #${_post!.id}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              'Author: ${_post!.userId}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _post!.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _post!.body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
