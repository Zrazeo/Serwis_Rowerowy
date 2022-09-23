import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/chat_page/chat_page.dart';
import 'package:sklep_rowerowy/pages/product_details/widgets/shopping_model.dart';
import 'package:sklep_rowerowy/pages/shopping_page/widgets/shopping_card.dart';
import 'package:sklep_rowerowy/style/colors.dart';
import 'package:sklep_rowerowy/pages/shopping_page/shopping_scene.dart';

class ProductDetailsPage extends StatefulWidget {
  final String id;
  final String owner;
  final String picture;
  final String price;
  final String rearDereilleur;
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
  final String numberOfGrears;

  const ProductDetailsPage({
    Key? key,
    required this.owner,
    required this.picture,
    required this.price,
    required this.rearDereilleur,
    required this.shockAbsorber,
    required this.sizeOfFrame,
    required this.type,
    required this.typeMaleFemale,
    required this.typeOfFrame,
    required this.weight,
    required this.wheelSize,
    required this.brakes,
    required this.brand,
    required this.color,
    required this.description,
    required this.frontShockAbsorber,
    required this.model,
    required this.numberOfGrears,
    required this.id,
  }) : super(key: key);

  @override
  ProductDetailsPageState createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends State<ProductDetailsPage> {
  final thisUser = FirebaseAuth.instance.currentUser!.displayName;
  final sellerUser = 'arek';
  List? favorite;
  bool isFavorite = false;

  getUserFavorite() async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(thisUser)
        .get();
    favorite = user.data()!['favorite'];
    setState(() {
      isFavorite = favorite!.contains(widget.id);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserFavorite();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppStandardsColors.accentColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStandardsColors.accentColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
                color: Colors.white,
                onPressed: () async {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  favorite = favorite ?? [];
                  if (isFavorite) {
                    favorite!.add(widget.id);
                  } else {
                    favorite!.removeWhere((element) => element == widget.id);
                  }
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(thisUser)
                      .update({'favorite': favorite});
                },
              ),
            ),
          ],
        ),
        body: SizedBox(
          // color: AppStandardsColors.accentColor,
          height: 600,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 0, 80, 20),
                  child: Image.network(
                    widget.picture,
                    fit: BoxFit.contain,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                  child: Text(
                    "Specyfikacje",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppStandardsColors.unselectedColor,
                        letterSpacing: 2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                  child: Text(
                    "${widget.brand}\n${widget.model}\n${widget.type}\n${widget.color}\n${widget.weight}\n${widget.wheelSize}\n${widget.typeMaleFemale}\n${widget.typeOfFrame}\n${widget.sizeOfFrame}\n${widget.brakes}\n${widget.shockAbsorber}\n${widget.rearDereilleur}\n${widget.frontShockAbsorber}\n${widget.numberOfGrears}",
                    softWrap: true,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                  child: Text(
                    "Opis",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppStandardsColors.unselectedColor,
                        letterSpacing: 2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                  child: Text(
                    widget.description,
                    softWrap: true,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                // Expanded(
                //     flex: 1,
                //     child: Padding(
                //       padding: const EdgeInsets.all(12),
                //       child: Image.network(
                //         widget.picture,
                //         fit: BoxFit.contain,
                //       ),
                //     )),
                // Expanded(
                //     flex: 2,
                //     child: Stack(
                //       children: <Widget>[
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.stretch,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: const <Widget>[
                //             Expanded(
                //               flex: 1,
                //               child: SizedBox(),
                //             ),
                //             // Expanded(
                //             //   flex: 5,
                //             //   child: Card(
                //             //     color: Colors.white,
                //             //     shape: RoundedRectangleBorder(
                //             //         borderRadius: BorderRadius.only(
                //             //       topLeft: Radius.circular(26),
                //             //       topRight: Radius.circular(26),
                //             //     )),
                //             //   ),
                //             // ),
                //           ],
                //         ),
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.stretch,
                //           children: <Widget>[
                //             // Expanded(
                //             //   child: Card(
                //             //     color: Colors.white,
                //             //     elevation: 10,
                //             //     shape: RoundedRectangleBorder(
                //             //         borderRadius: BorderRadius.circular(26)),
                //             //     margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                //             //     child: Padding(
                //             //       padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                //             //       child: Row(
                //             //         children: <Widget>[
                //             //           Expanded(
                //             //             child: Padding(
                //             //               padding: const EdgeInsets.all(12),
                //             //               child: Image.network(
                //             //                 widget.picture,
                //             //                 fit: BoxFit.contain,
                //             //               ),
                //             //             ),
                //             //           ),
                //             //           Expanded(
                //             //             child: Padding(
                //             //               padding: const EdgeInsets.all(12),
                //             //               child: Image.network(
                //             //                 widget.picture,
                //             //                 fit: BoxFit.contain,
                //             //               ),
                //             //             ),
                //             //           ),
                //             //           Expanded(
                //             //             child: Padding(
                //             //               padding: const EdgeInsets.all(12),
                //             //               child: Image.network(
                //             //                 widget.picture,
                //             //                 fit: BoxFit.contain,
                //             //               ),
                //             //             ),
                //             //           ),
                //             //         ],
                //             //       ),
                //             //     ),
                //             //   ),
                //             // ),
                //             SingleChildScrollView(
                //               child: Expanded(
                //                 child: Padding(
                //                   padding:
                //                       const EdgeInsets.fromLTRB(16, 6, 10, 0),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: <Widget>[
                //                       const Text(
                //                         "Specyfikacje",
                //                         style: TextStyle(
                //                             fontSize: 22,
                //                             fontWeight: FontWeight.bold,
                //                             color: AppStandardsColors
                //                                 .unselectedColor,
                //                             letterSpacing: 2),
                //                       ),
                //                       Padding(
                //                         padding:
                //                             const EdgeInsets.fromLTRB(0, 8, 8, 8),
                //                         child: Text(
                //                           "${widget.brand}\n${widget.model}\n${widget.type}\n${widget.color}\n${widget.weight}\n${widget.wheelSize}\n${widget.typeMaleFemale}\n${widget.typeOfFrame}\n${widget.sizeOfFrame}\n${widget.brakes}\n${widget.shockAbsorber}\n${widget.rearDereilleur}\n${widget.frontShockAbsorber}\n${widget.numberOfGrears}",
                //                           softWrap: true,
                //                           style: const TextStyle(fontSize: 18),
                //                         ),
                //                       ),
                //                       const Text(
                //                         "Opis",
                //                         style: TextStyle(
                //                             fontSize: 22,
                //                             fontWeight: FontWeight.bold,
                //                             color: AppStandardsColors
                //                                 .unselectedColor,
                //                             letterSpacing: 2),
                //                       ),
                //                       Padding(
                //                         padding:
                //                             const EdgeInsets.fromLTRB(0, 8, 8, 8),
                //                         child: Text(
                //                           "${widget.description}\n${widget.brand}",
                //                           softWrap: true,
                //                           style: const TextStyle(fontSize: 18),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             // Expanded(
                //             //   child: Card(
                //             //     color: AppStandardsColors.backgroundColor,
                //             //     shape: const RoundedRectangleBorder(
                //             //         borderRadius: BorderRadius.only(
                //             //       topLeft: Radius.circular(26),
                //             //       topRight: Radius.circular(26),
                //             //     )),
                //             //     child: Padding(
                //             //       padding:
                //             //           const EdgeInsets.only(left: 36, right: 32),
                //             //       child: Row(
                //             //         mainAxisAlignment:
                //             //             MainAxisAlignment.spaceBetween,
                //             //         children: <Widget>[
                //             //           Text(
                //             //             "${widget.price} zł",
                //             //             style: const TextStyle(
                //             //                 color: Colors.white, fontSize: 15),
                //             //           ),
                //             //           ElevatedButton(
                //             //             style: ElevatedButton.styleFrom(
                //             //               backgroundColor:
                //             //                   AppStandardsColors.unselectedColor,
                //             //               padding: const EdgeInsets.fromLTRB(
                //             //                   62, 16, 62, 16),
                //             //               shape: RoundedRectangleBorder(
                //             //                 borderRadius:
                //             //                     BorderRadius.circular(16),
                //             //               ),
                //             //             ),
                //             //             onPressed: onPressed,
                //             //             child: const Text(
                //             //               "Skontaktuj się",
                //             //               style: TextStyle(
                //             //                   color: Colors.white,
                //             //                   fontWeight: FontWeight.bold,
                //             //                   fontSize: 15),
                //             //             ),
                //             //           ),
                //             //         ],
                //             //       ),
                //             //     ),
                //             //   ),
                //             // ),
                //           ],
                //         ),
                //       ],
                //     ))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          focusColor: Colors.green,
          onPressed: onPressed,
          label: const Text('Skontaktuj się ze sprzedawcą'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  void onPressed() {
    String id = '${thisUser}_$sellerUser';
    FirebaseFirestore.instance.collection('messages').doc(id).set({});

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ChatPage(idConversation: id),
      ),
    );
  }
}
