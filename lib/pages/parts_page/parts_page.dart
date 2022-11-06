import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sklep_rowerowy/pages/shopping_page/widgets/my_drawer.dart';
import 'package:sklep_rowerowy/pages/shopping_page/widgets/shopping_card.dart';
import 'package:sklep_rowerowy/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'parts_details_page.dart';

class PartsScene extends StatefulWidget {
  const PartsScene({Key? key}) : super(key: key);

  @override
  PartsSceneState createState() => PartsSceneState();
}

class PartsSceneState extends State<PartsScene> {
  String searchedProduct = "";
  CollectionReference parts = FirebaseFirestore.instance.collection('parts');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Znajdź część",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          backgroundColor: AppStandardsColors.backgroundColor,
          elevation: 0,
        ),
        drawer: const MyDrawer(),
        body: Container(
          color: AppStandardsColors.backgroundColor,
          child: Column(
            children: [
              searchWidget(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: parts.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                        var doc = document.data() as Map;
                        String id = document.id;
                        return getProductCard(
                            id,
                            doc['name'],
                            doc['brand'],
                            doc['description'],
                            doc['price'],
                            doc['picture'],
                            doc['owner']);
                        // 'price', 'brand', 'model','owner', 'picture',
                      }).toList());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding searchWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: TextField(
        autofocus: false,
        onChanged: (text) {
          searchedProduct = text;
          setState(() {});
        },
        style: const TextStyle(color: Colors.white, fontSize: 20),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          fillColor: AppStandardsColors.highlightColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppStandardsColors.highlightColor),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppStandardsColors.highlightColor),
            borderRadius: BorderRadius.circular(18),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                const BorderSide(color: AppStandardsColors.highlightColor),
            borderRadius: BorderRadius.circular(18),
          ),
          hintText: "Wyszukaj",
          hintStyle: const TextStyle(color: Colors.white, fontSize: 20),
          prefixIcon: const Icon(Icons.search, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget getProductCard(
    String index,
    String name,
    String brand,
    String description,
    String price,
    String picture,
    String owner,
  ) {
    if (searchedProduct == "") {
      return PartsCard(
        id: index,
        name: name,
        brand: brand,
        description: description,
        price: price,
        picture: picture,
        owner: owner,
      );
    } else {
      if (name.toLowerCase().contains(searchedProduct.toLowerCase())) {
        return PartsCard(
          id: index,
          name: name,
          brand: brand,
          description: description,
          price: price,
          picture: picture,
          owner: owner,
        );
      } else {
        return const SizedBox();
      }
    }
  }
}
