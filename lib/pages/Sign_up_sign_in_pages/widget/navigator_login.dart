import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in_pages/widget/auth_page.dart';
import 'package:sklep_rowerowy/pages/bike_page/bike_page.dart';

class NavigatorLogin extends StatelessWidget {
  const NavigatorLogin({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const ShoppingScene();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Coś poszło nie tak'),
              );
            } else {
              return const AuthPage();
            }
          },
        ),
      );
}
