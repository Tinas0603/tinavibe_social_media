import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:get/get.dart';

class ReplyController extends GetxController {
  final TextEditingController replyController = TextEditingController(text: "");
  var loading = false.obs;
  var reply = "".obs;
  void addReply(String userId, int postId, String postUserId) async {
    try {
      loading.value = true;
      // đếm tăng số lượng comment
      await SupabaseService.client
          .rpc("comment_increment", params: {"count": 1, "row_id": postId});

      //thêm thông báo
      await SupabaseService.client.from("notifications").insert({
        "user_id": userId,
        "notification": "Đã phản hồi về bài viết của bạn.",
        "to_user_id": postUserId,
        "post_id": postId,
      });
      // lưu comment lên database
      await SupabaseService.client.from("comments").insert({
        "post_id": postId,
        "user_id": userId,
        "reply": replyController.text,
      });
      loading.value = false;
      showSnackBar("Chúc mừng", "Phản hồi về bài viết của bạn đã hoàn tất!");
    } catch (e) {
      loading.value = false;
      showSnackBar("Lỗi", "Đã xảy ra lỗi, vui lòng thử lại");
    }
  }

  @override
  void onClose() {
    replyController.dispose();
    super.onClose();
  }
}
