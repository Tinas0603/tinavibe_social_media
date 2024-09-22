import 'package:flutter_tinavibe/routes/route_names.dart';
import 'package:flutter_tinavibe/views/auth/login.dart';
import 'package:flutter_tinavibe/views/auth/register.dart';
import 'package:flutter_tinavibe/views/home.dart';
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
  ];
}
