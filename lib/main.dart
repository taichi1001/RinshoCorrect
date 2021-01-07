import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/model/articles_controller.dart';
import 'package:rinsho_collect/ui/parts/auth_check.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  await Firebase.initializeApp();
  return runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends HookWidget {
  const MyApp({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(articlesController).fetch();
      return;
    }, []);
    return MaterialApp(
      title: 'test',
      theme: ThemeData(primaryColor: Colors.white),
      home: const AuthCheck(),
    );
  }
}
