import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_store_new/screens/home_screen.dart';
import '../common/utils/color.dart';
import '../models/auth/auth_model.dart';
import 'signin_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Constants constants = Constants();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  final FirebaseAuthService _authService = FirebaseAuthService();

  void _signUpUser() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String phone = phoneController.text;
    final String userName = usernameController.text;

    try {
      await _authService.registerWithEmailPassword(
          email, password, userName, phone);
      print('User signed up successfully');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      // showDialog(
      //     context: context,
      //     builder: (_) {
      //       return CupertinoAlertDialog(
      //           title: const Text('successes please go to login page'),
      //           actions: [
      //             CupertinoDialogAction(
      //                 onPressed: () {
      //                   Navigator.pushReplacement(context,
      //                       MaterialPageRoute(builder: (_) => const SignInScreen()));
      //                 },
      //                 child: const Text('ok'))
      //           ]);
      //     });
    } on FirebaseAuthException catch (e) {
      print('Sign-up failed: ${e.message}');
      showDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
                title: Text('check your info details \n ${e.code}'),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                        dispose();
                      },
                      child: const Text('ok'))
                ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: constants.primarySecondColor.withOpacity(.1),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('Signup',
              style: TextStyle(fontWeight: FontWeight.bold)),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        // maxLength: 20,
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: "username",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: emailController,
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
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            labelText: "phone number",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an your number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: passwordController,
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
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: confirmController,
                        decoration: InputDecoration(
                            labelText: "confirm password",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty &&
                              passwordController.text !=
                                  confirmController.text) {
                            return 'this field must be the same with password';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUpUser();
                          }
                        },
                        child: const Text("confirm")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("already have an account? ",
                            style: TextStyle(color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignInScreen()));
                          },
                          child: const Text("login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
