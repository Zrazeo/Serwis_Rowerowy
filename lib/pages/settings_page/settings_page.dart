import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in_pages/widget/utils.dart';

import '../../style/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static TextEditingController emailController = TextEditingController();
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File? imageFile;

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ustawienia",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: AppStandardsColors.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    user.photoURL ?? 'https://i.imgur.com/UOV4frY.png'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Witaj',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            Text(
              user.displayName ?? 'username',
              style: const TextStyle(
                fontSize: 24,
                color: AppStandardsColors.backgroundColor,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppStandardsColors.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  listTile(
                    Icons.image,
                    'Zmień avatar',
                    changeAvatar,
                  ),
                  const Divider(color: Colors.white),
                  listTile(
                    Icons.key,
                    'Zmień hasło',
                    () => displayDialog(context),
                  ),
                  const Divider(color: Colors.white),
                  listTile(
                    Icons.exit_to_app,
                    'Wyloguj',
                    () => signOut(context),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTile(IconData icon, String text, Function()? function) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadFile() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String typeOfFile = imageFile!.path.substring(imageFile!.path.length - 3);
    try {
      await storage
          .ref('avatar/${user.displayName}.$typeOfFile')
          .putFile(imageFile!);
    } on FirebaseStorage catch (e) {
      print(e);
    }
    return downloadUrl(storage, typeOfFile);
  }

  Future<String> downloadUrl(FirebaseStorage storage, String typeOfFile) {
    Future<String> downloadUrl =
        storage.ref('avatar/${user.displayName}.$typeOfFile').getDownloadURL();
    return downloadUrl;
  }

  Future<void> changeAvatar() async {
    await _getFromGallery();
    String urlImage = await uploadFile();

    try {
      var user = FirebaseAuth.instance.currentUser;
      user!.updatePhotoURL(urlImage);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.displayName)
        .update({
      'image_url': urlImage,
    });
  }

  displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
              'Wprowadź email na który dostaniesz wiadomość do zmiany hasła'),
          content: TextFormField(
            controller: SettingsPage.emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Wprowadz poprawny email'
                    : null,
          ),
          actions: [
            TextButton(
              child: const Text('Zatwierdź'),
              onPressed: () {
                resetPassword(context);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: SettingsPage.emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      Utils.showSnackBar(e.message);
    }
    Utils.showSnackBar('Email do zmiany hasła został wysłany');
  }
}

void signOut(BuildContext context) {
  Navigator.of(context).pop();
  FirebaseAuth.instance.signOut();
}
