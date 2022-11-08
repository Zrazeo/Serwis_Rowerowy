import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in_pages/login_page.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in_pages/sing_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickedSignUp: toggle)
      : SingUpPage(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
