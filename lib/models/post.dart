/*
{
  id: 1,
  title: '...',
  body: '...',
  userId: 1
} */

import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  int? id;
  String? title;
  String? body;
  int? userId;

  static Post empty(){
    return Post();
  }

  static bool isNotEmpty(Post post){
    return post.id!=null;
  }

  Post({this.id, this.title, this.body,  this.userId});

  /*Data.fromJson(Map<String, dynamic> json) {
    todoId = json['_id'];
    todoName = json['todoName'];
    isComplete = json['isComplete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = todoId;
    data['todoName'] = todoName;
    data['isComplete'] = isComplete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    return data;
  }*/

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}