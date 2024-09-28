import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/profile_controller.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/views/profile/profile.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';
import 'package:flutter_tinavibe/widgets/loading.dart';
import 'package:flutter_tinavibe/widgets/post_card.dart';
import 'package:flutter_tinavibe/widgets/reply_card.dart';
import 'package:get/get.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final String userId = Get.arguments;
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.fetchUser(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Icon(Icons.language),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () => Get.toNamed(RouteNames.setting),
                icon: const Icon(Icons.sort))
          ]),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 100,
                collapsedHeight: 100,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (controller.userLoading.value)
                                  const Loading()
                                else
                                  Text(
                                    controller.user.value!.metadata!.name!,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                SizedBox(
                                  width: context.width * 0.65,
                                  child: Text(
                                      controller.user.value?.metadata?.name ??
                                          "Thêm tiểu sử"),
                                )
                              ],
                            ),
                          ),
                          Obx(
                            () => ImageCircle(
                              file: controller.image.value,
                              url: controller.user.value?.metadata?.image,
                              radius: 40,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: SliverAppBarDelegate(
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        text: "Bài viết",
                      ),
                      Tab(
                        text: "Bình luận",
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Obx(
                () => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      if (controller.postLoading.value)
                        const Loading()
                      else if (controller.posts.isNotEmpty)
                        ListView.builder(
                          itemCount: controller.posts.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => PostCard(
                            post: controller.posts[index],
                          ),
                        )
                      else
                        const Center(
                          child: Text("Không có bài viết nào!"),
                        )
                    ],
                  ),
                ),
              ),
              Obx(() => SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        if (controller.replyLoading.value)
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
                            child: Text("Không có bình luận nào!"),
                          )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
