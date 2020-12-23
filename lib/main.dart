// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rinsho_collect/model/article_model.dart';
import 'package:rinsho_collect/model/bottom_navigation_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/ui/joint_screen.dart';
import 'package:rinsho_collect/ui/main_bottom_navigation.dart';
import 'global.dart' as global;

void main() {
  global.article = ArticleModel();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  return runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: MainBottomNavigation(),
      home: JointScreen(),
    );
  }
}
