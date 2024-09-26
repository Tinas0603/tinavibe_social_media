import 'package:flutter_tinavibe/models/user_model.dart';

class PostModel {
  int? id;
  String? content;
  String? image;
  String? userId;
  int? likeCount;
  int? commentCount;
  String? createdAt;
  UserModel? user;

  PostModel({
    this.id,
    this.content,
    this.image,
    this.createdAt,
    this.user,
    this.likeCount,
    this.commentCount,
    this.userId,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    commentCount = json['comment_count'];
    userId = json['user_id'];
    likeCount = json['like_count'];
    image = json['image'];
    createdAt = json['created_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['like_count'] = likeCount;
    data['comment_count'] = commentCount;
    data['user_id'] = userId;
    data['image'] = image;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
