import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart%20';
import 'package:flutter/material.dart';
import 'package:sklep_rowerowy/pages/add_product/add_product.dart';
import 'package:uuid/uuid.dart';

String brak = 'Brak';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController brand = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController brakes = TextEditingController();
  TextEditingController frontShockAbsorber = TextEditingController();
  TextEditingController shockAbsorber = TextEditingController();
  TextEditingController numberOfGears = TextEditingController();
  TextEditingController rearDerailleur = TextEditingController();
  TextEditingController frontDerailleur = TextEditingController();
  TextEditingController typeOfFrame = TextEditingController();
  TextEditingController sizeOfFrame = TextEditingController();
  TextEditingController wheelSize = TextEditingController();
  TextEditingController typeMaleFemale = TextEditingController();
  TextEditingController weight = TextEditingController();
  // TextEditingController picture = TextEditingController();
  TextEditingController description = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  String? downloadURL;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    String uid = const Uuid().v4();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final results = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg'],
                    );
                    if (results == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nie wybrano pliku.'),
                        ),
                      );
                      return;
                    }
                    final path = results.files.single.path!;
                    final fileName = results.files.single.name;

                    print(path);

                    storage
                        .uploadFile(path, fileName)
                        .then((value) => print('Done'));

                    String downloadURL = await storage.downloadURL(fileName);

                    FirebaseFirestore.instance
                        .collection('bike')
                        .doc(uid)
                        .set({'picture': downloadURL});
                  },
                  child: const Text('Dodaj zdjęcia'),
                ),
              ),
              // FutureBuilder(
              //     future: storage.listFiles(),
              //     builder: (BuildContext context,
              //         AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              //       if (snapshot.connectionState == ConnectionState.done &&
              //           snapshot.hasData) {
              //         return Container(
              //           padding: const EdgeInsets.symmetric(horizontal: 20),
              //           height: 100,
              //           child: ListView.builder(
              //               scrollDirection: Axis.horizontal,
              //               shrinkWrap: true,
              //               itemCount: snapshot.data!.items.length,
              //               itemBuilder: (BuildContext context, index) {
              //                 return Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: ElevatedButton(
              //                     onPressed: () {},
              //                     child: Text(snapshot.data!.items[index].name),
              //                   ),
              //                 );
              //               }),
              //         );
              //       }
              //       if (snapshot.connectionState == ConnectionState.waiting ||
              //           !snapshot.hasData) {
              //         return CircularProgressIndicator();
              //       }
              //       return Container();
              //     }),
              bikeTextField(context, brand, 'Marka'),
              bikeTextField(context, model, 'Model'),
              bikeTextField(context, type, 'Rodzaj'),
              bikeTextField(context, price, 'Cena'),
              bikeTextField(context, weight, 'Waga'),
              bikeTextField(context, color, 'Kolor'),
              bikeTextField(context, brakes, 'Hamulce'),
              bikeTextField(context, frontShockAbsorber, 'Przedni amortyzator'),
              bikeTextField(context, shockAbsorber, 'Tylni amortyzator'),
              bikeTextField(context, numberOfGears, 'Liczba przerzutek'),
              bikeTextField(context, rearDerailleur, 'Przerzutka tylna'),
              bikeTextField(context, frontDerailleur, 'Przerzutka przednia'),
              bikeTextField(context, typeOfFrame, 'Rodzaj ramy'),
              bikeTextField(context, sizeOfFrame, 'Rozmiar ramy'),
              bikeTextField(context, typeMaleFemale, 'Rodzaj damski/męski'),
              bikeTextField(context, wheelSize, 'Rozmiar kół'),
              bikeTextField(context, description, 'Opis'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance.collection('bike').doc(uid).update({
            'brand': brand.text,
            'model': model.text,
            'type': type.text,
            'price': price.text,
            'weight': weight.text,
            'color': color.text,
            'brakes': brakes.text,
            'frontShockAbsorber': frontShockAbsorber.text,
            'shockAbsorber': shockAbsorber.text,
            'numberOfGears': numberOfGears.text,
            'rearDerailleur': rearDerailleur.text,
            'frontDerailleur': frontDerailleur.text,
            'typeOfFrame': typeOfFrame.text,
            'sizeOfFrame': sizeOfFrame.text,
            'typeMaleFemale': typeMaleFemale.text,
            'wheelSize': wheelSize.text,
            // 'picture': picture.text,
            'description': description.text,
            'owner': user!.displayName,
          });
          Navigator.of(context).pop();
          // clearTextField();
        },
      ),
    );
  }

  TextFormField bikeTextField(
      BuildContext context, TextEditingController controller, String name) {
    return TextFormField(
      controller: controller,
      // controller: controller == null ? controller = brak : controller,
      cursorColor: Theme.of(context).backgroundColor,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(
          color: Color(0xFF6200EE),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
        ),
      ),
    );
  }

  void clearTextField() {
    brand.dispose();
    model.dispose();
    type.dispose();
    color.dispose();
    price.dispose();
    brakes.dispose();
    frontShockAbsorber.dispose();
    shockAbsorber.dispose();
    numberOfGears.dispose();
    rearDerailleur.dispose();
    frontDerailleur.dispose();
    typeOfFrame.dispose();
    sizeOfFrame.dispose();
    wheelSize.dispose();
    typeMaleFemale.dispose();
    weight.dispose();
    description.dispose();
  }
}
