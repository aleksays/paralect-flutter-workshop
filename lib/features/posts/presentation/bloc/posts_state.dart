part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object> get props => [message];
}

class PostLoading extends PostsState {}

class PostLoaded extends PostsState {
  final Post post;

  const PostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

class PostError extends PostsState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}
