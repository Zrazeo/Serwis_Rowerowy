import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ThisUser {
  late String urlAvatar;

  Future<String> getFileData(String path, String username) async {
    final user = FirebaseAuth.instance.currentUser!.displayName;
    if (username.isEmpty) {
      username = user ?? '';
    }

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .get();

    urlAvatar = (userData.data() as Map)['image_url'];
    return await Future(() => urlAvatar);
  }

  Future<String> getTextFromFile(String username) async {
    return getFileData('test.txt', username);
  }
}
