import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = "";
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> singInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Refill Logo
                const RefillLogo(),

                // Login Container
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        color: const Color.fromRGBO(60, 61, 69, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                isLogin ? "Login" : "Register",
                                style: const TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                              const SizedBox(height: 40),
                              _EntryField(
                                title: "Email",
                                controller: _emailController,
                                isPassword: false,
                              ),
                              const SizedBox(height: 40),
                              _EntryField(
                                title: "Password",
                                controller: _passwordController,
                                isPassword: true,
                              ),
                              const SizedBox(height: 40),
                              if (!isLogin)
                                _EntryField(
                                    title: "Confirm Password",
                                    controller: _confirmPasswordController,
                                    isPassword: true),

                              // Forgot Password / change login register
                              TextButton(
                                onPressed: () {
                                  //forgot password screen
                                },
                                child: const Text(
                                  'Forgot Password',
                                ),
                              ),
                              ElevatedButton(
                                child: Text(isLogin ? "Login" : "Register"),
                                onPressed: () {
                                  isLogin
                                      ? singInWithEmailAndPassword()
                                      : createUserWithEmailAndPassword();
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'Doesn\'t have an account?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextButton(
                                    child: Text(
                                      isLogin ? "Register" : "Login",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isLogin = !isLogin;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ),

                Text(errorMessage == '' ? '' : 'Humm ? $errorMessage'),

                // Footer
                const Footer()
              ],
            )
          ],
        ));
  }
}

class RefillLogo extends StatelessWidget {
  const RefillLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200, width: 200, child: Image.asset("assets/logo.png"));
  }
}

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

class _EntryField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isPassword;

  const _EntryField({
    required this.title,
    required this.controller,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: title,
      ),
    );
  }
}
