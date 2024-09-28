import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/notification_controller.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
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
    super.initState();
    _refreshNotifications(); // Fetch notifications on init
  }

  // Function to fetch and refresh notifications
  Future<void> _refreshNotifications() async {
    // Set loading to true to show loading indicator
    controller.loading.value = true;

    // Clear the existing notifications to avoid showing stale data
    controller.notifications.clear();

    // Fetch the latest notifications from the server
    await controller.fetchNotifications(supabaseService.currentUser.value!.id);

    // Set loading to false once data is fetched
    controller.loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.find<NavigationService>().backToPreviousPage(),
          icon: const Icon(Icons.close),
        ),
        title: const Text("Thông báo"),
        actions: [
          // Button to refresh notifications
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshNotifications, // Trigger the refresh manually
          ),
        ],
      ),
      body: Obx(
        () => controller.loading.value
            ? const Loading() // Show loading indicator while fetching
            : controller.notifications.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Get.toNamed(RouteNames.showPost,
                            arguments:
                                controller.notifications[index]!.postId!);
                      },
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
                      subtitle:
                          Text(controller.notifications[index]!.notification!),
                    ),
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Không có thông báo nào"),
                    ),
                  ),
      ),
    );
  }
}
