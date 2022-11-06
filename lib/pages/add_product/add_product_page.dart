import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart%20';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sklep_rowerowy/pages/add_product/add_product.dart';
import 'package:uuid/uuid.dart';

import '../../style/colors.dart';

String brak = 'Brak';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

// PickedFile? pickedFile;

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
  final formKey = GlobalKey<FormState>();

  File? imageFile;
  String? downloadURL;
  String dropdownValueType = 'BMX';
  String dropdownValueTypeOfFrame = 'Aluminium';
  String dropdownValueTypeMaleFemale = 'Męski';
  String dropdownValueSizeOfFrame = 'L';

  dropdownButtonFormField(List<String> listItem, String dropdownValue,
      Function function, String name) {
    return Container(
      // padding: const EdgeInsets.only(b: 10),
      margin: EdgeInsets.symmetric(vertical: 7),
      height: 67,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: name,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            //<-- SEE HERE
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            //<-- SEE HERE
            borderSide: const BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        // dropdownColor: Colors.greenAccent,
        value: dropdownValue,
        onChanged: (String? newValue) {
          function(newValue);
        },
        // hint: Text(
        //   "fndsofnsdnioafn",
        //   style: const TextStyle(fontSize: 20, color: Colors.black),
        //   textAlign: TextAlign.center,
        // ),
        items: listItem.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          );
        }).toList(),
      ),
    );
  }

  changeType(value) {
    setState(() {
      dropdownValueType = value;
    });
  }

  changeTypeMaleFemale(value) {
    setState(() {
      dropdownValueTypeMaleFemale = value;
    });
  }

  changeTypeOfFrame(value) {
    setState(() {
      dropdownValueTypeOfFrame = value;
    });
  }

  changeSizeOfFrame(value) {
    setState(() {
      dropdownValueSizeOfFrame = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Storage storage = Storage();
    String uid = const Uuid().v4();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Dodaj ogłoszenie",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: AppStandardsColors.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bikeTextField(context, brand, 'Marka'),
                bikeTextField(context, model, 'Model'),
                // const Padding(
                //   padding: EdgeInsets.all(7.0),
                //   child: Text(
                //     "Rodzaj",
                //     style: TextStyle(fontSize: 18, color: Colors.black),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                dropdownButtonFormField(
                    ['Górski', 'Miejski', 'BMX', 'Cross', 'Treking'],
                    dropdownValueType,
                    changeType,
                    'Rodzaj'),
                // bikeTextField(context, type, 'Rodzaj'),
                bikeTextField(context, price, 'Cena'),
                bikeTextField(context, weight, 'Waga'),
                bikeTextField(context, color, 'Kolor'),
                bikeTextField(context, brakes, 'Hamulce'),
                bikeTextField(
                    context, frontShockAbsorber, 'Przedni amortyzator'),
                bikeTextField(context, shockAbsorber, 'Tylni amortyzator'),
                bikeTextField(context, numberOfGears, 'Liczba przerzutek'),
                bikeTextField(context, rearDerailleur, 'Przerzutka tylna'),
                bikeTextField(context, frontDerailleur, 'Przerzutka przednia'),
                // const Padding(
                //   padding: EdgeInsets.all(7.0),
                //   child: Text(
                //     "Rodzaj ramy",
                //     style: TextStyle(fontSize: 18, color: Colors.black),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                dropdownButtonFormField(
                    ['Stal', 'Aluminium', 'Carbon', 'Magnez', 'Tytan'],
                    dropdownValueTypeOfFrame,
                    changeTypeOfFrame,
                    'Rodzaj ramy'),
                // //bikeTextField(context, typeOfFrame, 'Rozmiar ramy'),
                // const Padding(
                //   padding: EdgeInsets.all(7.0),
                //   child: Text(
                //     "Rozmiar ramy",
                //     style: TextStyle(fontSize: 18, color: Colors.black),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                dropdownButtonFormField(
                    ['S', 'M', 'L', 'XL'],
                    dropdownValueSizeOfFrame,
                    changeSizeOfFrame,
                    'Rozmiar ramy'),
                //bikeTextField(context, sizeOfFrame, 'Rozmiar ramy'),
                // const Padding(
                //   padding: EdgeInsets.all(7.0),
                //   child: Text(
                //     "Rodzaj damski/męski",
                //     style: TextStyle(fontSize: 18, color: Colors.black),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                dropdownButtonFormField(
                    ['Damski', 'Męski'],
                    dropdownValueTypeMaleFemale,
                    changeTypeMaleFemale,
                    'Rodzaj damski/męski'),
                //bikeTextField(context, typeMaleFemale, 'Rodzaj damski/męski'),
                bikeTextField(context, wheelSize, 'Rozmiar kół'),
                bikeTextField(context, description, 'Opis', size: 5),
                if (downloadURL != null)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Center(
                        child: Image.file(
                          imageFile!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppStandardsColors.backgroundColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        // ignore: deprecated_member_use
                        PickedFile? pickedFile = await ImagePicker().getImage(
                          source: ImageSource.gallery,
                          maxHeight: 300,
                          maxWidth: 300,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            imageFile = File(pickedFile.path);
                          });
                        }

                        FirebaseStorage storage = FirebaseStorage.instance;
                        try {
                          await storage.ref('test/$uid').putFile(imageFile!);
                        } on FirebaseStorage catch (e) {
                          print(e);
                        }
                        String url =
                            await storage.ref('test/$uid').getDownloadURL();
                        setState(() {
                          downloadURL = url;
                        });
                      },
                      child: const Text('Dodaj zdjęcie'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStandardsColors.backgroundColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          if (downloadURL == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Musisz dodać zdjęcie rowera do ogłoszenia!'),
            ));
            return;
          }
          final isValid = formKey.currentState!.validate();
          if (!isValid) return;

          FirebaseFirestore.instance.collection('bike').doc(uid).set({
            'brand': brand.text,
            'model': model.text,
            'type': dropdownValueType,
            'price': price.text,
            'weight': weight.text,
            'color': color.text,
            'brakes': brakes.text,
            'frontShockAbsorber': frontShockAbsorber.text,
            'shockAbsorber': shockAbsorber.text,
            'numberOfGears': numberOfGears.text,
            'rearDerailleur': rearDerailleur.text,
            'frontDerailleur': frontDerailleur.text,
            'typeOfFrame': dropdownValueTypeOfFrame,
            'sizeOfFrame': dropdownValueSizeOfFrame,
            'typeMaleFemale': dropdownValueTypeMaleFemale,
            'wheelSize': wheelSize.text,
            'picture': downloadURL,
            'description': description.text,
            'owner': user!.displayName,
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget bikeTextField(
      BuildContext context, TextEditingController controller, String name,
      {int size = 1}) {
    return Container(
      height: size > 1 ? 76 * 2 : 76,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        validator: (value) => value != null ? null : 'Pole nie może być puste',
        controller: controller,
        cursorColor: Theme.of(context).backgroundColor,
        maxLines: size,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 30, 0, 30),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: name,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  late String _selectedValue = '';
  DropdownButtonFormField bikeDropdownButton(
    List<String> items,
  ) {
    return DropdownButtonFormField(
      value: _selectedValue,
      items: items.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(
            val,
          ),
        );
      }).toList(),
      onChanged: (value) {
        _selectedValue = value;
      },
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
