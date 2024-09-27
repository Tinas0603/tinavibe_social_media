import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:get/get.dart';

class ShowZoomImage extends StatelessWidget {
  final String image = Get.arguments;
  ShowZoomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(
          getS3Url(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
