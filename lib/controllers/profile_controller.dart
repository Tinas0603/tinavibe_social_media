import 'dart:io';

import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/models/reply_model.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/utils/env.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  var postLoading = false.obs;
  RxList<PostModel> posts = RxList<PostModel>();
  var replyLoading = false.obs;
  RxList<ReplyModel> replies = RxList<ReplyModel>();
  // Cập nhật hồ sơ người dùng
  Future<void> updateProfile(
      String userId, String name, String description) async {
    try {
      loading.value = true;
      var uploadedPath = "";
      if (image.value != null && image.value!.existsSync()) {
        final String dir = "$userId/profile.jpg";
        var path =
            await SupabaseService.client.storage.from(Env.s3Bucket).upload(
                  dir,
                  image.value!,
                  fileOptions: const FileOptions(upsert: true),
                );
        uploadedPath = path;
      }

      // Cập nhật hồ sơ
      await SupabaseService.client.auth.updateUser(UserAttributes(data: {
        "name": name,
        "description": description,
        "image": uploadedPath.isNotEmpty ? uploadedPath : null
      }));

      loading.value = false;
      Get.back();
      showSnackBar("Chúc mừng", "Hồ sơ của bạn đã được cập nhật!");
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar("Lỗi", error.message);
    } on AuthException catch (error) {
      loading.value = false;
      showSnackBar("Lỗi", error.message);
    } catch (error) {
      loading.value = false;
      showSnackBar("Lỗi", "Đang xảy ra sự cố, vui lòng thử lại.");
    }
  }

  // Lấy ảnh
  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) {
      image.value = file;
    }
  }

  // Tìm bài viết của người dùng
  void fetchUserPosts(String userId) async {
    try {
      postLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count,like_count,
    user:user_id (email , metadata)
''').eq("user_id", userId).order("id", ascending: false);
      postLoading.value = false;
      if (response.isNotEmpty) {
        posts.value = [for (var item in response) PostModel.fromJson(item)];
      }
    } catch (e) {
      postLoading.value = false;
      showSnackBar("Lỗi", "Xin vui lòng thử lại sau");
    }
  }

// Tìm phản hồi của người dùng
  void fetchReplies(String userId) async {
    try {
      replyLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("comments").select('''
        id , user_id , post_id ,reply ,created_at ,user:user_id (email , metadata)
''').eq("user_id", userId).order("id", ascending: false);
      replyLoading.value = false;
      if (response.isNotEmpty) {
        replies.value = [for (var item in response) ReplyModel.fromJson(item)];
      }
    } catch (e) {
      replyLoading.value = false;
      showSnackBar("Lỗi", "Xin vui lòng thử lại sau");
    }
  }
}
