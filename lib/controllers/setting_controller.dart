import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/utils/storage/storage.dart';
import 'package:flutter_tinavibe/utils/storage/storage_keys.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  void logout() async {
    // Xoá phiên người dùng khỏi lưu trữ cục bộ
    Storage.session.remove(StorageKeys.userSession);
    SupabaseService.client.auth.signOut();

    Get.offAllNamed(RouteNames.login);
  }
}
