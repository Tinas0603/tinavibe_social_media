import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tinavibe/controllers/post_controller.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/widgets/add_post_appbar.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';
import 'package:flutter_tinavibe/widgets/post_image_preview.dart';
import 'package:get/get.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});

  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final PostController controller = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddPostAppbar(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => ImageCircle(
                      url: supabaseService
                          .currentUser.value!.userMetadata?["image"],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: context.width * 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            supabaseService
                                .currentUser.value!.userMetadata?["name"],
                          ),
                        ),
                        TextField(
                          autofocus: true,
                          controller: controller.textEditingController,
                          onChanged: (value) =>
                              controller.content.value = value,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 10,
                          minLines: 1,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                            hintText: "bạn đang nghĩ gì ?",
                            border: InputBorder.none,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: const Icon(Icons.attach_file),
                        ),

                        // Xem trước ảnh đăng tải
                        Obx(
                          () => Column(
                            children: [
                              if (controller.image.value != null)
                                PostImagePreview()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
