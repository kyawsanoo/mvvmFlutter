import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models_2/post.dart';
import '../repository/repository.dart';

enum EventLoadingStatus { NotLoaded, Loading, Loaded }

class EditPostScreenViewModel with ChangeNotifier {
  final Repository userRepository;

  EditPostScreenViewModel({required this.userRepository});

  Post? _response;
  Post? get response => _response;

  String? _loginError;
  String? get loginError => _loginError;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isBack = false;
  bool get isBack => _isBack;


  Future<Post> updatePost(Post editedPost) async {
    if(kDebugMode) {
      print('editedPost: ${editedPost.toJson()}');
    }
    Post post = Post();
    _isLoading = true;
    _isBack = false;
    notifyListeners();

    try {
      post = await userRepository.callUpdatePostApi(editedPost);
      _loginError = null;
      if(kDebugMode) {
        print('update post api response: ${post.toJson()}');
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
