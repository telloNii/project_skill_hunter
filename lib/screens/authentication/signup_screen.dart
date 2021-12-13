import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = "sign up screen route";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController? _usernameTextControler = TextEditingController();
  TextEditingController? _emailTextController = TextEditingController();
  TextEditingController? _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.longestSide * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    child: Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),
                    child: Text(
                      "First let's get you registered",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _usernameTextControler,
                        decoration: InputDecoration(
                          hintText: "Please enter your Username",
                          labelText: "UserName",
                          labelStyle: TextStyle(color: Colors.lightBlue),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)),
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
                        decoration: InputDecoration(
                          hintText: "Please enter your Email",
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.lightBlue),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
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
                          decoration: InputDecoration(
                            hintText: "Please enter your Password",
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.lightBlue),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
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
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () async {
                            print(_emailTextController!.text);

                            if (_usernameTextControler != null &&
                                _emailTextController!.text.contains("@") &&
                                _passwordTextController != null) {
                              await _auth
                                  .createUserWithEmailAndPassword(
                                      email: _emailTextController!.text,
                                      password: _passwordTextController!.text)
                                  .then(
                                (value) {
                                  final user = _auth.currentUser;
                                  return user!
                                      .updateDisplayName(
                                          _usernameTextControler!.text)
                                      .then((value) async {
                                    CollectionReference ref = FirebaseFirestore
                                        .instance
                                        .collection('users');

                                    String docId = ref.doc().id;
                                    setState(() {
                                      docId = _auth.currentUser!.uid.toString();
                                    });

                                    await ref.doc(docId).set({
                                      'userName': _usernameTextControler!.text,
                                      'id': docId,
                                      'isFullyRegistered': false,
                                    }).then((value) {
                                      // Do something
                                    }).onError((error, stackTrace) {
                                      print(stackTrace);
                                    });
                                  });
                                },
                              );
                              Navigator.pop(context);
                              print(_auth.currentUser!.email.toString());
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
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
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
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w600),
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
