import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../style/colors.dart';

String brak = 'Brak';

class AddPartsPage extends StatefulWidget {
  const AddPartsPage({super.key});

  @override
  State<AddPartsPage> createState() => _AddPartsPageState();
}

class _AddPartsPageState extends State<AddPartsPage> {
  TextEditingController brand = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();

  File? imageFile;
  String? downloadURL;

  @override
  Widget build(BuildContext context) {
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
                partTextField(context, brand, 'Marka'),
                partTextField(context, name, 'Nazwa'),
                partTextField(context, price, 'Cena'),
                partTextField(context, description, 'Opis', size: 5),
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
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                          await storage.ref('parts/$uid').putFile(imageFile!);
                        } on FirebaseStorage catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                        String url = await storage.ref('parts/$uid').getDownloadURL();
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
              content: Text('Musisz dodać zdjęcie części do ogłoszenia!'),
            ));
            return;
          } else if (brand.text.isEmpty || name.text.isEmpty || price.text.isEmpty || description.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Musisz wpisać wszystkie dane we wszystkie pola.'),
            ));
            return;
          }
          final isValid = formKey.currentState!.validate();
          if (!isValid) return;

          FirebaseFirestore.instance.collection('parts').doc(uid).set({
            'brand': brand.text,
            'name': name.text,
            'price': price.text,
            'picture': downloadURL,
            'description': description.text,
            'owner': user!.displayName,
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget partTextField(BuildContext context, TextEditingController controller, String name, {int size = 1}) {
    return Container(
      height: size > 1 ? 76 * 2 : 76,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: name == 'Cena' ? TextInputType.number : TextInputType.text,
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
    name.dispose();
    price.dispose();
    description.dispose();
  }
}
