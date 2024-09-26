import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:get/get.dart';

class PostBottomBar extends StatelessWidget {
  final PostModel post;
  const PostBottomBar({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(RouteNames.addReply, arguments: post);
              },
              icon: const Icon(Icons.chat_bubble_outline),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send_outlined),
            ),
          ],
        ),
        Row(
          children: [
            Text("${post.likeCount} thích"),
            const SizedBox(width: 10),
            Text("${post.commentCount} bình luận"),
          ],
        ),
      ],
    );
  }
}
