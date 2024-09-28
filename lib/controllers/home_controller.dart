import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/models/user_model.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  RxList<PostModel> posts = RxList<PostModel>();

  var loading = false.obs;

  @override
  onInit() async {
    await fetchPosts();
    listenChanges();
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

  void listenChanges() {
    SupabaseService.client
        .channel('public:posts')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'posts',
          callback: (payload) {
            print('Change received: ${payload.toString()}');
            final PostModel post = PostModel.fromJson(payload.newRecord);
            updateFeed(post);
          },
        )
        .onPostgresChanges(
            event: PostgresChangeEvent.delete,
            schema: 'public',
            table: 'posts',
            callback: (payload) {
              final int deletedId = payload.oldRecord['id'];
              posts.removeWhere((element) => element.id == deletedId);
            })
        .subscribe();
  }

  void updateFeed(PostModel post) async {
    var user = await SupabaseService.client
        .from("users")
        .select("*")
        .eq("id", post.userId!)
        .single();

    post.likes = [];
    post.user = UserModel.fromJson(user);
    posts.insert(0, post);
  }
}
