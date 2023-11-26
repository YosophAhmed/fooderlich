import 'package:flutter/material.dart';

class TabManger extends ChangeNotifier {
  int selectedTab = 0;
  void goToTab({
    required int index,
  }) {
    selectedTab = index;
    notifyListeners();
  }
  void goToRecipes() {
    selectedTab = 1;
    notifyListeners();
  }
}
