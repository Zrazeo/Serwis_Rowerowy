import 'package:flutter/material.dart';

import 'package:sklep_rowerowy/widget/my_drawer.dart';
import 'package:sklep_rowerowy/pages/bike_page/widgets/bike_card.dart';
import 'package:sklep_rowerowy/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingScene extends StatefulWidget {
  const ShoppingScene({Key? key}) : super(key: key);

  @override
  ShoppingSceneState createState() => ShoppingSceneState();
}

class ShoppingSceneState extends State<ShoppingScene> {
  List<String> categories = [
    "Wszystkie",
    "Górski",
    "Miejski",
    "BMX",
    "Cross",
    "Treking"
  ];

  int selectedCategories = 0;
  String searchedProduct = "";
  CollectionReference bikes = FirebaseFirestore.instance.collection('bike');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Znajdź rower",
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
              bikeCategoryChooser(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: bikes.snapshots(),
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
                      }).toList());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding bikeCategoryChooser() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return index == selectedCategories
                  ? selectedCategoryCard(categories[index])
                  : unselectedCategoryCard(categories[index], index);
            }),
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

  Widget selectedCategoryCard(String category) => GestureDetector(
        onTap: () {},
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: AppStandardsColors.highlightColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Center(
              child: Text(
                category,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),
      );

  Widget unselectedCategoryCard(String category, int index) => GestureDetector(
        onTap: () {
          setState(() {
            selectedCategories = index;
          });
        },
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Center(
              child: Text(
                category,
                style: const TextStyle(
                  color: AppStandardsColors.unselectedColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
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
    String numberOfGears,
    String rearDerailleur,
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
            numberOfGears: numberOfGears,
            rearDerailleur: rearDerailleur,
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
              numberOfGears: numberOfGears,
              rearDerailleur: rearDerailleur,
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
          numberOfGears: numberOfGears,
          rearDerailleur: rearDerailleur,
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
            numberOfGears: numberOfGears,
            rearDerailleur: rearDerailleur,
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

  double getDividerHeight(String type) {
    if (selectedCategories == 0) {
      return 5;
    } else {
      if (type == categories[selectedCategories]) {
        return 5;
      } else {
        return 0;
      }
    }
  }
}
