import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/models/post.dart';

import '../repository/post_repository.dart';

enum EventLoadingStatus { NotLoaded, Loading, Loaded }

class PostListScreenViewModel with ChangeNotifier {
  final PostRepository postRepository;

  PostListScreenViewModel({required this.postRepository});

  List<Post>? _response;
  List<Post>? get response => _response;

  String? _loginError;
  bool _isLoading = false;

  String? get loginError => _loginError;
  bool get isLoading => _isLoading;

  bool _isBack = false;
  bool get isBack => _isBack;

  Future<List<Post>> getPostList() async {
    List<Post> posts = List.empty();
    _isLoading = true;
    //await Future.delayed(const Duration(milliseconds: 100), (){});
    //notifyListeners();

    try {
      posts = await postRepository.getPosts();
      _loginError = null;
      if(kDebugMode) {
        print('first data: ${posts.first.toJson()}');
      }
    } catch (e) {
      _loginError = e.toString();
    }

    _isLoading = false;
    //notifyListeners();
    return posts;
  }

  Future<Post> deletePost(id) async {
    if(kDebugMode) {
      print('deletePost id: $id');
    }
    Post post = Post();
    _isLoading = true;
    _isBack = false;
    notifyListeners();

    try {
      post = await postRepository.deletePost(id);
      _loginError = null;
      if(kDebugMode) {
        print('delete post api response: ${post.toJson()}');
      }
    } catch (e) {
      _loginError = e.toString();
    }

    _isLoading = false;
    _isBack = true;
    notifyListeners();
    return post;
  }


}
