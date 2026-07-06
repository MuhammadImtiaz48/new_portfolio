import 'package:flutter/widgets.dart';

class SidebarItemModel {
  final String label;
  final IconData icon;
  final String route;

  const SidebarItemModel({
    required this.label,
    required this.icon,
    required this.route,
  });
}
