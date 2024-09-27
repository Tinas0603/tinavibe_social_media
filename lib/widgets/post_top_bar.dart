import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/utils/helper.dart';

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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatDateFromNow(post.createdAt!)),
            const SizedBox(width: 10),
            const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
