import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/chat_page/widget/message_bubble.dart';
import 'package:sklep_rowerowy/pages/chat_page/widget/new_message.dart';
import 'package:sklep_rowerowy/this_user.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.idConversation,
  }) : super(key: key);

  final String idConversation;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final thisUser = FirebaseAuth.instance.currentUser;

  final ScrollController _controller = ScrollController();

  late String urlUserAvatar;

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(milliseconds: 100),
      () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );
    var allMessage = FirebaseFirestore.instance
        .collection('messages')
        .doc(widget.idConversation)
        .collection('message')
        .orderBy('createdAt');
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            FutureBuilder(
              future: ThisUser().getTextFromFile(
                  thisUser!.displayName == widget.idConversation.split('_')[1]
                      ? widget.idConversation.split('_')[0]
                      : widget.idConversation.split('_')[1]),
              initialData: "https://i.stack.imgur.com/l60Hf.png",
              builder: (BuildContext context, AsyncSnapshot<String> text) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(text.data ?? ''),
                    ));
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text(thisUser!.displayName == widget.idConversation.split('_')[1]
                ? widget.idConversation.split('_')[0]
                : widget.idConversation.split('_')[1]),
          ],
        )),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: allMessage.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Coś poszło nie tak');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    int previousTimestamp = 0;
                    var tmp = DateTime.now().millisecondsSinceEpoch;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                        controller: _controller,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          var doc = document.data() as Map;
                          previousTimestamp = previousTimestamp == 0
                              ? doc['createdAt'] - 100000000000
                              : tmp;
                          tmp = (document.data() as Map)['createdAt'];
                          return MessageBubble(
                            message: doc['message'],
                            username: doc['username'],
                            timestamp: doc['createdAt'],
                            previousTimestamp: previousTimestamp,
                            isMe: doc['username'] == thisUser!.displayName,
                            // key: ValueKey(document.id),
                          );
                        }).toList(),
                      ),
                    );
                  }),
            ),
            NewMessage(
                idConversation: widget.idConversation, controller: _controller),
          ],
        ));
  }
}
