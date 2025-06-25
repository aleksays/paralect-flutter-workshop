import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/posts/data/datasources/posts_remote_data_source.dart';
import '../../features/posts/data/repositories/posts_repository_impl.dart';
import '../../features/posts/domain/repositories/posts_repository.dart';
import '../../features/posts/domain/usecases/get_post.dart';
import '../../features/posts/domain/usecases/get_posts.dart';
import '../../features/posts/presentation/bloc/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Posts
  // Bloc
  sl.registerFactory(() => PostsBloc(getPosts: sl(), getPost: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => GetPost(sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(dio: sl()),
  );

  // External
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    ),
  );
}
