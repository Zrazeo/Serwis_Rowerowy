// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sklep_rowerowy/pages/Sign_up_sign_in/google_sign_in.dart';

import '../../main.dart';
import 'utils.dart';

class SingUpPage extends StatefulWidget {
  final Function() onClickedSignUp;

  const SingUpPage({
    super.key,
    required this.onClickedSignUp,
  });

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  File? imageFile;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Serwis rowerowy',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Zarejestruj',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              GestureDetector(
                onTap: _getFromGallery,
                child: userAvatar(),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
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
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nazwa uzytkownika',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (username) =>
                      username != null && username.length < 4
                          ? 'Wprowadz nazwe uzytkownika'
                          : null,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Hasło',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Wprowadz minimum 6 znaków'
                      : null,
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  onPressed: nativSignUp,
                  child: const Text('Zarejetruj'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Masz już konto?'),
                  TextButton(
                    onPressed: widget.onClickedSignUp,
                    child: const Text(
                      'Zaloguj się',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  maximumSize: const Size(double.infinity, 50),
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                label: const Text('Zaloguj się za pomocą Google'),
              )
            ],
          ),
        ),
      ),
    );
  }

  UnconstrainedBox userAvatar() {
    return UnconstrainedBox(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black45,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          children: [
            imageFile == null
                ? const Opacity(
                    opacity: 0.25,
                    child: Image(
                      image: AssetImage('images/rower1.png'),
                    ),
                  )
                : Opacity(
                    opacity: 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Image.file(
                        imageFile!,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
            const Center(
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
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
          .ref('avatar/${usernameController.text}.$typeOfFile')
          .putFile(imageFile!);
    } on FirebaseStorage catch (e) {
      print(e);
    }
    return downloadUrl(storage, typeOfFile);
  }

  Future<String> downloadUrl(FirebaseStorage storage, String typeOfFile) {
    Future<String> downloadUrl = storage
        .ref('avatar/${usernameController.text}.$typeOfFile')
        .getDownloadURL();
    return downloadUrl;
  }

  Future nativSignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aby założyć konto musisz dodać avatar!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    String urlImage = await uploadFile();

    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      var user = result.user!;
      user.updatePhotoURL(urlImage);
      user.updateDisplayName(usernameController.text);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(usernameController.text)
        .set({
      'username': usernameController.text,
      'email': emailController.text,
      'image_url': urlImage,
      'favorites': [],
    });

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
