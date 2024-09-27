import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tinavibe/controllers/notification_controller.dart';
import 'package:flutter_tinavibe/services/navigation_service.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';
import 'package:flutter_tinavibe/widgets/loading.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final NotificationController controller = Get.put(NotificationController());
  @override
  void initState() {
    controller
        .fetchNotifications(Get.find<SupabaseService>().currentUser.value!.id);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.find<NavigationService>().backToPreviousPage(),
          icon: const Icon(Icons.close),
        ),
        title: const Text("Thông báo"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.loading.value
              ? const Loading()
              : Column(
                  children: [
                    if (controller.notifications.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.notifications.length,
                        itemBuilder: (context, index) => ListTile(
                          titleAlignment: ListTileTitleAlignment.top,
                          isThreeLine: true,
                          leading: ImageCircle(
                            url: controller
                                .notifications[index]!.user!.metadata?.image,
                          ),
                          title: Text(controller
                              .notifications[index]!.user!.metadata!.name!),
                          trailing: Text(formatDateFromNow(
                              controller.notifications[index]!.createdAt!)),
                          subtitle: Text(
                              controller.notifications[index]!.notification!),
                        ),
                      )
                    else
                      const Text("Không có thông báo nào"),
                  ],
                ),
        ),
      ),
    );
  }
}
