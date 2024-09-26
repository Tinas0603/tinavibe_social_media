import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
