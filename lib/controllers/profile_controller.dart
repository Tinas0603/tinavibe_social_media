import 'dart:io';

import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/utils/env.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

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
}
