import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/widgets/appbar_title.dart';
import 'package:refill_app/widgets/footer.dart';

class CreateUserDetailsPage extends StatefulWidget {
  const CreateUserDetailsPage({Key? key}) : super(key: key);

  @override
  State<CreateUserDetailsPage> createState() => _CreateUserDetailsPageState();
}

class _CreateUserDetailsPageState extends State<CreateUserDetailsPage> {
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final phnController = TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  File? _image;

  late final user = auth.currentUser;
  late final uuid = user!.uid;
  late final userEmail = user!.email;

  CollectionReference Users = FirebaseFirestore.instance.collection("Users");

  final _formKey = GlobalKey<FormState>();

  Future<void> addUsers() async {
    final db = FirebaseFirestore.instance;

    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef =
        FirebaseStorage.instance.ref().child('UserAvatars/$imageName.jpg');
    var uploadTask = storageRef.putFile(_image!);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();

    final userData = <String, String>{
      "userId": uuid,
      "email": userEmail.toString(),
      "username": usernameController.text,
      "age": ageController.text,
      "phone_no.": phnController.text,
      "imageUrl": downloadUrl.toString(),
    };

    db.collection("Users").doc(uuid).set(userData).then((value) {
      print("User added");
      var snackBar = const SnackBar(content: Text('Data Saved'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      usernameController.clear();
      ageController.clear();
      phnController.clear();
    }).catchError((error) {
      print("Failed to add user : $error");
      var snackBar = SnackBar(content: Text('Failed to add user : $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    // return Users.add({
    // "userId": uuid,
    // "email": userEmail,
    // "username": usernameController.text,
    // "age": ageController.text,
    // "phone_no.": phnController.text,
    // "imageUrl": downloadUrl.toString(),
    // }).then((value) {
    //   print("User added");
    //   var snackBar = const SnackBar(content: Text('Data Saved'));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);

    //   usernameController.clear();
    //   ageController.clear();
    //   phnController.clear();
    // }).catchError((error) {
    //   print("Failed to add user : $error");
    //   var snackBar = SnackBar(content: Text('Failed to add user : $error'));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.accentColor,
        title: const AppBarTitle(title: "Input User Details"),
      ),
      backgroundColor: Colours.scaffoldBGColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colours.accentColor,
                      style: BorderStyle.solid,
                      width: 5),
                  color: Colors.white,
                ),
                child: Center(
                  child: _image == null
                      ? const Text('No image selected.')
                      : Image.file(_image!),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                }
              },
              child: const Text('Select image'),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _EntryField(
                    title: "Username",
                    controller: usernameController,
                    keyboardType: TextInputType.name,
                    inputFormat: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                  const SizedBox(height: 10),
                  _EntryField(
                    title: "Age",
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    inputFormat: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: 10),
                  _EntryField(
                    title: "Phone Number",
                    controller: phnController,
                    keyboardType: TextInputType.phone,
                    inputFormat: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  //
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        addUsers();
                      }
                    },
                    child: const Text('Save Details',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}

class _EntryField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormat;

  const _EntryField(
      {required this.title,
      required this.controller,
      required this.keyboardType,
      required this.inputFormat});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else {
          return null;
        }
      },
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormat,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: title,
        focusColor: Colors.white,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
