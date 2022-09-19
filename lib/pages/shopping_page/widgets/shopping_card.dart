import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/product_details/product_details_page.dart';
import 'package:sklep_rowerowy/pages/product_details/widgets/shopping_model.dart';
import 'package:sklep_rowerowy/style/colors.dart';

class ShoppingCard extends StatelessWidget {
  final ShoppingModel product;

  const ShoppingCard(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ProductDetailsPage(product),
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
                            product.title,
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
                            product.info1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppStandardsColors.textLightColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            product.info2,
                            style: const TextStyle(
                              color: AppStandardsColors.textLightColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${product.price} zł",
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
                        child: Hero(
                          tag: product.title,
                          child: Image(
                            image: product.productImage,
                            fit: BoxFit.contain,
                          ),
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
