import '../models/post.dart';
import '../service/api_service.dart';

class PostRepository {
  final ApiService  apiService;

  PostRepository({required this.apiService});

  Future<List<Post>> getPosts() async {
    try {
      final response = await apiService.callGetPostListApi();
      return response;
    } catch (e) {
      throw Exception('Failed to get post list from api');
    }
  }

  Future<Post> createPost(post) async {
    try {
      /*id: 1,
        title: 'foo',
        body: 'bar',
        userId: 1,*/
      Map<String, dynamic> request = <String, dynamic>{
        'id': post.id,
        'title': post.title,
        'body':post.body,
        'serId': post.userId

      };
      Post response = await apiService.callCreatePostApi(request);
      return response;
    } catch (e) {
      throw Exception('Failed to call update post api');
    }
  }


  Future<Post> updatePost(post) async {
    try {
      /*id: 1,
        title: 'foo',
        body: 'bar',
        userId: 1,*/
      Map<String, dynamic> request = <String, dynamic>{
        'id': post.id,
        'title': post.title,
        'body':post.body,
        'serId': post.userId

      };
      Post response = await apiService.callUpdatePostApi(post.id, request);
      return response;
    } catch (e) {
      throw Exception('Failed to call update post api');
    }
  }


  Future<Post> deletePost(id) async {
    try {
      Post response = await apiService.callDeletePostApi(id);
      return response;
    } catch (e) {
      throw Exception('Failed to call delete post api');
    }
  }
}