import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rinsho_collect/ui/main_bottom_navigation.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({
    key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.hasData) {
          // 認証ずみ
          return const MainBottomNavigation();
        } else {
          // スプラッシュスクリーン
          return const SplashScreen();
        }
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    key,
  }) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // 認証を行うメソッド
  Future<void> _signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  @override
  void initState() {
    super.initState();
    // 実行部分
    _signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
