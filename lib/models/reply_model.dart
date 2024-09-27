import 'package:flutter_tinavibe/models/user_model.dart';

class ReplyModel {
  int? id;
  String? reply;
  String? createdAt;
  String? userId;
  int? postId; // Thêm thuộc tính này
  UserModel? user;

  ReplyModel({
    this.id,
    this.reply,
    this.createdAt,
    this.userId,
    this.postId, // Thêm vào constructor
    this.user,
  });

  ReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    postId = json['post_id']; // Thêm vào đây
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
}
