import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/ui/main_bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  return runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: const MainBottomNavigation(),
      ),
    );
  }
}
