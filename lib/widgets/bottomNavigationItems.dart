import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation {
  IconData icon;
  String label;
  double iconSize;
  BottomNavigation(this.icon, this.label);

  FFNavigationBarItem bottomNavigation() {
    return FFNavigationBarItem(
        iconData: icon,
        label: label,

    );
  }
}
