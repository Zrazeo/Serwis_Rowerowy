import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sklep_rowerowy/main.dart';
import 'package:sklep_rowerowy/pages/chat_page/chat_page.dart';
import 'package:sklep_rowerowy/widget/this_user.dart';

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
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late String sellerUser;
  List<dynamic> userFavorites = [];
  late bool isLiked;
  late bool isCompere;

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
    getFavorite();
    isCompere = compareFirstBike == widget.id || compareSecondBike == widget.id;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getFavorite() async {
    String? thisUser = FirebaseAuth.instance.currentUser!.displayName;

    var docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(thisUser)
        .get();

    Map<String, dynamic>? data = docSnapshot.data();
    var value = data?['favorites'];
    setState(() {
      userFavorites = value;
    });
  }

  void addToFavorites(String id) {
    userFavorites.add(id);
    FirebaseFirestore.instance.collection('users').doc(thisUser).update({
      'favorites': userFavorites,
    });
  }

  void removeFromFavorites(String id) {
    userFavorites.remove(id);
    FirebaseFirestore.instance.collection('users').doc(thisUser).update({
      'favorites': userFavorites,
    });
  }

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
          _icon(
            isCompere ? Icons.arrow_circle_down : Icons.compare_arrows,
            color: Colors.white,
            size: 30,
            isOutLine: false,
            onPressed: () {
              if (!isCompere) {
                if (compareFirstBike.isEmpty) {
                  compareFirstBike = widget.id;
                } else if (compareSecondBike.isEmpty) {
                  compareSecondBike = widget.id;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Możesz porównywać maksymalnie dwa elementy na raz!'),
                  ));
                  return;
                }
              } else {
                if (compareFirstBike == widget.id) {
                  compareFirstBike = '';
                } else if (compareSecondBike == widget.id) {
                  compareSecondBike = '';
                } else {}
              }

              setState(() {
                isCompere = !isCompere;
              });
            },
          ),
          _icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
            size: 30,
            isOutLine: false,
            onPressed: () {
              isLiked
                  ? removeFromFavorites(widget.id)
                  : addToFavorites(widget.id);
              setState(
                () {
                  isLiked = !isLiked;
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = const Color.fromARGB(255, 178, 93, 40),
    double size = 20,
    bool isOutLine = false,
    Function? onPressed,
  }) {
    return SizedBox(
      height: 40,
      width: 40,
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
          Image.network(
            widget.picture,
            height: 300,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

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
                _description("Opis", widget.description),
                _description("Typ roweru", widget.type),
                _description("Rodzaj i rozmiar ramy",
                    "${widget.typeMaleFemale} ${widget.typeOfFrame} ${widget.sizeOfFrame}"),
                _description("Waga", widget.weight, helpText: 'kg'),
                _description("Rozmiar koła", widget.wheelSize, helpText: '″'),
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

  Widget _description(String text, String asset, {String helpText = ''}) {
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
          Text('$asset $helpText'),
        ],
      ),
    );
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: onPressedFloatingActionButton,
      backgroundColor: AppStandardsColors.backgroundColor,
      child: Icon(Icons.message,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = userFavorites.contains(widget.id); //true;

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

  void onPressedFloatingActionButton() async {
    String id = '${thisUser}_$sellerUser';
    String id1 = '${sellerUser}_$thisUser';
    final check =
        await FirebaseFirestore.instance.collection('messages').doc(id).get();
    final check1 =
        await FirebaseFirestore.instance.collection('messages').doc(id1).get();
    if (check.data() == null && check1.data() == null) {
      FirebaseFirestore.instance.collection('messages').doc(id).set({
        'user1': thisUser,
        'user2': sellerUser,
        'avatar1': await ThisUser().getFileData('', thisUser!),
        'avatar2': await ThisUser().getFileData('', sellerUser),
      });
    } else if (check.data() != null) {
      FirebaseFirestore.instance.collection('messages').doc(id).update({});
    } else {
      FirebaseFirestore.instance.collection('messages').doc(id1).update({});
    }

    // ignore: use_build_context_synchronously
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
                ),
              ),
              onPressed: () => onPressed(),
              child: Container(),
            ),
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
