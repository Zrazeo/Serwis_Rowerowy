// import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/main.dart';

import '../../style/colors.dart';

class ComparisonPage extends StatefulWidget {
  const ComparisonPage({
    Key? key,
  }) : super(key: key);

  @override
  ComparisonPageState createState() => ComparisonPageState();
}

class ComparisonPageState extends State<ComparisonPage> {
  Map<String, dynamic> firstItemMap = {};
  Map<String, dynamic> secondItemMap = {};

  void getFirstItem() async {
    final firstItem = await FirebaseFirestore.instance.collection('bike').doc(compareFirstBike).get();

    setState(() {
      firstItemMap = firstItem.data() as Map<String, dynamic>;
    });
  }

  void getSecondItem() async {
    final secondItem = await FirebaseFirestore.instance.collection('bike').doc(compareSecondBike).get();

    setState(() {
      secondItemMap = secondItem.data() as Map<String, dynamic>;
    });
  }

  @override
  void initState() {
    super.initState();
    if (compareFirstBike == '' || compareSecondBike == '') return;
    getFirstItem();
    getSecondItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Porównywarka",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: AppStandardsColors.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: compareFirstBike == '' || compareSecondBike == ''
            ? const Center(
                child: Text(
                  'Dodaj dwa rowery do porównania!',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : firstItemMap['picture'] == null
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 120,
                              ),
                              SizedBox(
                                height: 100,
                                width: 120,
                                child: Image.network(
                                  firstItemMap['picture'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(right: 60)),
                              SizedBox(
                                height: 100,
                                width: 120,
                                child: Image.network(
                                  secondItemMap['picture'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15),
                            child: DataTable(
                              columns: const [
                                DataColumn(
                                  label: Text(''),
                                ),
                                DataColumn(
                                  label: Text('Rower 1'),
                                ),
                                DataColumn(
                                  label: Text('Rower 2'),
                                ),
                              ],
                              rows: [
                                DataRow(
                                  color: MaterialStateProperty.all(firstItemMap['brand'] == secondItemMap['brand']
                                      ? Colors.white
                                      : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Marka")),
                                    DataCell(Text(firstItemMap['brand'])),
                                    DataCell(Text(secondItemMap['brand'])),
                                  ],
                                ),
                                DataRow(
                                  color: MaterialStateProperty.all(firstItemMap['model'] == secondItemMap['model']
                                      ? Colors.white
                                      : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Model")),
                                    DataCell(Text(firstItemMap['model'])),
                                    DataCell(Text(secondItemMap['model'])),
                                  ],
                                ),
                                DataRow(
                                  color: MaterialStateProperty.all(firstItemMap['price'] == secondItemMap['price']
                                      ? Colors.white
                                      : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Cena")),
                                    DataCell(Text('${firstItemMap['price']} zł')),
                                    DataCell(Text('${secondItemMap['price']} zł')),
                                  ],
                                ),
                                DataRow(
                                  color: MaterialStateProperty.all(
                                      firstItemMap['type'] == secondItemMap['type'] ? Colors.white : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Typ roweru")),
                                    DataCell(Text(firstItemMap['type'])),
                                    DataCell(Text(secondItemMap['type'])),
                                  ],
                                ),
                                DataRow(
                                  color: MaterialStateProperty.all(firstItemMap['weight'] == secondItemMap['weight']
                                      ? Colors.white
                                      : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Waga")),
                                    DataCell(Text('${firstItemMap['weight']} kg')),
                                    DataCell(Text('${secondItemMap['weight']} kg')),
                                  ],
                                ),
                                DataRow(
                                  color: MaterialStateProperty.all(
                                      firstItemMap['wheelSize'] == secondItemMap['wheelSize']
                                          ? Colors.white
                                          : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Rozmiar kół")),
                                    DataCell(Text('${firstItemMap['wheelSize']}"')),
                                    DataCell(Text('${secondItemMap['wheelSize']}"')),
                                  ],
                                ),
                                DataRow(
                                  color: MaterialStateProperty.all(
                                      firstItemMap['rearDerailleur'] == secondItemMap['rearDerailleur']
                                          ? Colors.white
                                          : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Przerzutki")),
                                    DataCell(Text(firstItemMap['rearDerailleur'])),
                                    DataCell(Text(secondItemMap['rearDerailleur'])),
                                  ],
                                ),
                                DataRow(
                                  color: MaterialStateProperty.all(firstItemMap['brakes'] == secondItemMap['brakes']
                                      ? Colors.white
                                      : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Hamulce")),
                                    DataCell(Text(firstItemMap['brakes'])),
                                    DataCell(Text(secondItemMap['brakes'])),
                                  ],
                                ),
                                DataRow(
                                  color: MaterialStateProperty.all(
                                      firstItemMap['shockAbsorber'] == secondItemMap['shockAbsorber']
                                          ? Colors.white
                                          : Colors.blue[200]),
                                  cells: [
                                    const DataCell(Text("Amortyzatory")),
                                    DataCell(Text(firstItemMap['shockAbsorber'])),
                                    DataCell(Text(secondItemMap['shockAbsorber'])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }
}
