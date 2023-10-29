import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/auth_pages/create_user_details.dart';
import 'package:refill_app/pages/header_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool isNewUser = false;
  bool canResendEmail = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    isNewUser = FirebaseAuth.instance.currentUser == FirebaseAuth.instance;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Text(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HeaderPage()
      : Scaffold(
          backgroundColor: Colours.scaffoldBGColor,
          appBar: AppBar(
            backgroundColor: Colours.accentColor,
            title: const Text("Verify Email"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Divider(color: Colors.red),
                const Text(
                  "A verification email has been sent",
                  style: TextStyle(fontSize: 20, color: Colours.accentColor),
                  textAlign: TextAlign.center,
                ),
                const Divider(color: Colors.red),
                //
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.email, size: 32),
                  label: const Text(
                    "Resend Email",
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    if (canResendEmail) sendVerificationEmail();
                  },
                ),
                const SizedBox(height: 8),
                TextButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            ),
          ),
        );
}
