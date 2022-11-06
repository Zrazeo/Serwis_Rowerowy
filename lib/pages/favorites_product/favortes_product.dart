import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/shopping_page/widgets/shopping_card.dart';
import 'package:sklep_rowerowy/style/colors.dart';

class FavoritesProduct extends StatefulWidget {
  const FavoritesProduct({Key? key}) : super(key: key);

  @override
  State<FavoritesProduct> createState() => _FavoritesProductState();
}

class _FavoritesProductState extends State<FavoritesProduct> {
  CollectionReference bikes = FirebaseFirestore.instance.collection('bike');
  final thisUser = FirebaseAuth.instance.currentUser!.displayName;
  int selectedCategories = 0;
  String searchedProduct = "";
  List<String> categories = [
    "Wszystkie",
    "Górski",
    "Miejski",
    "BMX",
    "Cross",
    "Treking"
  ];

  List? favorite;

  getUserFavorite() async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(thisUser)
        .get();
    setState(() {
      favorite = user.data()!['favorites'];
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
          centerTitle: true,
          title: const Text(
            "Ulubione",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          backgroundColor: AppStandardsColors.backgroundColor,
          elevation: 0,
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
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                var doc = document.data() as Map;
                String id = document.id;
                favorite = favorite ?? [];
                return favorite!.contains(id)
                    ? getProductCard(
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
                      )
                    : const SizedBox.shrink();
              }).toList());
            }),
      );

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
    String numberOfGrears,
    String rearDereilleur,
    String shockAbsorber,
    String sizeOfFrame,
    String typeMaleFemale,
    String typeOfFrame,
    String weight,
    String wheelSize,
  ) {
    if (selectedCategories != 0) {
      if (type == categories[selectedCategories]) {
        if (searchedProduct == "") {
          return ShoppingCard(
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
            numberOfGrears: numberOfGrears,
            rearDereilleur: rearDereilleur,
            shockAbsorber: shockAbsorber,
            sizeOfFrame: sizeOfFrame,
            typeMaleFemale: typeMaleFemale,
            typeOfFrame: typeOfFrame,
            weight: weight,
            wheelSize: wheelSize,
          );
        } else {
          if (model.toLowerCase().contains(searchedProduct.toLowerCase())) {
            return ShoppingCard(
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
              numberOfGrears: numberOfGrears,
              rearDereilleur: rearDereilleur,
              shockAbsorber: shockAbsorber,
              sizeOfFrame: sizeOfFrame,
              typeMaleFemale: typeMaleFemale,
              typeOfFrame: typeOfFrame,
              weight: weight,
              wheelSize: wheelSize,
            );
          } else {
            return const SizedBox();
          }
        }
      } else {
        return const SizedBox();
      }
    } else {
      if (searchedProduct == "") {
        return ShoppingCard(
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
          numberOfGrears: numberOfGrears,
          rearDereilleur: rearDereilleur,
          shockAbsorber: shockAbsorber,
          sizeOfFrame: sizeOfFrame,
          typeMaleFemale: typeMaleFemale,
          typeOfFrame: typeOfFrame,
          weight: weight,
          wheelSize: wheelSize,
        );
      } else {
        if (model.toLowerCase().contains(searchedProduct.toLowerCase())) {
          return ShoppingCard(
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
            numberOfGrears: numberOfGrears,
            rearDereilleur: rearDereilleur,
            shockAbsorber: shockAbsorber,
            sizeOfFrame: sizeOfFrame,
            typeMaleFemale: typeMaleFemale,
            typeOfFrame: typeOfFrame,
            weight: weight,
            wheelSize: wheelSize,
          );
        } else {
          return const SizedBox();
        }
      }
    }
  }
}
