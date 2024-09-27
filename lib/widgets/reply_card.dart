import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/reply_model.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';
import 'package:flutter_tinavibe/widgets/reply_card_top_bar.dart';
import 'package:get/get.dart';

class ReplyCard extends StatelessWidget {
  final ReplyModel reply;
  const ReplyCard({required this.reply, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: ImageCircle(
                url: reply.user?.metadata?.image,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReplyCardTopBar(
                    reply: reply,
                  ),
                  Text(reply.reply!),
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
