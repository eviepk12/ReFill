import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/auth.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/auth_pages/reset_password_page.dart';
import 'package:refill_app/widgets/footer.dart';

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
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Refill Logo
                  const RefillLogo(),

                  Text(
                    errorMessage == '' ? '' : 'Error : $errorMessage',
                    style: const TextStyle(fontSize: 20, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),

                  // Login Container
                  SizedBox(
                    width: 550,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          color: const Color.fromRGBO(60, 61, 69, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              autovalidateMode: AutovalidateMode.always,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                  if (isLogin)
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ResetPasswordPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Forgot Password?',
                                      ),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: ElevatedButton(
                                      child:
                                          Text(isLogin ? "Login" : "Register"),
                                      onPressed: () {
                                        isLogin
                                            ? singInWithEmailAndPassword()
                                            : createUserWithEmailAndPassword();

                                        if (!isLogin &&
                                            _passwordController.text !=
                                                _confirmPasswordController
                                                    .text) {
                                          const snackBar = SnackBar(
                                              content: Text(
                                                  'Passwords does not match'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        isLogin
                                            ? 'Doesn\'t have an account?'
                                            : "Already have an Account?",
                                        style: const TextStyle(
                                            color: Colors.white),
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
                            ),
                          )),
                    ),
                  ),
                  // Footer
                  const Footer()
                ],
              )
            ],
          )),
    );
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
    return TextFormField(
      obscureText: isPassword,
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
