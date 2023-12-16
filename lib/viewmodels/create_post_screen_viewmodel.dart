import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../repository/post_repository.dart';

enum EventLoadingStatus { NotLoaded, Loading, Loaded }

class CreatePostScreenViewModel with ChangeNotifier {
  final PostRepository postRepository;

  CreatePostScreenViewModel({required this.postRepository});

  Post? _response;
  Post? get response => _response;

  String? _loginError;
  String? get loginError => _loginError;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isBack = false;
  bool get isBack => _isBack;


  Future<Post> createPost(Post createPost) async {
    if(kDebugMode) {
      print('createPost: ${createPost.toJson()}');
    }
    Post post = Post();
    _isLoading = true;
    _isBack = false;
    notifyListeners();

    try {
      post = await postRepository.createPost(createPost);
      _loginError = null;
      if(kDebugMode) {
        print('create post api response: ${post.toJson()}');
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
