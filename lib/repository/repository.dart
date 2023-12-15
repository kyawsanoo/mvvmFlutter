
import '../models/user.dart';
import '../models_2/post.dart';
import '../service/api_service.dart';

class Repository {
  final ApiService  apiService;

  Repository({required this.apiService});

  Future<User?> callGetUserApi(/*Map<dynamic, dynamic> req*/id) async {
    try {
      final response = await apiService.getUser(/*req*/ id: id);
      return response;
    } catch (e) {
      throw Exception('Failed to get user data');
    }
  }

  Future<List<Post>> callPostListApi() async {
    try {
      final response = await apiService.getPostListApiResponse();
      return response;
    } catch (e) {
      throw Exception('Failed to get post list from api');
    }
  }

  Future<Post> callUpdatePostApi(post) async {
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
      Post response = await apiService.updatePostApiResponse(post.id, request);
      return response;
    } catch (e) {
      throw Exception('Failed to call update post api');
    }
  }
}