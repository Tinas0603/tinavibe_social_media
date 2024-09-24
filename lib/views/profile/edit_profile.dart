import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/profile_controller.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/widgets/image_circle.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController descriptionController =
      TextEditingController(text: "");
  final ProfileController controller = Get.find<ProfileController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    final userMetadata = supabaseService.currentUser.value?.userMetadata;

    // Set default value for "name"
    if (userMetadata?["name"] != null) {
      nameController.text = userMetadata?["name"];
    }

    // Set default value for "description"
    if (userMetadata?["description"] != null) {
      descriptionController.text = userMetadata?["description"];
    }

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chỉnh sửa hồ sơ"),
          actions: [
            Obx(
              () => TextButton(
                onPressed: () {
                  controller.updateProfile(
                    supabaseService.currentUser.value!.id,
                    nameController.text,
                    descriptionController.text,
                  );
                },
                child: controller.loading.value
                    ? const SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Xong"),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Obx(
                () => Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ImageCircle(
                      radius: 80,
                      file: controller.image.value,
                      url: supabaseService
                          .currentUser.value?.userMetadata?["image"],
                    ),
                    IconButton(
                      onPressed: () {
                        controller.pickImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white60,
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "",
                  label: Text("Họ và tên"),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "",
                  label: Text("Tiểu sử"),
                ),
              ),
            ],
          ),
        ));
  }
}
