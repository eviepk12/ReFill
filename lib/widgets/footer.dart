import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Image.asset("assets/logo.png"),
        ),
        const Text(
          " | Copyright 2023",
          style: TextStyle(fontSize: 20, color: Colors.white),
        )
      ],
    );
  }
}
