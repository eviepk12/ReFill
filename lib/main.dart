import 'package:flutter/material.dart';
import 'package:refill_app/colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:refill_app/widget_tree.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
        useMaterial3: true,
      ),
      home: const Scaffold(
        backgroundColor: Colours.scaffoldBGColor,
        body: WidgetTree(),
      ),
    );
  }
}