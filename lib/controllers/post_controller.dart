import 'dart:io';

import 'package:flutter/material.dart';
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
}
