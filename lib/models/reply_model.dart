import 'package:flutter_tinavibe/models/user_model.dart';

class ReplyModel {
  int? id;
  String? reply;
  String? createdAt;
  String? userId;
  UserModel? user;

  ReplyModel({this.id, this.reply, this.createdAt, this.userId, this.user});

  ReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
