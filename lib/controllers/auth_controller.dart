import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/services/storage_service.dart';
import 'package:flutter_tinavibe/services/supabase_service.dart';
import 'package:flutter_tinavibe/utils/helper.dart';
import 'package:flutter_tinavibe/utils/storage/storage_keys.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  var registerLoading = false.obs;
  var loginLoading = false.obs;
  Future<void> register(String name, String email, String password) async {
    try {
      registerLoading.value = true;
      final AuthResponse data = await SupabaseService.client.auth
          .signUp(email: email, password: password, data: {"name": name});
      registerLoading.value = false;
      if (data.user != null) {
        StorageService.session
            .write(StorageKeys.userSession, data.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (error) {
      registerLoading.value = false;
      showSnackBar("Error", error.message);
    }
  }

  // * login user
  Future<void> login(String email, String password) async {
    loginLoading.value = true;
    try {
      final AuthResponse response = await SupabaseService.client.auth
          .signInWithPassword(email: email, password: password);
      loginLoading.value = false;
      if (response.user != null) {
        StorageService.session
            .write(StorageKeys.userSession, response.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (error) {
      loginLoading.value = false;
      showSnackBar("Error", error.message);
    }
  }
}
