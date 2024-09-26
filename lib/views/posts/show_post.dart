import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/post_controller.dart';
import 'package:get/get.dart';

class ShowThread extends StatefulWidget {
  const ShowThread({super.key});

  @override
  State<ShowThread> createState() => _ShowThreadState();
}

class _ShowThreadState extends State<ShowThread> {
  final int postId = Get.arguments;
  final PostController controller = Get.put(PostController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thread"),
      ),
    );
  }
}
