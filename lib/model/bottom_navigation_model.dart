import 'package:flutter/material.dart';
import 'package:rinsho_collect/ui/joint_screen.dart';
import 'package:rinsho_collect/ui/favorite_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/ui/terminology_list_screen.dart';

final bottomNavigationController =
    ChangeNotifierProvider.autoDispose((ref) => BottomNavigationController(read: ref.read));

class BottomNavigationController extends ChangeNotifier {
  BottomNavigationController({
    this.read,
  });
  Reader read;

  final List<Widget> views = [
    const JointScreen(),
    const TerminologyListScreen(),
    const FavoriteScreen(),
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  Widget _selectedView = const JointScreen();
  Widget get selectedView => _selectedView;

  void change(int index) {
    _selectedIndex = index;
    _selectedView = views[index];
    notifyListeners();
  }
}
