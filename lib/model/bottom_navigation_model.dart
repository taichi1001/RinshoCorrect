import 'package:flutter/material.dart';
import 'package:rinsho_collect/ui/joint_screen.dart';
import 'package:rinsho_collect/ui/functions_and_performance_screen.dart';
import 'package:rinsho_collect/ui/favorite_screen.dart';

class BottomNavigationModel with ChangeNotifier {
  final List<Widget> options = [
    const JointScreen(),
    const FunctionsAndPerformanceScreen(),
    const FavoriteScreen(),
  ];

  int selectedIndex = 0;

  void change(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedScreen() => options[selectedIndex];
}
