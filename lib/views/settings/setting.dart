import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/setting_controller.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  Setting({super.key});
  final SettingController controller = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Đăng xuất"),
              onTap: () {
                confirmBox("Cảnh báo!", "Bạn có muốn đăng xuất không?", () {
                  controller.logout();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
