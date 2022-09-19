import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/product_details/widgets/shopping_model.dart';
import 'package:sklep_rowerowy/style/colors.dart';

class ProductDetailsPage extends StatefulWidget {
  final ShoppingModel product;

  const ProductDetailsPage(this.product, {Key? key}) : super(key: key);

  @override
  ProductDetailsPageState createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStandardsColors.accentColor,
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.bookmark_border,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container(
          color: AppStandardsColors.accentColor,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Hero(
                      tag: widget.product.title,
                      child: Image(
                        image: widget.product.productImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
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
                            flex: 5,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              color: Colors.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26)),
                              margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Image(
                                          image: widget.product.productImage,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Image(
                                          image: widget.product.productImage,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Image(
                                          image: widget.product.productImage,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(42, 16, 32, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  "Opis",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppStandardsColors.unselectedColor,
                                      letterSpacing: 2),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                  child: Text(
                                    "${widget.product.info1}\n${widget.product.info2}",
                                    softWrap: true,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const Text(
                                  "Więcej...",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: AppStandardsColors.unselectedColor,
                                  ),
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Card(
                            color: AppStandardsColors.backgroundColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26),
                              topRight: Radius.circular(26),
                            )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 36, right: 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "${widget.product.price} zł",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 26),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppStandardsColors.unselectedColor,
                                      padding: const EdgeInsets.fromLTRB(
                                          62, 16, 62, 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Kup",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      );
}
