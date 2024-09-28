import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/utils/type_def.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';
import 'package:flutter_tinavibe/widgets/post_bottom_bar.dart';
import 'package:flutter_tinavibe/widgets/post_card_image.dart';
import 'package:flutter_tinavibe/widgets/post_top_bar.dart';
import 'package:get/get.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const PostCard({
    required this.post,
    this.isAuthCard = false,
    this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: Column(
                children: [
                  ImageCircle(url: post.user?.metadata?.image),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostTopBar(
                    post: post,
                    isAuthCard: isAuthCard,
                    callback: callback,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Get.toNamed(RouteNames.showPost, arguments: post.id),
                    child: Text(post.content!),
                  ),
                  //Hiển thị ảnh nếu tồn tại
                  const SizedBox(height: 10),
                  if (post.image != null)
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteNames.showImage,
                              arguments: post.image!);
                        },
                        child: PostCardImage(url: post.image!)),
                  PostBottomBar(post: post),
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: Color(0xff242424),
        )
      ],
    );
  }
}
