// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import '../models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPost(int id);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final Dio dio;

  PostsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      print('🚀 Fetching posts from API...');
      final response = await dio.get('/posts');
      print('✅ Posts fetched successfully: ${response.statusCode}');

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } on DioException catch (e) {
      print('❌ DioException: ${e.type}');
      print(
        'Response: ${e.response?.statusCode} - ${e.response?.statusMessage}',
      );
      print('Data: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('❌ General Exception: $e');
      throw Exception('Failed to fetch posts: $e');
    }
  }

  @override
  Future<PostModel> getPost(int id) async {
    try {
      print('🚀 Fetching post $id from API...');
      final response = await dio.get('/posts/$id');
      print('✅ Post $id fetched successfully: ${response.statusCode}');

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return PostModel.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ DioException: ${e.type}');
      print(
        'Response: ${e.response?.statusCode} - ${e.response?.statusMessage}',
      );
      print('Data: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('❌ General Exception: $e');
      throw Exception('Failed to fetch post: $e');
    }
  }
}
