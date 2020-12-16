// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rinsho_collect/model/bottom_navigation_model.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationModel>(
          create: (context) => BottomNavigationModel(),
        ),
      ],
      child: const MaterialApp(
        home: MainBottomNavigation(),
      ),
    );
  }
}
