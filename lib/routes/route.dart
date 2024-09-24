import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/views/auth/login.dart';
import 'package:flutter_tinavibe/views/auth/register.dart';
import 'package:flutter_tinavibe/views/home.dart';
import 'package:flutter_tinavibe/views/profile/edit_profile.dart';
import 'package:flutter_tinavibe/views/settings/setting.dart';
import 'package:get/route_manager.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => Home()),
    GetPage(
        name: RouteNames.login,
        page: () => const Login(),
        transition: Transition.fade),
    GetPage(
        name: RouteNames.register,
        page: () => const Register(),
        transition: Transition.fadeIn),
    GetPage(
      name: RouteNames.editProfile,
      page: () => const EditProfile(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.setting,
      page: () => Setting(),
      transition: Transition.rightToLeft,
    ),
  ];
}
