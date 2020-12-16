import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rinsho_collect/model/bottom_navigation_model.dart';

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context, listen: true);
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812), // iPhoneXsのサイズを基準に設定
    );
    return Scaffold(
      body: Center(
        child: bottomNavigationModel.getSelectedScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.ac_unit),
            title: Text('関節'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.pie_chart),
            title: Text('機能・性能'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.input),
            title: Text('お気に入り'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavigationModel.selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: (index) {
          bottomNavigationModel.change(index);
        },
      ),
    );
  }
}
