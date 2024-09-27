import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tinavibe/services/storage_service.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_tinavibe/routes/route.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/theme/theme.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await GetStorage.init();
  Get.put(SupabaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TinaVibe',
      theme: theme,
      getPages: Routes.pages,
      initialRoute: StorageService.userSession != null
          ? RouteNames.home
          : RouteNames.login,
      defaultTransition: Transition.noTransition,
    );
  }
}
