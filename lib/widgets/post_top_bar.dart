import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tinavibe/models/post_model.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:flutter_tinavibe/utils/type_def.dart';
import 'package:get/get.dart';

class PostTopBar extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const PostTopBar({
    required this.post,
    this.isAuthCard = false,
    this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(RouteNames.showUser, arguments: post.userId),
          child: Text(
            post.user!.metadata!.name!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatDateFromNow(post.createdAt!)),
            const SizedBox(width: 10),
            isAuthCard
                ? GestureDetector(
                    onTap: () => {
                      confirmBox("Bạn có chắc không?",
                          "Sau khi xoá sẽ không thể hoàn tác.", () {
                        callback!(post.id!);
                      })
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
