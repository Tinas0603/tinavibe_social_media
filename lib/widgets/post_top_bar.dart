import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tinavibe/models/post_model.dart';

class PostTopBar extends StatelessWidget {
  final PostModel post;
  const PostTopBar({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          post.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Row(
          children: [
            Text("9 hours ago"),
            SizedBox(width: 10),
            Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
