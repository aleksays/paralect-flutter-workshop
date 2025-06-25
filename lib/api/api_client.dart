import 'package:dio/dio.dart';
import '../models/post.dart';

class ApiClient {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  final Dio _dio;

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        ),
      );

  Future<List<Post>> getPosts() async {
    try {
      final response = await _dio.get('/posts');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection');
      } else {
        throw Exception('Failed to load posts: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Post> getPost(int id) async {
    try {
      final response = await _dio.get('/posts/$id');

      if (response.statusCode == 200) {
        return Post.fromJson(response.data);
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load post: ${e.message}');
    }
  }
}
