import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/posts/data/datasources/posts_remote_data_source.dart';
import '../../features/posts/data/repositories/posts_repository_impl.dart';
import '../../features/posts/domain/repositories/posts_repository.dart';
import '../../features/posts/domain/usecases/get_post.dart';
import '../../features/posts/domain/usecases/get_posts.dart';
import '../../features/posts/presentation/bloc/posts_bloc.dart';
import '../../features/posts/presentation/providers/posts_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Posts
  // Bloc
  sl.registerFactory(() => PostsBloc(getPosts: sl(), getPost: sl()));

  // Provider
  sl.registerFactory(() => PostsProvider(getPosts: sl(), getPost: sl()));

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
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'Flutter-Workshop-App/1.0.0',
      },
    ),
  );

  // Add logging interceptor for debugging
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      // ignore: avoid_print
      logPrint: (obj) => print('🌐 HTTP: $obj'),
    ),
  );

  sl.registerLazySingleton(() => dio);
}
