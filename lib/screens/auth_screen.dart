import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_skill_hunter/screens/forgot_password.dart';
import 'package:project_skill_hunter/screens/signin_screen.dart';

import 'package:project_skill_hunter/screens/signup_screen.dart';

import '../constants.dart';

enum SelectAuthIntent { signIn, register }

class AuthScreen extends StatefulWidget {
  static final String id = "auth in screen route";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorText;

  List<Widget> _authTypeTextFields = [SignInScreen(), SignUpScreen()];
  SelectAuthIntent _authIntentSelector = SelectAuthIntent.signIn;
  int selectedAuthTypeIndex = 0;
  bool showForgotPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background_image.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 11, sigmaY: 12),
            child: Container(
              color: Colors.blueGrey.withOpacity(0.4),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _authIntentSelector = SelectAuthIntent.signIn;
                                  selectedAuthTypeIndex = 0;
                                  showForgotPassword = true;
                                });
                              },
                              child: Text("Sign In",
                                  style: _authIntentSelector == SelectAuthIntent.signIn
                                      ? authPageHeaderTextStyle
                                      : authPageHeaderTextStyle.copyWith(
                                          fontWeight: FontWeight.w300)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _authIntentSelector = SelectAuthIntent.register;
                                  selectedAuthTypeIndex = 1;
                                  showForgotPassword = false;
                                });
                              },
                              child: Text("Register",
                                  style: _authIntentSelector == SelectAuthIntent.register
                                      ? authPageHeaderTextStyle
                                      : authPageHeaderTextStyle.copyWith(
                                          fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ],
                      ),
                      _authTypeTextFields[selectedAuthTypeIndex],
                      Text(
                        "or via social networks",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.black),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Image.asset(
                                      "images/apple logo.png",
                                      height: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      "Sign in with Apple",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      // SizedBox(
                      //     height: 40.0,
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Padding(
                      //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //             child: OutlinedButton(
                      //                 style: ButtonStyle(
                      //                   backgroundColor: MaterialStateProperty.all(Colors.black),
                      //                 ),
                      //                 onPressed: () {},
                      //                 child: Text(
                      //                   "Sign in with facebook",
                      //                   style: TextStyle(color: Colors.white),
                      //                 )),
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Padding(
                      //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //             child: OutlinedButton(
                      //                 style: ButtonStyle(
                      //                   backgroundColor: MaterialStateProperty.all(Colors.black),
                      //                 ),
                      //                 onPressed: () {},
                      //                 child: Text(
                      //                   "Sign in with google",
                      //                   style: TextStyle(color: Colors.white),
                      //                 )),
                      //           ),
                      //         ),
                      //       ],
                      //     )),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: showForgotPassword,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Color(0x00000000),
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => SingleChildScrollView(
                                      child: ForgotPassword(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
