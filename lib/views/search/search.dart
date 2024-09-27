import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/search_user_controller.dart';
import 'package:flutter_tinavibe/views/search/search_input.dart';
import 'package:flutter_tinavibe/views/search/user_tile.dart';
import 'package:flutter_tinavibe/widgets/loading.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController textEditingController =
      TextEditingController(text: "");
  final SearchUserController controller = Get.put(SearchUserController());

  void searchUser(String? name) async {
    if (name != null) {
      await controller.searchUser(name);
    }
  }

  Future<void> _refreshData() async {
    // Xóa danh sách người dùng
    controller.users.clear();

    // Lấy lại danh sách người dùng
    await controller.searchUser(textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              centerTitle: false,
              title: const Text(
                "Tìm kiếm",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              expandedHeight: GetPlatform.isIOS ? 110 : 105,
              collapsedHeight: GetPlatform.isIOS ? 90 : 80,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(
                  top: GetPlatform.isIOS ? 105 : 80,
                  left: 10,
                  right: 10,
                ),
                child: SearchInput(
                  controller: textEditingController,
                  callback: searchUser,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => controller.loading.value
                    ? const Loading()
                    : Column(
                        children: [
                          if (controller.users.isNotEmpty)
                            ListView.builder(
                              itemCount: controller.users.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  UserTile(user: controller.users[index]),
                            )
                          else if (controller.users.isEmpty &&
                              controller.notFound.value == true)
                            const Text("Không tìm thấy người dùng")
                          else
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text("Nhập tên người dùng cần tìm kiếm"),
                              ),
                            )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
