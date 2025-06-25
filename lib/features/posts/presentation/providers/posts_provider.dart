import 'package:flutter/material.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_post.dart';
import '../../domain/usecases/get_posts.dart';

enum PostsStatus { initial, loading, loaded, error }

class PostsProvider extends ChangeNotifier {
  final GetPosts _getPosts;
  final GetPost _getPost;

  PostsProvider({required GetPosts getPosts, required GetPost getPost})
    : _getPosts = getPosts,
      _getPost = getPost;

  PostsStatus _status = PostsStatus.initial;
  List<Post> _posts = [];
  Post? _selectedPost;
  String _errorMessage = '';

  PostsStatus get status => _status;
  List<Post> get posts => _posts;
  Post? get selectedPost => _selectedPost;
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

  Future<void> fetchPost(int id) async {
    _status = PostsStatus.loading;
    notifyListeners();

    final result = await _getPost(GetPostParams(id: id));

    result.fold(
      (failure) {
        _status = PostsStatus.error;
        _errorMessage = failure.message;
        _selectedPost = null;
      },
      (post) {
        _status = PostsStatus.loaded;
        _selectedPost = post;
        _errorMessage = '';
      },
    );

    notifyListeners();
  }

  void clearSelectedPost() {
    _selectedPost = null;
    notifyListeners();
  }
}
