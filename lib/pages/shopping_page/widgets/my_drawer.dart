import 'package:firebase_auth/firebase_auth.dart%20';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_rowerowy/pages/chat_page/chats_list_page.dart';
import 'package:sklep_rowerowy/pages/favorites_product/favortes_product.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in/google_sign_in.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in/login_page.dart';
import 'package:sklep_rowerowy/pages/my_bikes/my_bikes_page.dart';
import 'package:sklep_rowerowy/pages/shopping_page/shopping_scene.dart';
import 'package:sklep_rowerowy/style/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../add_product/add_product_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  user.photoURL ?? 'https://i.imgur.com/UOV4frY.png'),
            ),
            accountEmail: Text(user.email!),
            accountName: Text(
              user.displayName ?? 'username',
              style: const TextStyle(fontSize: 24.0),
            ),
            decoration: const BoxDecoration(
              color: AppStandardsColors.backgroundColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.pedal_bike),
            title: const Text(
              'Rowery',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ShoppingScene(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text(
              'Części',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ShoppingScene(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.my_library_add),
            title: const Text(
              'Dodaj ogłoszenie',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AddProductPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text(
              'Czaty',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ChatsListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.my_library_books),
            title: const Text(
              'Moje ogłoszenia',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MyBikesPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text(
              'Zapisane',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => FavoritesProduct(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.compare_arrows),
            title: const Text(
              'Porównywarka',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ShoppingScene(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text(
              'Wyloguj',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () => FirebaseAuth.instance.signOut(),
            // final provider =
            //     Provider.of<GoogleSignInProvider>(context, listen: false);
            // provider.logout();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) => const LoginPage(),
            //   ),
            // );
          ),
        ],
      ),
    );
  }
}
