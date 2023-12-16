import 'package:flutter/material.dart';
import 'package:flutter_dio/viewmodels/create_post_screen_viewmodel.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';




class CreatePostScreen extends StatefulWidget {

  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();

}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title= "", _body = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      var viewModel = Provider.of<CreatePostScreenViewModel>(context);
      return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post', style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 30),
              child:
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'post title',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        if (text.length < 4) {
                          return 'Too short';
                        }
                        return null;
                      },
                      onChanged: (text) => setState(() => _title = text),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'post body',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        if (text.length < 4) {
                          return 'Too short';
                        }
                        return null;
                      },
                      onChanged: (text) => setState(() => _body = text),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(width: 200,
                      child:  viewModel.isLoading?
                                     Center(
                                            child: Container(
                                            child: const CircularProgressIndicator(),
                                            ),
                                    )
                                    :
                                      ElevatedButton(
                                        onPressed: _title.isNotEmpty && _body.isNotEmpty? (){
                                          _submit(viewModel);}
                                            : null,
                                        child: Text(
                                          'Create',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      )



                        )
                    ],
                ),
              )

          )

      );

  }

  Future<void> _submit(CreatePostScreenViewModel createPostScreenViewModel) async {
    if (_formKey.currentState!.validate()) {

      Post createPost = await createPostScreenViewModel.createPost(Post(title: _title, body: _body, userId: 1));
      if (createPostScreenViewModel.isBack) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Created Post successfully.", style: TextStyle(fontSize: 18,
            color: Colors.white,)),
        ));
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListScreen(),

          ),
        );*/
        /*Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => ListScreen()
            )
        );*/
        Navigator.pop(context, true);//true for isCreated bool argument to list screen
      }
    }
  }


}
