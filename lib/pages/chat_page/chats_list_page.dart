import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/chat_page/chat_page.dart';

import '../../style/colors.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference users =
        FirebaseFirestore.instance.collection('messages');
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Czat",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: AppStandardsColors.backgroundColor,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Coś poszło nie tak');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              SizedBox(
                height: 500,
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    var doc = document.data() as Map;
                    return Container(
                      child: (user!.displayName == doc['user1'] ||
                                  user.displayName == doc['user2']) &&
                              doc['lastMessage'] != null
                          ? Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    bool user1;
                                    try {
                                      // print(tmp.data()['user1']);
                                      user1 = true;
                                    } catch (_) {
                                      user1 = false;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return ChatPage(
                                            idConversation: (document.data()
                                                        as Map)[
                                                    user1 ? 'user1' : 'user2'] +
                                                '_' +
                                                (document.data() as Map)[
                                                    user1 ? 'user2' : 'user1']);
                                      }),
                                    );
                                  },
                                  child: Container(
                                    color: Colors.white10,
                                    width: mediaQuery.width,
                                    height: mediaQuery.height * 0.1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: mediaQuery.height * 0.02,
                                        ),
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(doc[
                                              doc['user1'] == user.displayName
                                                  ? 'avatar2'
                                                  : 'avatar1']),
                                          maxRadius: 22,
                                          minRadius: 22,
                                        ),
                                        SizedBox(
                                          width: mediaQuery.height * 0.015,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                (user.displayName ==
                                                        doc['user1']
                                                    ? doc['user2']
                                                    : doc['user1']),
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                            Text(doc['lastMessage']
                                                        .replaceAll(
                                                            '\n', '       ')
                                                        .length >
                                                    35
                                                ? doc['lastMessage']
                                                        .replaceAll(
                                                            '\n', '       ')
                                                        .substring(
                                                            0,
                                                            doc['lastMessage']
                                                                        .length <
                                                                    35
                                                                ? doc['lastMessage']
                                                                    .length
                                                                : 35) +
                                                    '...'
                                                : doc['lastMessage'].replaceAll(
                                                    '\n', '       ')),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
