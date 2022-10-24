import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sklep_rowerowy/pages/chat_page/chat_page.dart';
// import 'package:sklep_rowerowy/style/colors.dart';

// class ProductDetailsPage extends StatefulWidget {
//   final String id;
//   final String owner;
//   final String picture;
//   final String price;
//   final String rearDereilleur;
//   final String shockAbsorber;
//   final String sizeOfFrame;
//   final String type;
//   final String typeMaleFemale;
//   final String typeOfFrame;
//   final String weight;
//   final String wheelSize;
//   final String brakes;
//   final String brand;
//   final String color;
//   final String description;
//   final String frontShockAbsorber;
//   final String model;
//   final String numberOfGrears;

//   const ProductDetailsPage({
//     Key? key,
//     required this.owner,
//     required this.picture,
//     required this.price,
//     required this.rearDereilleur,
//     required this.shockAbsorber,
//     required this.sizeOfFrame,
//     required this.type,
//     required this.typeMaleFemale,
//     required this.typeOfFrame,
//     required this.weight,
//     required this.wheelSize,
//     required this.brakes,
//     required this.brand,
//     required this.color,
//     required this.description,
//     required this.frontShockAbsorber,
//     required this.model,
//     required this.numberOfGrears,
//     required this.id,
//   }) : super(key: key);

//   @override
//   ProductDetailsPageState createState() => ProductDetailsPageState();
// }

// class ProductDetailsPageState extends State<ProductDetailsPage> {
//   final thisUser = FirebaseAuth.instance.currentUser!.displayName;
//   final sellerUser = 'arek';
//   List? favorite;
//   bool isFavorite = false;

