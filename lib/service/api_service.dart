import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../models_2/post.dart';

class ApiService {
  late Dio _dio;
  final _baseUrl = 'https://reqres.in/api' ;
  final _basePostUrl = "https://jsonplaceholder.typicode.com";
  ApiService({required Dio dio}) {
    _dio = dio;
    _dio.options = BaseOptions(
      //baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds:5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
    );

  }



  Future<User?> getUser({/*required Map<dynamic, dynamic> req*/ required String id}) async {
    User? user;
    try {
      Response userData = await _dio.get(_baseUrl + '/users/$id');
      if(kDebugMode) {
        print('User Info: ${userData.data}');
      }
      user = User.fromJson(userData.data);
    } on DioException catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error!');
          print('STATUS: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        }

      } else {
        // Error due to setting up or sending the request
        if(kDebugMode) {
          print('Error sending request!');
          print(e.message);
        }
      }
    }
    return user;
  }

  Future<List<Post>> getPostListApiResponse() async {

    try {
      final response = await _dio.get('$_basePostUrl/posts');
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


  Future<Post> updatePostApiResponse(id, Map<String, dynamic> req) async {
    Post? updatePostApiResponse;
    try {
      Response response = await _dio.put('$_basePostUrl/posts/$id', queryParameters: req);
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
}

