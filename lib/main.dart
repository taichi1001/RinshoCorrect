import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/ui/main_bottom_navigation.dart';
import 'package:rinsho_collect/ui/parts/auth_check.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  await Firebase.initializeApp();
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
        title: 'test',
        theme: ThemeData(primaryColor: Colors.white),
        home: const AuthCheck(),
      ),
    );
  }
}
