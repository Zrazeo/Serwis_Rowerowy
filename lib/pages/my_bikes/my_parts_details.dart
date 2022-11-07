import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sklep_rowerowy/style/colors.dart';

import '../parts_details/patrts_details.dart';

class MyPartsDetails extends StatelessWidget {
  final String id;
  final String owner;
  final String picture;
  final String price;
  final String brand;
  final String name;
  final String description;

  const MyPartsDetails({
    Key? key,
    required this.name,
    required this.id,
    required this.owner,
    required this.picture,
    required this.price,
    required this.brand,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => PartsDetailPage(
                id: id,
                brand: brand,
                description: description,
                name: name,
                owner: owner,
                picture: picture,
                price: price,
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
                            name,
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
                            brand,
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
                  IconButton(
                    onPressed: (() async => await FirebaseFirestore.instance
                        .collection('parts')
                        .doc(id)
                        .delete()),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
