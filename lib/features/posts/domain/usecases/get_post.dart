import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetPost implements UseCase<Post, GetPostParams> {
  final PostsRepository repository;

  GetPost(this.repository);

  @override
  Future<Either<Failure, Post>> call(GetPostParams params) async {
    return await repository.getPost(params.id);
  }
}

class GetPostParams extends Equatable {
  final int id;

  const GetPostParams({required this.id});

  @override
  List<Object> get props => [id];
}
