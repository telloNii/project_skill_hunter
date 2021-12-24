import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_skill_hunter/screens/onboarding_screen_wizzard_skills.dart';
import 'package:project_skill_hunter/screens/home_screen.dart';
import 'package:project_skill_hunter/screens/onboarding_screen_wizard.dart';

import '../constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorText;
  final TextEditingController? _emailTextController = TextEditingController();
  final TextEditingController? _passwordTextController = TextEditingController();
  double _onErrorBoxResize() {
    if (resetError == false) {
      return 50;
    } else {
      return 70;
    }
  }

  bool obscureText = true;
  bool resetError = false;

  @override
  void dispose() {
    _emailTextController!.dispose();
    _passwordTextController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Email",
              style: textFieldLabel,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailTextController,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: textFieldInputDecoration.copyWith(
                    hintText: "Please enter your Email"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Password",
              style: textFieldLabel,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: _onErrorBoxResize(),
              child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordTextController,
                  obscureText: obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: textFieldInputDecoration.copyWith(
                    hintText: "Please enter your Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (obscureText == true) {
                          setState(() {
                            obscureText = false;
                          });
                        } else {
                          setState(() {
                            obscureText = true;
                          });
                        }
                      },
                      icon: obscureText
                          ? Icon(
                              Icons.visibility,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                            ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xffE2BC97)),
                  ),
                  onPressed: () async {
                    print(_passwordTextController!.text);
                    print(_emailTextController!.text);
                    try {
                      if (_emailTextController!.value.text.isNotEmpty &&
                          _emailTextController!.text.contains("@") &&
                          _passwordTextController!.text.isNotEmpty) {
                        await _auth.signInWithEmailAndPassword(
                            email: _emailTextController!.text,
                            password: _passwordTextController!.text);
                        var document = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(_auth.currentUser!.uid.toString())
                            .get();
                        print(_passwordTextController!.text);
                        print(_emailTextController!.text);

                        if (_auth.currentUser != null &&
                            document.get("isFullyRegistered") == true &&
                            document.get("isSkillRegistered") == true) {
                          Navigator.popAndPushNamed(context, HomeScreen.id);
                        } else if (_auth.currentUser != null &&
                            document.get("isFullyRegistered") == false &&
                            document.get("isSkillRegistered") == false) {
                          Navigator.popAndPushNamed(context, OnBoardWizard.id);
                        } else if (_auth.currentUser != null &&
                            document.get("isFullyRegistered") == true &&
                            document.get("isSkillRegistered") == false) {
                          Navigator.popAndPushNamed(context, SkillsOnBoardWizard.id);
                        }
                      }
                    } catch (errorIdentifier) {
                      setState(() {
                        resetError = true;
                        errorText = "incorrect email or password";
                        _passwordTextController!.clear();
                      });
                    }
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
