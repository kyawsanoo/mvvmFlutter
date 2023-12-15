import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/repository/repository.dart';
import 'package:flutter_dio/screens/edit_post_screen.dart';
import 'package:flutter_dio/screens/home_screen.dart';
import 'package:flutter_dio/screens/post_list_screen.dart';
import 'package:flutter_dio/service/api_service.dart';
import 'package:flutter_dio/viewmodels/edit_post_screen_viewmodel.dart';
import 'package:flutter_dio/viewmodels/home_screen_viewmodel.dart';
import 'package:flutter_dio/viewmodels/post_list_screen_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  final Dio dio = Dio();
  final ApiService apiService = ApiService(dio: dio);

  final Repository userRepository = Repository(apiService: apiService);
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeScreenViewModel>(
        create: (context) => HomeScreenViewModel(userRepository: userRepository),
      ),

      ChangeNotifierProvider<PostListScreenViewModel>(
        create: (context) => PostListScreenViewModel(userRepository: userRepository),
      ),

      ChangeNotifierProvider<EditPostScreenViewModel>(
        create: (context) => EditPostScreenViewModel(userRepository: userRepository),
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
        '/': (context) => /*HomePage*//*HomeScreen*/PostListScreen(),
        '/edit_screen': (context) => EditPostScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: /*HomePage*//*HomeScreen*/ListScreen(),
    );
  }
}

/*
class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeScreenViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: Center(
        child: FutureBuilder<User?>(
          future: _client.getUser(id: '1'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User? userInfo = snapshot.data;
              if (userInfo != null) {
                Data userData = userInfo.data;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(userData.avatar),
                    const SizedBox(height: 8.0),
                    Text(
                      '${userInfo.data.firstName} ${userInfo.data.lastName}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      userData.email,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}*/
