import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_post.dart';
import '../../domain/usecases/get_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts getPosts;
  final GetPost getPost;

  PostsBloc({required this.getPosts, required this.getPost})
    : super(PostsInitial()) {
    on<GetPostsEvent>(_onGetPosts);
    on<GetPostEvent>(_onGetPost);
  }

  Future<void> _onGetPosts(
    GetPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());

    final result = await getPosts(const NoParams());

    result.fold(
      (failure) => emit(PostsError(failure.message)),
      (posts) => emit(PostsLoaded(posts)),
    );
  }

  Future<void> _onGetPost(GetPostEvent event, Emitter<PostsState> emit) async {
    emit(PostLoading());

    final result = await getPost(GetPostParams(id: event.id));

    result.fold(
      (failure) => emit(PostError(failure.message)),
      (post) => emit(PostLoaded(post)),
    );
  }
}
