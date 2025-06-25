import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_post.dart';
import '../../domain/usecases/get_posts.dart';

// Use Cases Providers
final getPostsProvider = Provider<GetPosts>((ref) => di.sl<GetPosts>());
final getPostProvider = Provider<GetPost>((ref) => di.sl<GetPost>());

// Posts List Provider
final postsProvider = FutureProvider<List<Post>>((ref) async {
  final getPosts = ref.watch(getPostsProvider);
  final result = await getPosts(const NoParams());

  return result.fold(
    (failure) => throw Exception(failure.message),
    (posts) => posts,
  );
});

// Single Post Provider
final postProvider = FutureProvider.family<Post, int>((ref, id) async {
  final getPost = ref.watch(getPostProvider);
  final result = await getPost(GetPostParams(id: id));

  return result.fold(
    (failure) => throw Exception(failure.message),
    (post) => post,
  );
});

// Posts State Notifier for more complex state management
class PostsNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  final GetPosts _getPosts;

  PostsNotifier(this._getPosts) : super(const AsyncValue.loading());

  Future<void> fetchPosts() async {
    state = const AsyncValue.loading();

    final result = await _getPosts(const NoParams());

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (posts) => state = AsyncValue.data(posts),
    );
  }

  void refresh() {
    fetchPosts();
  }
}

final postsNotifierProvider =
    StateNotifierProvider<PostsNotifier, AsyncValue<List<Post>>>((ref) {
      final getPosts = ref.watch(getPostsProvider);
      return PostsNotifier(getPosts);
    });

// Single Post State Notifier
class PostNotifier extends StateNotifier<AsyncValue<Post?>> {
  final GetPost _getPost;

  PostNotifier(this._getPost) : super(const AsyncValue.data(null));

  Future<void> fetchPost(int id) async {
    state = const AsyncValue.loading();

    final result = await _getPost(GetPostParams(id: id));

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (post) => state = AsyncValue.data(post),
    );
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}

final postNotifierProvider =
    StateNotifierProvider<PostNotifier, AsyncValue<Post?>>((ref) {
      final getPost = ref.watch(getPostProvider);
      return PostNotifier(getPost);
    });
