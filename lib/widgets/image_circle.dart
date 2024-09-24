import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/utils/helper.dart';

class ImageCircle extends StatelessWidget {
  final double radius;
  final String? url;
  final File? file;
  const ImageCircle({this.radius = 20, this.url, this.file, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (file != null)
          CircleAvatar(
            backgroundImage: FileImage(file!),
            radius: radius,
          )
        else if (url != null)
          CircleAvatar(
            backgroundImage: NetworkImage(getS3Url(url!)),
            radius: radius,
          )
        else
          CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage("assets/images/avatar.png"),
          ),
      ],
    );
  }
}
