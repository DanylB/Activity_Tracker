import 'package:flutter/material.dart';

class BottomNavBarPageIndexModel extends ChangeNotifier {
  int bottomNavPageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  Future<void> getBottomNavBarPageIndex(index) async {
    bottomNavPageIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(microseconds: 250), curve: Curves.bounceInOut);
    notifyListeners();
  }
}
