import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/style/colors.dart';

class FavoritesProduct extends StatefulWidget {
  FavoritesProduct({Key? key}) : super(key: key);

  @override
  State<FavoritesProduct> createState() => _FavoritesProductState();
}

class _FavoritesProductState extends State<FavoritesProduct> {
  CollectionReference bikes = FirebaseFirestore.instance.collection('bike');
  final thisUser = FirebaseAuth.instance.currentUser!.displayName;

  List? favorite;

  getUserFavorite() async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(thisUser)
        .get();
    setState(() {
      favorite = user.data()!['favorite'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserFavorite();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStandardsColors.backgroundColor,
          centerTitle: true,
          title: const Text(
            "Ulubione",
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: bikes.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              var doc = document.data() as Map;
              print('favorite-----');
              print(favorite);
              print('doc.favorite-----');
              print(doc['favorite']);
              // if (favorite.contains(doc['favorite'])) {

              // }
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(3, 4))
                  ],
                ),
                child: ListTile(
                  leading: Image.network(
                    doc['picture'],
                    fit: BoxFit.cover,
                    width: 90,
                    height: 100,
                  ),
                  title: Text(
                    doc['model'],
                    style: const TextStyle(fontSize: 25),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${doc['price']} zł"),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            }).toList());
          },
        ),
      );
}
