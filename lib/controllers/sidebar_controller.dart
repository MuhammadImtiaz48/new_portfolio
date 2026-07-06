import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/models/sidebar_item_model.dart';

class SidebarController extends GetxController {
  final RxInt activeIndex = 0.obs;

  final List<SidebarItemModel> items = const [
    SidebarItemModel(
      label: 'Home',
      icon: Icons.home_rounded,
      route: 'home',
    ),
    SidebarItemModel(
      label: 'About',
      icon: Icons.person_rounded,
      route: 'about',
    ),
    SidebarItemModel(
      label: 'Projects',
      icon: Icons.grid_view_rounded,
      route: 'projects',
    ),
    SidebarItemModel(
      label: 'Contact',
      icon: Icons.mail_rounded,
      route: 'contact',
    ),
  ];

  void setActive(int index) {
    if (activeIndex.value != index) {
      activeIndex.value = index;
    }
  }
}
