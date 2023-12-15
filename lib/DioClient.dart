import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'models/user.dart';

//for direct network calls
class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://reqres.in/api';

  Future<User?> getUser({required String id}) async {
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

}