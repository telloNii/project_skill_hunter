import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Username",
            style: textFieldLabel,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Email",
            style: textFieldLabel,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: textFieldInputDecoration.copyWith(
                  hintText: "Please enter your Email address"),
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _passwordTextController,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              decoration: textFieldInputDecoration.copyWith(
                hintText: "Please enter a Strong Password",
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
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "An email confirmation link will be sent to your email address.",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 12, color: Colors.white),
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
                  if (_usernameTextController != null &&
                      _emailTextController!.text.contains("@") &&
                      _passwordTextController != null) {
                    await _auth
                        .createUserWithEmailAndPassword(
                            email: _emailTextController!.text,
                            password: _passwordTextController!.text)
                        .then(
                      (value) async {
                        CollectionReference ref =
                            FirebaseFirestore.instance.collection('users');

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
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ),
      ],
    );
  }
}
