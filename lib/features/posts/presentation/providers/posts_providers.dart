import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_post.dart';
import '../../domain/usecases/get_posts.dart';

part 'posts_providers.g.dart';

// Use case providers
@riverpod
GetPosts getPosts(Ref ref) {
  return di.sl<GetPosts>();
}

@riverpod
GetPost getPost(Ref ref) {
  return di.sl<GetPost>();
}

// Simple FutureProvider for posts list
@riverpod
Future<List<Post>> posts(Ref ref) async {
  final getPosts = ref.watch(getPostsProvider);
  final result = await getPosts(const NoParams());

  return result.fold(
    (failure) => throw Exception(failure.message),
    (posts) => posts,
  );
}

// Family provider for individual post by ID
@riverpod
Future<Post> post(Ref ref, int id) async {
  final getPost = ref.watch(getPostProvider);
  final result = await getPost(GetPostParams(id: id));

  return result.fold(
    (failure) => throw Exception(failure.message),
    (post) => post,
  );
}

// Advanced StateNotifier for complex state management
@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  Future<List<Post>> build() async {
    // Initial load
    return _fetchPosts();
  }

  Future<List<Post>> _fetchPosts() async {
    final getPosts = ref.watch(getPostsProvider);
    final result = await getPosts(const NoParams());

    return result.fold(
      (failure) => throw Exception(failure.message),
      (posts) => posts,
    );
  }

  Future<void> refresh() async {
    // Set loading state
    state = const AsyncLoading();

    // Refetch data
    state = await AsyncValue.guard(() => _fetchPosts());
  }

  Future<void> addPost(Post post) async {
    final currentPosts = await future;
    state = AsyncData([...currentPosts, post]);
  }

  Future<void> removePost(int postId) async {
    final currentPosts = await future;
    state = AsyncData(currentPosts.where((post) => post.id != postId).toList());
  }
}
