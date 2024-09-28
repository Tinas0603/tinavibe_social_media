import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/reply_model.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:flutter_tinavibe/utils/type_def.dart';

class ReplyCardTopBar extends StatelessWidget {
  final ReplyModel reply;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const ReplyCardTopBar(
      {required this.reply, this.isAuthCard = false, this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          reply.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(formatDateFromNow(reply.createdAt!)),
            isAuthCard
                ? GestureDetector(
                    onTap: () {
                      confirmBox("Bạn có chắc không?",
                          "Sau khi xoá sẽ không thể hoàn tác.", () {
                        callback!(reply.id!);
                      });
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
