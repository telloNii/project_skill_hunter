import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = "sign up screen route";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController? _usernameTextController = TextEditingController();
  TextEditingController? _emailTextController = TextEditingController();
  TextEditingController? _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.longestSide * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Text(
                      "Register",
                      style: authPageHeaderTextStyle.copyWith(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                    child: Text(
                      "First let's get you registered",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _usernameTextController,
                        decoration: textFieldInputDecoration.copyWith(
                          hintText: "Please Enter a Username",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFieldInputDecoration),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: Visibility(
                        child: TextFormField(
                          controller: _passwordTextController,
                          obscureText: obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: textFieldInputDecoration.copyWith(
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
                              icon: Icon(Icons.visibility),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "An email confirmation link will be sent to your email address.",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12),
                    ),
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
                          onPressed: () async {
                            if (_usernameTextController != null &&
                                _emailTextController!.text.contains("@") &&
                                _passwordTextController != null) {
                              await _auth
                                  .createUserWithEmailAndPassword(
                                      email: _emailTextController!.text, password: _passwordTextController!.text)
                                  .then(
                                (value) async {
                                  CollectionReference ref = FirebaseFirestore.instance.collection('users');

                                  await ref.doc(_auth.currentUser!.uid.toString()).set({
                                    'email': _emailTextController!.value.text,
                                    'userName': _usernameTextController!.text,
                                    'isFullyRegistered': false,
                                    'isSkillRegistered': false,
                                    'image':
                                        "https://png.pngitem.com/pimgs/s/111-1114675_user-login-person-man-enter-person-login-icon.png",
                                  }).then((value) {
                                    // Do something
                                  }).onError((error, stackTrace) {
                                    print(stackTrace);
                                  });
                                },
                              );
                              print(_auth.currentUser!.displayName);
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    "By registering, you agree to Skill Hunter's ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                    child: Text(
                      "Terms of Service ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
