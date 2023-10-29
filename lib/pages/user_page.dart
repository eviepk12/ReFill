import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:refill_app/auth.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/widgets/footer.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      appBar: AppBar(
        backgroundColor: Colours.accentColor,
        title: Text(
          "User Details",
          style: GoogleFonts.aBeeZee(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              signOut();
              Navigator.pop(context);
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            child:
                const Text("Sign Out", style: TextStyle(color: Colors.white)),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
