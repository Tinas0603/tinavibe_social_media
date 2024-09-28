import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/post_controller.dart';
import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:get/get.dart';

class PostBottomBar extends StatefulWidget {
  final PostModel post;
  const PostBottomBar({required this.post, super.key});

  @override
  State<PostBottomBar> createState() => _PostBottomBarState();
}

class _PostBottomBarState extends State<PostBottomBar> {
  String likeStatus = "";
  final PostController controller = Get.find<PostController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  void likeDislike(String status) async {
    setState(() {
      likeStatus = status;
    });
    if (likeStatus == "0") {
      widget.post.likes = [];
    }
    await controller.likeDislike(status, widget.post.id!, widget.post.userId!,
        supabaseService.currentUser.value!.id);
  }

  // void likeDislike(String status) async {
  //   // Kiểm tra nếu id hoặc userId của post bị null
  //   if (widget.post.id == null ||
  //       widget.post.userId == null ||
  //       supabaseService.currentUser.value?.id == null) {
  //     print('Post ID hoặc User ID hoặc Current User ID bị null');
  //     return;
  //   }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            likeStatus == "1" || widget.post.likes!.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      likeDislike("0");
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red[700]!,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      likeDislike("1");
                    },
                    icon: const Icon(Icons.favorite_outline),
                  ),
            IconButton(
              onPressed: () {
                Get.toNamed(RouteNames.addReply, arguments: widget.post);
              },
              icon: const Icon(Icons.chat_bubble_outline),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send_outlined),
            )
          ],
        ),
        Row(
          children: [
            Text("${widget.post.likeCount} thích"),
            const SizedBox(width: 10),
            Text("${widget.post.commentCount} bình luận"),
          ],
        ),
      ],
    );
  }
}
