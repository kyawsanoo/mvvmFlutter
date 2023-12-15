import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/models_2/post.dart';

import '../repository/repository.dart';

enum EventLoadingStatus { NotLoaded, Loading, Loaded }

class PostListScreenViewModel with ChangeNotifier {
  final Repository userRepository;

  PostListScreenViewModel({required this.userRepository});

  List<Post>? _response;
  List<Post>? get response => _response;

  String? _loginError;
  bool _isLoading = false;

  String? get loginError => _loginError;
  bool get isLoading => _isLoading;


  Future<List<Post>> getPostList() async {
    List<Post> posts = List.empty();
    _isLoading = true;
    //await Future.delayed(const Duration(milliseconds: 100), (){});
    //notifyListeners();

    try {
      posts = await userRepository.callPostListApi();
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


}
