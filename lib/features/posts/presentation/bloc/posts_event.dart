part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostsEvent {
  const GetPostsEvent();
}

class GetPostEvent extends PostsEvent {
  final int id;

  const GetPostEvent(this.id);

  @override
  List<Object> get props => [id];
}
