import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/reply_model.dart';
import 'package:flutter_tinavibe/utils/helper.dart';

class ReplyCardTopBar extends StatelessWidget {
  final ReplyModel reply;
  const ReplyCardTopBar({required this.reply, super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatDateFromNow(reply.createdAt!)),
            const SizedBox(width: 10),
            const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
    ;
  }
}
