import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/model/bottom_navigation_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainBottomNavigation extends HookWidget {
  const MainBottomNavigation({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedIndex =
        useProvider(bottomNavigationController.select((controller) => controller.selectedIndex));
    final _selectedView =
        useProvider(bottomNavigationController.select((controller) => controller.selectedView));
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812), // iPhoneXsのサイズを基準に設定
    );
    return Scaffold(
      body: Center(
        child: _selectedView,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: '記事',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: '用語',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: 'ブックマーク',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: (index) {
          context.read(bottomNavigationController).change(index);
        },
      ),
    );
  }
}
