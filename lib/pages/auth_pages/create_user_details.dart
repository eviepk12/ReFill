import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/header_page.dart';

class CreateUserDetailsPage extends StatefulWidget {
  // bool isNewUser;
  bool isInDatabase = false;

  CreateUserDetailsPage({Key? key}) : super(key: key);

  @override
  State<CreateUserDetailsPage> createState() => _CreateUserDetailsPageState();
}

class _CreateUserDetailsPageState extends State<CreateUserDetailsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final adController = TextEditingController();
  final phnController = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  late final user = auth.currentUser;
  late final uuid = user!.uid;
  late final userEmail = user!.email;

  CollectionReference Users = FirebaseFirestore.instance.collection("Users");

  Future<void> addUsers() {
    return Users.add({
      "useId": uuid,
      "email": userEmail,
      "username": usernameController.text,
      "age": ageController.text,
      "phone_no.": phnController.text
    }).then((value) {
      print("User added");
      widget.isInDatabase = true;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HeaderPage(),
      //   ),
      // );
    }).catchError((error) {
      print("Failed to add user : $error");
      var snackBar = SnackBar(content: Text('Failed to add user : $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) => widget.isInDatabase == false
      ? HeaderPage()
      : Scaffold(
          backgroundColor: Colours.scaffoldBGColor,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Divider(color: Colors.red),
                const Text(
                  'Input your User Details!',
                  style: TextStyle(fontSize: 28, color: Colours.accentColor),
                ),
                const Divider(color: Colors.red),
                // const SizedBox(height: 15),
                //
                Form(
                  child: Column(
                    children: [
                      _EntryField(
                          title: "Username", controller: usernameController),
                      SizedBox(height: 10),
                      _EntryField(title: "Age", controller: ageController),
                      SizedBox(height: 10),
                      _EntryField(
                          title: "Phone Number", controller: phnController),
                      //
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          addUsers();
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        child: const Text(
                          "Submit Details",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}

class _EntryField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const _EntryField({
    required this.title,
    required this.controller,
  });

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
