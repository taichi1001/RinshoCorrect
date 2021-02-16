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
      theme: ThemeData(
        primaryColor: materialWhite,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        // canvasColor: const Color(0xFFf4f9f7),
        // canvasColor: const Color(0xFFe7f2ee),
      ),
      home: const AuthCheck(),
    );
  }
}

const MaterialColor materialWhite = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
