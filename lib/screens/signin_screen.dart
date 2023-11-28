import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_store_new/screens/home_screen.dart';
import 'package:x_store_new/screens/signup_page.dart';
import '../common/utils/color.dart';
import '../models/auth/auth_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Constants constants = Constants();

  final FirebaseAuthService _authService = FirebaseAuthService();

  void _signInUser() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    try {
      await _authService.loginWithEmailPassword(email, password);

      print('User signed in successfully');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      print('Sign-in failed: ${e.message}');
      showDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
                title: const Text("internal error"),
                content: Text('check your info details correctly:\n${e.code}'),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ok')),
                ]);
          });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constants.primarySecondColor.withOpacity(.1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title:
            const Text('Signin', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 45),
        child: Container(
          width: size.width * .95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: constants.primarySecondColor.withOpacity(.3),
                  spreadRadius: 5,
                  blurRadius: 4,
                  offset: const Offset(0, 5))
            ],
            image: DecorationImage(
                image: const AssetImage("assets/images/x.png"),
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.3), BlendMode.darken)),
          ),
          child: ListView(children: [
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: "email",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            labelText: "password",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signInUser();
                        }
                      },
                      child: const Text('Sign In'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("you don't have an account? ",
                            style: TextStyle(color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignupPage()));
                          },
                          child: const Text("Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
