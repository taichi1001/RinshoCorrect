import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<UserCredential> _signInWithGoogle() async {
    // 認証フローのトリガー
    final googleUser = await GoogleSignIn(
      scopes: [
        'email',
      ],
    ).signIn();
    // リクエストから、認証情報を取得
    final googleAuth = await googleUser.authentication;
    // クレデンシャルを新しく作成
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // サインインしたら、UserCredentialを返す
    return FirebaseAuth.instance.signInWithCredential(credential);
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
        //     child: RaisedButton(
        //   onPressed: () async {
        //     try {
        //       final userCredential = await _signInWithGoogle();
        //     } on FirebaseAuthException catch (e) {
        //       print('FirebaseAuthException');
        //       print('${e.code}');
        //     } on Exception catch (e) {
        //       print('Other Exception');
        //       print('${e.toString()}');
        //     }
        //   },
        // )),
      ),
    );
  }
}
