import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sklep_rowerowy/pages/bike_details_page/bike_details_page.dart';

import 'package:sklep_rowerowy/style/colors.dart';

class ShoppingCard extends StatelessWidget {
  final String id;
  final String owner;
  final String picture;
  final String price;
  final String rearDerailleur;
  final String shockAbsorber;
  final String sizeOfFrame;
  final String type;
  final String typeMaleFemale;
  final String typeOfFrame;
  final String weight;
  final String wheelSize;
  final String brakes;
  final String brand;
  final String color;
  final String description;
  final String frontShockAbsorber;
  final String model;
  final String numberOfGears;

  const ShoppingCard({
    Key? key,
    required this.id,
    required this.price,
    required this.model,
    required this.brand,
    required this.owner,
    required this.picture,
    required this.type,
    required this.rearDerailleur,
    required this.shockAbsorber,
    required this.sizeOfFrame,
    required this.typeMaleFemale,
    required this.typeOfFrame,
    required this.weight,
    required this.wheelSize,
    required this.brakes,
    required this.color,
    required this.description,
    required this.frontShockAbsorber,
    required this.numberOfGears,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ProductDetailPage(
                id: id,
                brand: brand,
                brakes: brakes,
                color: color,
                description: description,
                frontShockAbsorber: frontShockAbsorber,
                model: model,
                numberOfGears: numberOfGears,
                owner: owner,
                picture: picture,
                price: price,
                rearDerailleur: rearDerailleur,
                shockAbsorber: shockAbsorber,
                sizeOfFrame: sizeOfFrame,
                type: type,
                typeMaleFemale: typeMaleFemale,
                typeOfFrame: typeOfFrame,
                weight: weight,
                wheelSize: wheelSize,
              ),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Card(
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                color: AppStandardsColors.accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              semanticContainer: true,
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            model,
                            style: const TextStyle(
                              color: AppStandardsColors.textDarkColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            brand,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppStandardsColors.textLightColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            type,
                            style: const TextStyle(
                              color: AppStandardsColors.textLightColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$price zł",
                            style: const TextStyle(
                                color: AppStandardsColors.accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 125,
                          minHeight: 125,
                        ),
                        child: Image.network(
                          picture,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
