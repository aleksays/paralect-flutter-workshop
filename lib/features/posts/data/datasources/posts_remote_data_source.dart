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
      final response = await dio.get('/posts');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  @override
  Future<PostModel> getPost(int id) async {
    try {
      final response = await dio.get('/posts/$id');
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch post: $e');
    }
  }
}