//   getUserFavorite() async {
//     var user = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(thisUser)
//         .get();
//     favorite = user.data()!['favorite'];
//     setState(() {
//       isFavorite = favorite!.contains(widget.id);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUserFavorite();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         backgroundColor: AppStandardsColors.accentColor,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: AppStandardsColors.accentColor,
//           actions: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: IconButton(
//                 icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
//                 color: Colors.white,
//                 onPressed: () async {
//                   setState(() {
//                     isFavorite = !isFavorite;
//                   });
//                   favorite = favorite ?? [];
//                   if (isFavorite) {
//                     favorite!.add(widget.id);
//                   } else {
//                     favorite!.removeWhere((element) => element == widget.id);
//                   }
//                   FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(thisUser)
//                       .update({'favorite': favorite});
//                 },
//               ),
//             ),
//           ],
//         ),
//         body: SizedBox(
//           // color: AppStandardsColors.accentColor,
//           height: 600,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(80, 0, 80, 20),
//                   child: Image.network(
//                     widget.picture,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
//                   child: Text(
//                     "Specyfikacje",
//                     style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: AppStandardsColors.unselectedColor,
//                         letterSpacing: 2),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
//                   child: Text(
//                     "${widget.brand}\n${widget.model}\n${widget.type}\n${widget.color}\n${widget.weight}\n${widget.wheelSize}\n${widget.typeMaleFemale}\n${widget.typeOfFrame}\n${widget.sizeOfFrame}\n${widget.brakes}\n${widget.shockAbsorber}\n${widget.rearDereilleur}\n${widget.frontShockAbsorber}\n${widget.numberOfGrears}",
//                     softWrap: true,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
//                   child: Text(
//                     "Opis",
//                     style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: AppStandardsColors.unselectedColor,
//                         letterSpacing: 2),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
//                   child: Text(
//                     widget.description,
//                     softWrap: true,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ),
//                 // Expanded(
//                 //     flex: 1,
//                 //     child: Padding(
//                 //       padding: const EdgeInsets.all(12),
//                 //       child: Image.network(
//                 //         widget.picture,
//                 //         fit: BoxFit.contain,
//                 //       ),
//                 //     )),
//                 // Expanded(
//                 //     flex: 2,
//                 //     child: Stack(
//                 //       children: <Widget>[
//                 //         Column(
//                 //           crossAxisAlignment: CrossAxisAlignment.stretch,
//                 //           mainAxisAlignment: MainAxisAlignment.center,
//                 //           children: const <Widget>[
//                 //             Expanded(
//                 //               flex: 1,
//                 //               child: SizedBox(),
//                 //             ),
//                 //             // Expanded(
//                 //             //   flex: 5,
//                 //             //   child: Card(
//                 //             //     color: Colors.white,
//                 //             //     shape: RoundedRectangleBorder(
//                 //             //         borderRadius: BorderRadius.only(
//                 //             //       topLeft: Radius.circular(26),
//                 //             //       topRight: Radius.circular(26),
//                 //             //     )),
//                 //             //   ),
//                 //             // ),
//                 //           ],
//                 //         ),
//                 //         Column(
//                 //           mainAxisAlignment: MainAxisAlignment.center,
//                 //           crossAxisAlignment: CrossAxisAlignment.stretch,
//                 //           children: <Widget>[
//                 //             // Expanded(
//                 //             //   child: Card(
//                 //             //     color: Colors.white,
//                 //             //     elevation: 10,
//                 //             //     shape: RoundedRectangleBorder(
//                 //             //         borderRadius: BorderRadius.circular(26)),
//                 //             //     margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
//                 //             //     child: Padding(
//                 //             //       padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                 //             //       child: Row(
//                 //             //         children: <Widget>[
//                 //             //           Expanded(
//                 //             //             child: Padding(
//                 //             //               padding: const EdgeInsets.all(12),
//                 //             //               child: Image.network(
//                 //             //                 widget.picture,
//                 //             //                 fit: BoxFit.contain,
//                 //             //               ),
//                 //             //             ),
//                 //             //           ),
//                 //             //           Expanded(
//                 //             //             child: Padding(
//                 //             //               padding: const EdgeInsets.all(12),
//                 //             //               child: Image.network(
//                 //             //                 widget.picture,
//                 //             //                 fit: BoxFit.contain,
//                 //             //               ),
//                 //             //             ),
//                 //             //           ),
//                 //             //           Expanded(
//                 //             //             child: Padding(
//                 //             //               padding: const EdgeInsets.all(12),
//                 //             //               child: Image.network(
//                 //             //                 widget.picture,
//                 //             //                 fit: BoxFit.contain,
//                 //             //               ),
//                 //             //             ),
//                 //             //           ),
//                 //             //         ],
//                 //             //       ),
//                 //             //     ),
//                 //             //   ),
//                 //             // ),
//                 //             SingleChildScrollView(
//                 //               child: Expanded(
//                 //                 child: Padding(
//                 //                   padding:
//                 //                       const EdgeInsets.fromLTRB(16, 6, 10, 0),
//                 //                   child: Column(
//                 //                     crossAxisAlignment: CrossAxisAlignment.start,
//                 //                     children: <Widget>[
//                 //                       const Text(
//                 //                         "Specyfikacje",
//                 //                         style: TextStyle(
//                 //                             fontSize: 22,
//                 //                             fontWeight: FontWeight.bold,
//                 //                             color: AppStandardsColors
//                 //                                 .unselectedColor,
//                 //                             letterSpacing: 2),
//                 //                       ),
//                 //                       Padding(
//                 //                         padding:
//                 //                             const EdgeInsets.fromLTRB(0, 8, 8, 8),
//                 //                         child: Text(
//                 //                           "${widget.brand}\n${widget.model}\n${widget.type}\n${widget.color}\n${widget.weight}\n${widget.wheelSize}\n${widget.typeMaleFemale}\n${widget.typeOfFrame}\n${widget.sizeOfFrame}\n${widget.brakes}\n${widget.shockAbsorber}\n${widget.rearDereilleur}\n${widget.frontShockAbsorber}\n${widget.numberOfGrears}",
//                 //                           softWrap: true,
//                 //                           style: const TextStyle(fontSize: 18),
//                 //                         ),
//                 //                       ),
//                 //                       const Text(
//                 //                         "Opis",
//                 //                         style: TextStyle(
//                 //                             fontSize: 22,
//                 //                             fontWeight: FontWeight.bold,
//                 //                             color: AppStandardsColors
//                 //                                 .unselectedColor,
//                 //                             letterSpacing: 2),
//                 //                       ),
//                 //                       Padding(
//                 //                         padding:
//                 //                             const EdgeInsets.fromLTRB(0, 8, 8, 8),
//                 //                         child: Text(
//                 //                           "${widget.description}\n${widget.brand}",
//                 //                           softWrap: true,
//                 //                           style: const TextStyle(fontSize: 18),
//                 //                         ),
//                 //                       ),
//                 //                     ],
//                 //                   ),
//                 //                 ),
//                 //               ),
//                 //             ),
//                 //             // Expanded(
//                 //             //   child: Card(
//                 //             //     color: AppStandardsColors.backgroundColor,
//                 //             //     shape: const RoundedRectangleBorder(
//                 //             //         borderRadius: BorderRadius.only(
//                 //             //       topLeft: Radius.circular(26),
//                 //             //       topRight: Radius.circular(26),
//                 //             //     )),
//                 //             //     child: Padding(
//                 //             //       padding:
//                 //             //           const EdgeInsets.only(left: 36, right: 32),
//                 //             //       child: Row(
//                 //             //         mainAxisAlignment:
//                 //             //             MainAxisAlignment.spaceBetween,
//                 //             //         children: <Widget>[
//                 //             //           Text(
//                 //             //             "${widget.price} zł",
//                 //             //             style: const TextStyle(
//                 //             //                 color: Colors.white, fontSize: 15),
//                 //             //           ),
//                 //             //           ElevatedButton(
//                 //             //             style: ElevatedButton.styleFrom(
//                 //             //               backgroundColor:
//                 //             //                   AppStandardsColors.unselectedColor,
//                 //             //               padding: const EdgeInsets.fromLTRB(
//                 //             //                   62, 16, 62, 16),
//                 //             //               shape: RoundedRectangleBorder(
//                 //             //                 borderRadius:
//                 //             //                     BorderRadius.circular(16),
//                 //             //               ),
//                 //             //             ),
//                 //             //             onPressed: onPressed,
//                 //             //             child: const Text(
//                 //             //               "Skontaktuj się",
//                 //             //               style: TextStyle(
//                 //             //                   color: Colors.white,
//                 //             //                   fontWeight: FontWeight.bold,
//                 //             //                   fontSize: 15),
//                 //             //             ),
//                 //             //           ),
//                 //             //         ],
//                 //             //       ),
//                 //             //     ),
//                 //             //   ),
//                 //             // ),
//                 //           ],
//                 //         ),
//                 //       ],
//                 //     ))
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           focusColor: Colors.green,
//           onPressed: onPressed,
//           label: const Text('Skontaktuj się ze sprzedawcą'),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       );

// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sklep_rowerowy/pages/chat_page/chat_page.dart';

import '../../style/colors.dart';

class ProductDetailPage extends StatefulWidget {
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

  const ProductDetailPage(
      {Key? key,
      required this.id,
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
      required this.numberOfGrears})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late String sellerUser;

  final thisUser = FirebaseAuth.instance.currentUser!.displayName;

  @override
  void initState() {
    super.initState();
    sellerUser = widget.owner;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;
  Widget _appBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          _icon(isLiked ? Icons.favorite : Icons.favorite_border,
              color:
                  isLiked ? const Color(0xffF72804) : const Color(0xffE1E2E4),
              size: 30,
              isOutLine: false, onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          }),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = const Color.fromARGB(255, 178, 93, 40),
    double size = 20,
    // double padding = 10,
    bool isOutLine = false,
    Function? onPressed,
  }) {
    return SizedBox(
      height: 40,
      width: 40,
      // padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //       color: const Color(0xffa8a09b),
      //       style: isOutLine ? BorderStyle.solid : BorderStyle.none),
      //   borderRadius: const BorderRadius.all(Radius.circular(13)),
      //   color:
      //       isOutLine ? Colors.transparent : AppStandardsColors.backgroundColor,
      //   // boxShadow: const <BoxShadow>[
      //   //   BoxShadow(
      //   //       color: Color(0xfff8f8f8),
      //   //       blurRadius: 5,
      //   //       spreadRadius: 10,
      //   //       offset: Offset(5, 5)),
      //   // ],
      // ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // const TitleText(
          //   text: "AIP",
          //   fontSize: 160,
          //   color: Color(0xffE1E2E4),
          // ),
          Image.network(
            widget.picture,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // Widget _thumbnail(String image) {
  //   return AnimatedBuilder(
  //     animation: animation,
  //     //  builder: null,
  //     builder: (context, child) => AnimatedOpacity(
  //       opacity: animation.value,
  //       duration: const Duration(milliseconds: 500),
  //       child: child,
  //     ),
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 10),
  //       child: Container(
  //         height: 40,
  //         width: 50,
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             color: const Color(0xffE1E2E4),
  //           ),
  //           borderRadius: const BorderRadius.all(Radius.circular(13)),
  //           // color: Theme.of(context).backgroundColor,
  //         ),
  //         child: Image.asset(image),
  //       ).ripple(() {},
  //           borderRadius: const BorderRadius.all(Radius.circular(13))),
  //     ),
  //   );
  // }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Color(0xffa8a09b),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          TitleText(
                            text: widget.brand,
                            fontSize: 25,
                            key: null,
                          ),
                          TitleText(
                            text: widget.model,
                            fontSize: 25,
                            key: null,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "${widget.price} zł",
                                fontSize: 25,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _description("Krótki opis", widget.description),
                _description("Typ roweru", widget.type),
                _description("Rodzaj i rozmiar ramy",
                    "${widget.typeMaleFemale} ${widget.typeOfFrame} ${widget.sizeOfFrame}"),
                _description("Waga", widget.weight),
                _description("Rozmiar koła", widget.wheelSize),
                _description("Przerzutki i ich liczba",
                    "${widget.rearDereilleur} ${widget.numberOfGrears}"),
                _description("Hamulce", widget.brakes),
                _description("Amortyzatory przedni i tylni",
                    "${widget.frontShockAbsorber} ${widget.shockAbsorber}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _description(String text, String asset) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          TitleText(
            text: text,
            fontSize: 14,
          ),
          const SizedBox(height: 10),
          Text(asset),
        ],
      ),
    );
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppStandardsColors.backgroundColor,
      child: Icon(Icons.shopping_basket,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _flotingButton(),
      backgroundColor: AppStandardsColors.backgroundColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(124, 154, 154, 1),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }

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

extension OnPressed on Widget {
  Widget ripple(Function onPressed,
          {BorderRadiusGeometry borderRadius =
              const BorderRadius.all(Radius.circular(5))}) =>
      Stack(
        children: <Widget>[
          this,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: borderRadius),
                )),
                onPressed: () {
                  onPressed();
                },
                child: Container()),
          )
        ],
      );
}

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const TitleText(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.color = const Color(0xff1d2635),
      this.fontWeight = FontWeight.w800})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.mulish(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
