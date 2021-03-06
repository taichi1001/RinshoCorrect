import 'package:flutter/material.dart';
import 'package:rinsho_collect/ui/article_list_screen.dart';
import 'package:rinsho_collect/ui/bookmark_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/ui/home_screen.dart';
import 'package:rinsho_collect/ui/terminology_list_screen.dart';

final bottomNavigationController =
    ChangeNotifierProvider.autoDispose((ref) => BottomNavigationController(read: ref.read));

class BottomNavigationController extends ChangeNotifier {
  BottomNavigationController({
    this.read,
  });
  Reader read;

  final List<Widget> views = [
    const HomeScreen(),
    const ArticleListScreen(),
    const TerminologyListScreen(),
    const BookmarkScreen(),
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  Widget _selectedView = const HomeScreen();
  Widget get selectedView => _selectedView;

  void change(int index) {
    _selectedIndex = index;
    _selectedView = views[index];
    notifyListeners();
  }
}
