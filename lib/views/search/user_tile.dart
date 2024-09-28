import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/models/user_model.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/utils/styles/button_styles.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';
import 'package:get/get.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ImageCircle(url: user.metadata?.image),
      ),
      title: Text(user.metadata!.name!),
      titleAlignment: ListTileTitleAlignment.center,
      trailing: OutlinedButton(
        onPressed: () {
          Get.toNamed(RouteNames.showUser, arguments: user.id!);
        },
        style: customOutlineStyle(),
        child: const Text("Xem hồ sơ"),
      ),
    );
  }
}
