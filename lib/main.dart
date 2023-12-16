import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/repository/post_repository.dart';
import 'package:flutter_dio/screens/create_post_screen.dart';
import 'package:flutter_dio/screens/edit_post_screen.dart';
import 'package:flutter_dio/screens/post_list_screen.dart';
import 'package:flutter_dio/service/api_service.dart';
import 'package:flutter_dio/viewmodels/create_post_screen_viewmodel.dart';
import 'package:flutter_dio/viewmodels/edit_post_screen_viewmodel.dart';
import 'package:flutter_dio/viewmodels/post_list_screen_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  final Dio dio = Dio();
  final ApiService apiService = ApiService(dio: dio);

  final PostRepository postRepository = PostRepository(apiService: apiService);
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider<PostListScreenViewModel>(
        create: (context) => PostListScreenViewModel(postRepository: postRepository),
      ),

      ChangeNotifierProvider<CreatePostScreenViewModel>(
        create: (context) => CreatePostScreenViewModel(postRepository: postRepository),
      ),

      ChangeNotifierProvider<EditPostScreenViewModel>(
        create: (context) => EditPostScreenViewModel(postRepository: postRepository),
      ),
    ],
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const PostListScreen(),
        '/edit_post_screen': (context) => const EditPostScreen(),
        '/create_post_screen': (context) => const CreatePostScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
