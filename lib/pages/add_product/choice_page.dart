import 'package:flutter/material.dart';

import '../../style/colors.dart';
import 'add_parts_page.dart';
import 'add_product_page.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStandardsColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Dodaj ogłoszenie",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: AppStandardsColors.backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 270,
              height: 140,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 73, 90, 90),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const AddProductPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'Dodaj ogłoszenie\nz rowerem',
                      style: TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(255, 73, 90, 90),
                      ),
                    ),
                    Icon(
                      Icons.pedal_bike,
                      size: 50.0,
                      color: Color.fromARGB(255, 73, 90, 90),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            SizedBox(
              width: 270,
              height: 140,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 73, 90, 90),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const AddPartsPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'Dodaj ogłoszenie \nczęści rowerowych',
                      style: TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(255, 73, 90, 90),
                      ),
                    ),
                    Icon(
                      Icons.settings_outlined,
                      size: 50.0,
                      color: Color.fromARGB(255, 73, 90, 90),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
