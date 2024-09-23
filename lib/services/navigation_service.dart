import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/views/home/home_page.dart';
import 'package:flutter_tinavibe/views/notification/notifications.dart';
import 'package:flutter_tinavibe/views/posts/add_post.dart';
import 'package:flutter_tinavibe/views/profile/profile.dart';
import 'package:flutter_tinavibe/views/search/search.dart';
import 'package:get/get.dart';

class NavigationService extends GetxService {
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;

  // all pages
  List<Widget> pages() {
    return [
      const HomePage(),
      const Search(),
      const AddPost(),
      const Notifications(),
      const Profile(),
    ];
  }

  // update indev
  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }
}
