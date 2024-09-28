import 'dart:convert';

import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<PostModel> posts = RxList<PostModel>();

  var loading = false.obs;

  @override
  onInit() async {
    await fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts() async {
    loading.value = true;
    final List<dynamic> data =
        await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count , like_count,user_id,
    user:user_id (email , metadata) , likes:likes (user_id, post_id)''').order("id", ascending: false);
    loading.value = false;

    if (data.isNotEmpty) {
      posts.value = [for (var item in data) PostModel.fromJson(item)];
    }
  }
}
