import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in/google_sign_in.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in/navigator_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

String compareFirstBike = '';
String compareSecondBike = '';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          scaffoldMessengerKey: messengerKey,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Serwis ogłoszeniowy do rowerów',
          home: const NavigatorLogin(),
        ),
      );
}
