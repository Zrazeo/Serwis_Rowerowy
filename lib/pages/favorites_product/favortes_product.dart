import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/style/colors.dart';

class Product {
  String image;
  String name;
  int price;

  Product(this.image, this.name, this.price);
}

class FavoritesProduct extends StatelessWidget {
  FavoritesProduct({Key? key}) : super(key: key);
  List products = [
    Product('images/rower3.jpg', 'Rower', 200),
    Product("images/rower2.jpg", 'rower', 2000),
    Product("images/rower6.jpg", 'rower', 2000),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStandardsColors.backgroundColor,
          centerTitle: true,
          title: const Text(
            "Ulubione",
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
                children: products
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: Offset(3, 4))
                          ],
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            e.image,
                            fit: BoxFit.cover,
                            width: 90,
                            height: 100,
                          ),
                          title: Text(
                            e.name,
                            style: const TextStyle(fontSize: 25),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${e.price} zł"),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 40,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 20,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Image.network(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRxHTyqjCdnZsEM-EkMvn3FDBkDADcaEZ3GN1YEdWFToAJm83nX&usqp=CAU'),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList())
          ],
        ),
      );
}
