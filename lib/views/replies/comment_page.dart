import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';

class CommentsPage extends StatelessWidget {
  final PostModel post;

  CommentsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bình luận"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: SupabaseService.client
            .from("comments")
            .select("reply, user:user_id (metadata)")
            .eq("post_id", post.id!)
            .order("created_at", ascending: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text("Chưa có bình luận nào."));
          }

          List<dynamic> comments = snapshot.data ?? [];

          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              var comment = comments[index];
              var userMetadata = comment['user']['metadata'];

              String? imageUrl = userMetadata?['image'];
              String name = userMetadata?['name'];

              return ListTile(
                leading: ImageCircle(
                  url: imageUrl,
                  radius: 20,
                ),
                title: Text(name),
                subtitle: Text(comment['reply']),
              );
            },
          );
        },
      ),
    );
  }
}
