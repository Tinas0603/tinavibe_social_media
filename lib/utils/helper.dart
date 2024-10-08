import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_tinavibe/utils/env.dart';
import 'package:flutter_tinavibe/widgets/confirm_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

void showSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: const Color(0xff252526),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    snackStyle: SnackStyle.GROUNDED,
    margin: const EdgeInsets.all(0.0),
  );
}

// Lấy ảnh từ thư viện sử dụng image_picker
Future<File?> pickImageFromGallary() async {
  const uuid = Uuid();
  final ImagePicker picker = ImagePicker();

  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if (file == null) return null;
  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/${uuid.v6()}.jpg";
  final image = await compressImage(File(file.path), targetPath);
  return image;
}

// Nén file hình ảnh
Future<File> compressImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
      file.path, targetPath,
      quality: 70);
  return File(result!.path);
}

// Lấy url của s3
String getS3Url(String path) {
  return "${Env.supabaseUrl}/storage/v1/object/public/$path";
}

// * Hộp thoại xác thực
void confirmBox(String title, String text, VoidCallback callback) {
  Get.dialog(
    ConfirmDialog(
      title: title,
      text: text,
      callback: callback,
    ),
  );
}

// Định dạng ngày giờ cho múi giờ Việt Nam (UTC+7)
String formatDateFromNow(String date) {
  // Parse UTC timestamp string to DateTime
  DateTime utcDateTime = DateTime.parse(date.split('+')[0].trim());
  // Chuyển đổi từ UTC sang giờ Việt Nam (UTC+7)
  DateTime vnDateTime = utcDateTime.add(const Duration(hours: 7));

  final now = DateTime.now();
  final difference = now.difference(vnDateTime);

  if (difference.inSeconds < 60) {
    return 'Vài giây trước';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} phút trước';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} giờ trước';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ngày trước';
  } else {
    return DateFormat('dd/MM/yyyy').format(vnDateTime);
  }
}
