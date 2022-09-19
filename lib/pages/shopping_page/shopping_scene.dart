import 'package:flutter/material.dart';

import 'package:sklep_rowerowy/pages/product_details/widgets/shopping_model.dart';
import 'package:sklep_rowerowy/pages/shopping_page/widgets/my_drawer.dart';
import 'package:sklep_rowerowy/pages/shopping_page/widgets/shopping_card.dart';
import 'package:sklep_rowerowy/style/colors.dart';

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
    "Crossowe",
    "Trekkingowe"
  ];
  List<ShoppingModel> products = [
    ShoppingModel("Power", "Górski", 6083.00,
        const AssetImage("images/rower3.jpg"), "Model", "Rodzaj"),
    ShoppingModel("Lower", "Miejski", 12299.99,
        const AssetImage("images/rower2.jpg"), "Tani", "Wytrzymały"),
    ShoppingModel("Rower", "BMX", 199.99, const AssetImage("images/rower5.png"),
        "Wygodny", "Sportowy"),
    ShoppingModel("Rower", "Crossowe", 349.99,
        const AssetImage("images/rower6.jpg"), "Nowoczesny", "Popularny"),
    ShoppingModel("Rower", "Górski", 16499.99,
        const AssetImage("images/rower1.png"), "Szybki", "Mocny"),
    ShoppingModel("Rower", "Trekkingowe", 249.99,
        const AssetImage("images/rower4.jpg"), "Tani", "Dobry"),
  ];
  int selectedCategories = 0;
  String searchedProduct = "";

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Znajdź rower",
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
            backgroundColor: AppStandardsColors.backgroundColor,
            elevation: 0,
          ),
          drawer: const MyDrawer(),
          body: Container(
            color: AppStandardsColors.backgroundColor,
            child: Column(
              children: <Widget>[
                Padding(
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
                        borderSide: const BorderSide(
                            color: AppStandardsColors.highlightColor),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppStandardsColors.highlightColor),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppStandardsColors.highlightColor),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      hintText: "Wyszukaj",
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      prefixIcon: const Icon(Icons.search,
                          color: Colors.white, size: 28),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return index == selectedCategories
                              ? selectedCategoryCard(categories[index])
                              : unselectedCategoryCard(
                                  categories[index], index);
                        }),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 4,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(26),
                                topRight: Radius.circular(26),
                              )),
                            ),
                          ),
                        ],
                      ),
                      ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                height: getDividerHeight(index),
                                color: Colors.transparent,
                              ),
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                          itemCount: products.length,
                          itemBuilder: (context, index) =>
                              getProductCard(index))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

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

  Widget getProductCard(int index) {
    //THIS IS THE SPAGHETTIEST CODE I VE WRITTEN IN YEARS OH DEAR GOD
    if (selectedCategories != 0) {
      if (products[index].tag == categories[selectedCategories]) {
        if (searchedProduct == "") {
          return ShoppingCard(products[index]);
        } else {
          if (products[index]
              .title
              .toLowerCase()
              .contains(searchedProduct.toLowerCase())) {
            return ShoppingCard(products[index]);
          } else {
            return const SizedBox();
          }
        }
      } else {
        return const SizedBox();
      }
    } else {
      if (searchedProduct == "") {
        return ShoppingCard(products[index]);
      } else {
        if (products[index]
            .title
            .toLowerCase()
            .contains(searchedProduct.toLowerCase())) {
          return ShoppingCard(products[index]);
        } else {
          return const SizedBox();
        }
      }
    }
  }

  double getDividerHeight(int index) {
    if (selectedCategories == 0) {
      return 5;
    } else {
      if (products[index].tag == categories[selectedCategories]) {
        return 5;
      } else {
        return 0;
      }
    }
  }
}
