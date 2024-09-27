import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/models/reply_model.dart';
import 'package:flutter_tinavibe/services/navigation_service.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/utils/env.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  final TextEditingController textEditingController =
      TextEditingController(text: "");
  var content = "".obs;
  var loading = false.obs;

  Rx<File?> image = Rx<File?>(null);

  var showPostLoading = false.obs;
  Rx<PostModel> post = Rx<PostModel>(PostModel());
  var showReplyLoading = false.obs;
  RxList<ReplyModel> replies = RxList<ReplyModel>();
  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) {
      image.value = file;
    }
  }

// Đăng bài viết
  void store(String userId) async {
    try {
      loading.value = true;
      const uuid = Uuid();
      final dir = "$userId/${uuid.v6()}";
      var imgPath = "";
      if (image.value != null && image.value!.existsSync()) {
        imgPath = await SupabaseService.client.storage
            .from(Env.s3Bucket)
            .upload(dir, image.value!);
      }

      // Lưu bài đăng vào database
      await SupabaseService.client.from("posts").insert({
        "user_id": userId,
        "content": content.value,
        "image": imgPath.isNotEmpty ? imgPath : null
      });

      loading.value = false;
      resetState();
      Get.find<NavigationService>().currentIndex.value = 0;
      showSnackBar("Chúc mừng", "Bài viết của bạn đã được đăng tải hoàn tất!");
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar("Lỗi", error.message);
    } catch (error) {
      loading.value = false;
      showSnackBar("Lỗi", "Đã xảy ra lỗi!");
    }
  }

  // đặt lại trạng thái bài đăng
  void resetState() {
    content.value = "";
    textEditingController.text = "";
    image.value = null;
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  // hiển thị chi tiết bài viết khi nhấn vào
  void show(int postId) async {
    try {
      post.value = PostModel();
      replies.value = [];
      showPostLoading.value = true;
      final response = await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count , like_count,user_id,
    user:user_id (email , metadata)''').eq("id", postId).single();
      showPostLoading.value = false;
      post.value = PostModel.fromJson(response);

      // Tìm bình luận của bài viết
      fetchPostReplies(postId);
    } catch (e) {
      showPostLoading.value = false;
      showSnackBar("Lỗi", "Vui lòng thử lại sau");
    }
  }

  // tìm bài viết chứa bình luận đó
  void fetchPostReplies(int postId) async {
    try {
      showReplyLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("comments").select('''
        id , user_id , post_id ,reply ,created_at ,user:user_id (email , metadata)
''').eq("post_id", postId);
      showReplyLoading.value = false;
      if (response.isNotEmpty) {
        replies.value = [for (var item in response) ReplyModel.fromJson(item)];
      }
    } catch (e) {
      showReplyLoading.value = false;
      showSnackBar("Lỗi", "Vui lòng thử lại sau");
    }
  }
}
