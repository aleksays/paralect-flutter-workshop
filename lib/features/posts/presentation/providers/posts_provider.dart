import 'package:flutter/material.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_post.dart';
import '../../domain/usecases/get_posts.dart';

enum PostsStatus { initial, loading, loaded, error }

class PostsProvider extends ChangeNotifier {
  final GetPosts _getPosts;

  PostsProvider({required GetPosts getPosts, required GetPost getPost})
    : _getPosts = getPosts;

  PostsStatus _status = PostsStatus.initial;
  List<Post> _posts = [];
  String _errorMessage = '';

  PostsStatus get status => _status;
  List<Post> get posts => _posts;
  String get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    _status = PostsStatus.loading;
    notifyListeners();

    final result = await _getPosts(const NoParams());

    result.fold(
      (failure) {
        _status = PostsStatus.error;
        _errorMessage = failure.message;
        _posts = [];
      },
      (posts) {
        _status = PostsStatus.loaded;
        _posts = posts;
        _errorMessage = '';
      },
    );

    notifyListeners();
  }
}
