import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_tinavibe/routes/route.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TinaVibe',
      theme: theme,
      getPages: Routes.pages,
      initialRoute: RouteNames.login,
    );
  }
}
