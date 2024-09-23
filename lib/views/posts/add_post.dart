import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: const Center(
        child: Text("I am Add Post"),
      ),
    );
  }
}
