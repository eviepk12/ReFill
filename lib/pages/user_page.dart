import 'package:flutter/material.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/widgets/footer.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      appBar: AppBar(
          backgroundColor: Colours.accentColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Hello World"),
          Footer(),
        ],
      ),
    );
  }
}
