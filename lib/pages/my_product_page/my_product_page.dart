import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sklep_rowerowy/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'widget/my_bikes_details.dart';
import 'widget/my_parts_details.dart';

class MyBikesPage extends StatefulWidget {
  const MyBikesPage({Key? key}) : super(key: key);

  @override
  MyBikesPageState createState() => MyBikesPageState();
}

class MyBikesPageState extends State<MyBikesPage> {
  CollectionReference bikes = FirebaseFirestore.instance.collection('bike');
  CollectionReference parts = FirebaseFirestore.instance.collection('parts');
  final thisUser = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Moje ogłoszenia",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          backgroundColor: AppStandardsColors.backgroundColor,
          elevation: 0,
          bottom: const TabBar(tabs: [
            Tab(text: 'Rowery'),
            Tab(text: 'Części'),
          ]),
        ),
        body: TabBarView(
          children: [
            Container(
              color: AppStandardsColors.backgroundColor,
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: bikes.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            if (doc['owner'] == thisUser) {
                              return getProductCard(
                                id,
                                doc['model'],
                                doc['brand'],
                                doc['owner'],
                                doc['price'],
                                doc['picture'],
                                doc['type'],
                                doc['brakes'],
                                doc['color'],
                                doc['description'],
                                doc['frontShockAbsorber'],
                                doc['numberOfGears'],
                                doc['rearDerailleur'],
                                doc['shockAbsorber'],
                                doc['sizeOfFrame'],
                                doc['typeMaleFemale'],
                                doc['typeOfFrame'],
                                doc['weight'],
                                doc['wheelSize'],
                              );
                            }
                            return const SizedBox.shrink();
                          }).toList());
                        }),
                  ),
                ],
              ),
            ),
            Container(
              color: AppStandardsColors.backgroundColor,
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: parts.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            if (doc['owner'] == thisUser) {
                              return getMyPartsDetails(
                                id,
                                doc['name'],
                                doc['brand'],
                                doc['description'],
                                doc['price'],
                                doc['picture'],
                                doc['owner'],
                              );
                            }
                            return const SizedBox.shrink();
                          }).toList());
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getProductCard(
    String index,
    String model,
    String brand,
    String owner,
    String price,
    String picture,
    String type,
    String brakes,
    String color,
    String description,
    String frontShockAbsorber,
    String numberOfGears,
    String rearDerailleur,
    String shockAbsorber,
    String sizeOfFrame,
    String typeMaleFemale,
    String typeOfFrame,
    String weight,
    String wheelSize,
  ) {
    return MyBikesDetails(
      id: index,
      model: model,
      brand: brand,
      owner: owner,
      price: price,
      picture: picture,
      type: type,
      brakes: brakes,
      color: color,
      description: description,
      frontShockAbsorber: frontShockAbsorber,
      numberOfGears: numberOfGears,
      rearDerailleur: rearDerailleur,
      shockAbsorber: shockAbsorber,
      sizeOfFrame: sizeOfFrame,
      typeMaleFemale: typeMaleFemale,
      typeOfFrame: typeOfFrame,
      weight: weight,
      wheelSize: wheelSize,
    );
  }

  Widget getMyPartsDetails(
    String index,
    String name,
    String brand,
    String description,
    String price,
    String picture,
    String owner,
  ) {
    return MyPartsDetails(
      id: index,
      name: name,
      brand: brand,
      description: description,
      price: price,
      picture: picture,
      owner: owner,
    );
  }
}
