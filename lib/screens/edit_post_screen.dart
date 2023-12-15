import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/models_2/post.dart';
import 'package:flutter_dio/viewmodels/edit_post_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  List<String> selectionList = ["true", "false"];
  String? _title, _body;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Post;
    _title = post.title;
    _body = post.body;
    var viewModel = Provider.of<EditPostScreenViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Post",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ),
      body:
      Padding(
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
                  initialValue: _title,
                  decoration: const InputDecoration(
                    labelText: 'title',
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
                  initialValue: _body,
                  decoration: const InputDecoration(
                    labelText: 'body',
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
                    child:
                    viewModel.isLoading?
                        const Center(
                          child: CircularProgressIndicator(),
                        ) :

                        ElevatedButton(
                          onPressed: _title!.isNotEmpty && _body!.isNotEmpty ? (){_submit(post, viewModel);}: null,
                          child: Text(
                            'Edit',
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

  Future<void> _submit(Post post, EditPostScreenViewModel viewModel) async {
    if (kDebugMode) {
      print('in _submit');
    }
    if (_formKey.currentState!.validate()) {
      if (kDebugMode) {
        print('form validated');
      }
      Post updatedPost = await viewModel.updatePost(Post(title: _title, body: _body, userId: post.userId, id: post.id ));
      if (viewModel.isBack) {
        if (kDebugMode) {
          print('isBack: true');
        }
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Created todo successfully.", style: TextStyle(fontSize: 18,
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
      else{
        if (kDebugMode) {
          print('isBack: false');
        }
      }
    }
    else{
      if (kDebugMode) {
        print('form not validated');
      }
    }
  }

}
