import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/reply_model.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/utils/type_def.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';
import 'package:flutter_tinavibe/widgets/reply_card_top_bar.dart';
import 'package:get/get.dart';

class ReplyCard extends StatelessWidget {
  final ReplyModel reply;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const ReplyCard(
      {required this.reply, this.isAuthCard = false, this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Row(
            children: [
              SizedBox(
                width: context.width * 0.12,
                child: ImageCircle(
                  url: reply.user!.metadata?.image,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                child: SizedBox(
                  width: context.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReplyCardTopBar(
                        reply: reply,
                        isAuthCard: isAuthCard,
                        callback: callback,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteNames.showPost,
                              arguments: reply.postId);
                        },
                        child: Text(reply.reply!),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(
          color: Color(0xff242424),
        )
      ],
    );
  }
}
