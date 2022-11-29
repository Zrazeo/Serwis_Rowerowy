import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sklep_rowerowy/pages/chat_page/chat_page.dart';

import '../../style/colors.dart';
import '../../widget/this_user.dart';

class PartsDetailPage extends StatefulWidget {
  final String id;
  final String owner;
  final String brand;
  final String picture;
  final String price;
  final String name;
  final String description;

  const PartsDetailPage({
    Key? key,
    required this.id,
    required this.owner,
    required this.picture,
    required this.price,
    required this.name,
    required this.description,
    required this.brand,
  }) : super(key: key);

  @override
  PartsDetailPageState createState() => PartsDetailPageState();
}

class PartsDetailPageState extends State<PartsDetailPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late String sellerUser;
  List<dynamic> userFavorites = [];
  late bool isLiked;

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
                            text: widget.name,
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

  FloatingActionButton _floatingButton() {
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
      floatingActionButton: _floatingButton(),
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
