import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/screens/create_post_screen.dart';
import 'package:flutter_dio/viewmodels/post_list_screen_viewmodel.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import 'edit_post_screen.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late List<Post> posts;
  late PostListScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('initState');
    }
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<PostListScreenViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ),
      body: Center(
          child: FutureBuilder<List<Post>?>(
        future: viewModel.getPostList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                print('snapshot error: ${snapshot.error}');
              }
            }
          }
          if (snapshot.hasData) {
            posts = snapshot.data!;
            if (posts.isEmpty) {
              if (kDebugMode) {
                print('posts is empty');
              }
            }
            return viewModel.isLoading
                ? const Center(
                    child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ))
                : Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: posts.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      child: Column(
                                    children: [
                                      ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${posts[index].title}",
                                              textDirection: TextDirection.ltr,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                "${posts[index].body}"),

                                          ],
                                        ),
                                        onTap: () {},
                                      ),
                                      ListTile(
                                          title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ButtonTheme(
                                              minWidth: 100.0,
                                              height: 50.0,
                                              child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  side: const BorderSide(
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if (kDebugMode) {
                                                    print(
                                                        "Argument Post: ${posts[index].toJson()}");
                                                  }
                                                  await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const EditPostScreen(),
                                                            settings:
                                                                RouteSettings(
                                                              arguments:
                                                                  posts[index],
                                                            ),
                                                          ))
                                                      .then(
                                                          (isCompleteUpdated) {
                                                    if (kDebugMode) {
                                                      print(
                                                          'isCompleteUpdated: $isCompleteUpdated');
                                                    }
                                                    if (isCompleteUpdated !=
                                                            null &&
                                                        isCompleteUpdated) {
                                                      _pullRefresh();
                                                    }
                                                  });
                                                },
                                                child: const Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ButtonTheme(
                                              minWidth: 100.0,
                                              //height: 50.0,
                                              child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  side: const BorderSide(
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _dialogBuilder(
                                                      context, posts[index]);
                                                },
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ))
                                    ],
                                  ));
                                },
                              )
                            : const Center(
                                child: Text(
                                    "Todo list is empty and create new"))));
          } else {
            if (kDebugMode) {
              print('snapshot has no data');
            }
          }
          return const CircularProgressIndicator();
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
                  await  Navigator.push(context, MaterialPageRoute(
            builder: (context) => const CreatePostScreen(),

          )
          ).then((isCreated){
            if (kDebugMode) {
              print('isCreated: $isCreated');
            }
            if(isCreated != null && isCreated){
              //refresh the page
              _pullRefresh();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  Future<void> _dialogBuilder(BuildContext context, Post post) {

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return
          ScaffoldMessenger(child: Builder(builder: (context){
            return Scaffold(
                backgroundColor: Colors.transparent,
                body: AlertDialog(
                  title: const Text('Confirm to delete'),
                  content: const Text(
                      'Are you sure to delete this post?'

                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Consumer<PostListScreenViewModel>(builder: (context, postListScreenViewModel, child) {
                    return
                      postListScreenViewModel.isLoading ?
                        const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(),)

                            :
                        TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelLarge,
                            ),
                            child: const Text('Ok'),
                            onPressed: () async {
                              Post deletedPost = await viewModel.deletePost(post.id);
                              if (viewModel.isBack){
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Deleted successfully."),
                                    )
                                );
                                await Future.delayed(const Duration(seconds: 1)).then((value) =>
                                    Navigator.of(context).pop()
                                );
                              }

                            }
                        );
                    })

                  ],
                ));

          }));
      },
    );
  }
}
