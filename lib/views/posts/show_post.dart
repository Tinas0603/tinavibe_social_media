import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/post_controller.dart';
import 'package:flutter_tinavibe/widgets/loading.dart';
import 'package:flutter_tinavibe/widgets/post_card.dart';
import 'package:flutter_tinavibe/widgets/reply_card.dart';
import 'package:get/get.dart';

class ShowPost extends StatefulWidget {
  const ShowPost({super.key});

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  final int postId = Get.arguments;
  final PostController controller = Get.put(PostController());
  @override
  void initState() {
    controller.show(postId);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài viết"),
      ),
      body: Obx(
        () => controller.showPostLoading.value
            ? const Loading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    PostCard(post: controller.post.value),
                    const SizedBox(height: 20),

                    // Load những bình luận về bài viết đó
                    if (controller.showPostLoading.value)
                      const Loading()
                    else if (controller.replies.isNotEmpty)
                      ListView.builder(
                        itemCount: controller.replies.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            ReplyCard(reply: controller.replies[index]),
                      )
                    else
                      const Center(
                        child: Text("Không có bình luận nào"),
                      )
                  ],
                ),
              ),
      ),
    );
  }
}
