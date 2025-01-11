import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  PersistentTabController tabController = PersistentTabController(initialIndex: 0);

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    tabController.index = index; // Set tabController index
    notifyListeners();
  }
}