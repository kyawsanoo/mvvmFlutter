import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/data.dart';
import '../models/user.dart';
import '../viewmodels/home_screen_viewmodel.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userInfo;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: Center(
        child:
        FutureBuilder<User?>(
          future: viewModel.getUser(id: '1'),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              if(kDebugMode) {
                print('User Info: ${snapshot.error}');
              }
            }
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

        /*Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(userInfo!=null) Image.network(userInfo!.data.avatar),
            const SizedBox(height: 8.0),
            Text(
              '${userInfo?.data.firstName} ${userInfo?.data.lastName}',
              style: const TextStyle(fontSize: 16.0),
            ),
            if(userInfo!=null)
              Text(
                userInfo!.data.email,
                style: const TextStyle(fontSize: 16.0),
              )

          ],
        )
*/      ),
    );
  }

  @override
  void initState() {
    super.initState();
    /*Future.delayed(Duration.zero, () async {
      final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
      userInfo = await viewModel.getUser(id: '1');
    }
    );*/
  }
}