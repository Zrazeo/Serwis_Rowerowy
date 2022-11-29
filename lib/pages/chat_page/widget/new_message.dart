// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class NewMessage extends StatefulWidget {
  const NewMessage(
      {super.key, required this.idConversation, required this.controller});

  final String idConversation;
  final ScrollController controller;
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';
  File? imageFile;
  String uid = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    void _sendMessage(String enteredMessage) async {
      final user = FirebaseAuth.instance.currentUser;

      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.displayName)
          .get();
      FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.idConversation)
          .collection('message')
          .add({
        'message': enteredMessage,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'username': (userData.data() as Map)['username'],
      });

      Timer(
        const Duration(milliseconds: 100),
        () => widget.controller
            .jumpTo(widget.controller.position.maxScrollExtent),
      );

      FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.idConversation)
          .update({
        'lastModified': DateTime.now().millisecondsSinceEpoch,
        'lastMessage': enteredMessage,
      });
      _controller.clear();
      enteredMessage = '';
    }

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (isKeyboardVisible) {
          Timer(
            const Duration(milliseconds: 20),
            () => widget.controller
                .jumpTo(widget.controller.position.maxScrollExtent),
          );
        }
        return Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  await _getFromGallery();
                  String urlImage = await uploadFile();
                  _sendMessage(urlImage);
                },
                icon: const Icon(Icons.image_outlined),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  // width: MediaQuery.of(context).size.width * 0.83,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 1,
                    autocorrect: true,
                    enableSuggestions: true,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                      filled: false,
                      border: InputBorder.none,
                      hintText: 'Aa',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _enteredMessage = value;
                      });
                    },
                  ),
                ),
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.send),
                onPressed: _enteredMessage.trim().isEmpty
                    ? null
                    : () => _sendMessage(_enteredMessage),
              ),
            ],
          ),
        );
      },
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
      await storage.ref('chat/$uid').putFile(imageFile!);
    } on FirebaseStorage catch (e) {
      print(e);
    }
    return downloadUrl(storage, typeOfFile);
  }

  Future<String> downloadUrl(FirebaseStorage storage, String typeOfFile) {
    Future<String> downloadUrl = storage.ref('chat/$uid').getDownloadURL();
    uid = const Uuid().v4();
    return downloadUrl;
  }
}
