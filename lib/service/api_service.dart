import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/post.dart';

class ApiService {
  late Dio _dio;
  final _baseUrl = 'https://jsonplaceholder.typicode.com' ;
  ApiService({required Dio dio}) {
    _dio = dio;
    _dio.options = BaseOptions(
      //baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds:5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
    );

  }

  Future<List<Post>> callGetPostListApi() async {

    try {
      final response = await _dio.get('$_baseUrl/posts');
      if (response.statusCode == 200) {
        if(kDebugMode) {
          print('get posts responseBody: ${response.data}');
        }
        List<Post> posts = [];
        // Access the values in the parsed JSON
        /*for (var post in response.data) {
          if (kDebugMode) {
            print('id: ${post['id']}');
            print('title ${post['title']}');
            print('body: ${post['body']}');
            print('userId: ${post['userId']}');
          }
          posts.add(Post(id:post['id'], title: post['title'], body: post['body'], userId: post['userId']));
        }
        return posts;
        */
        return (response.data as List)
            .map((json) => Post.fromJson(json))
            .toList();

      } else {
        if (kDebugMode) {
          print('Error Occurred');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Occurred $e');
      }
    }
    return List.empty();
  }

  Future<Post> callCreatePostApi(Map<String, dynamic> req) async {
    Post? createPostApiResponse;
    try {
      Response response = await _dio.post('$_baseUrl/posts', queryParameters: req);
      if (response.statusCode == 200) {
        if(kDebugMode) {
          print('create post responseBody: ${response.data}');
        }
        createPostApiResponse = Post.fromJson(response.data);
        if(kDebugMode) {
          print('create post response: ${createPostApiResponse.toJson()}');
        }
        return createPostApiResponse;
      } else {
        if (kDebugMode) {
          print('Error Occurred');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Occurred $e');
      }
    }
    return Post();
  }

  Future<Post> callUpdatePostApi(id, Map<String, dynamic> req) async {
    Post? updatePostApiResponse;
    try {
      Response response = await _dio.put('$_baseUrl/posts/$id', queryParameters: req);
      if (response.statusCode == 200) {
        if(kDebugMode) {
          print('update post responseBody: ${response.data}');
        }
        updatePostApiResponse = Post.fromJson(response.data);
        if(kDebugMode) {
          print('updatepostApiResponse: ${updatePostApiResponse.toJson()}');
        }
        return updatePostApiResponse;
      } else {
        if (kDebugMode) {
          print('Error Occurred');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Occurred $e');
      }
    }
    return Post();
  }


  Future<Post> callDeletePostApi(id) async {
    Post? deletePostApiResponse;
    try {
      Response response = await _dio.delete('$_baseUrl/posts/$id');
      if (response.statusCode == 200) {
        if(kDebugMode) {
          print('delete post responseBody: ${response.data}');
        }
        deletePostApiResponse = Post.fromJson(response.data);
        if(kDebugMode) {
          print('delete post ApiResponse: ${deletePostApiResponse.toJson()}');
        }
        return deletePostApiResponse;
      } else {
        if (kDebugMode) {
          print('Error Occurred');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Occurred $e');
      }
    }
    return Post();
  }
}

