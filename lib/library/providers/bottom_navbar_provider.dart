import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int selectedPage = 0;

  changePage(int value) {
    selectedPage = value;
    notifyListeners();
  }
}
