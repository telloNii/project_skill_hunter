import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/home_screen.dart';

class OnBoardWizard extends StatefulWidget {
  static final String id = "onboarding wizard route";
  @override
  _OnBoardWizardState createState() => _OnBoardWizardState();
}

class _OnBoardWizardState extends State<OnBoardWizard> {
  bool obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _fullnameTextControler = TextEditingController();
  final _dateOfBirthTextController = TextEditingController();
  final _locationTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: Text(
                          "Basic Infomation",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 12.0),
                        child: Text(
                          "Let's complete get you registered",
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
                            controller: _fullnameTextControler,
                            decoration: InputDecoration(
                              hintText: "Please enter your Username",
                              labelText: "Full Name",
                              labelStyle: TextStyle(color: Colors.lightBlue),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());
                              _dateOfBirthTextController.text =
                                  date!.toString().substring(0, 10);
                              print(_dateOfBirthTextController.text);
                            },
                            controller: _dateOfBirthTextController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Please enter your Date of Birth",
                              labelText: "Date Of Birth",
                              labelStyle: TextStyle(color: Colors.lightBlue),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              controller: _locationTextController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                hintText: "Please enter your Location",
                                labelText: "Location",
                                labelStyle: TextStyle(color: Colors.lightBlue),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
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
                                if (_fullnameTextControler != null &&
                                    _dateOfBirthTextController != null &&
                                    _locationTextController != null) {
                                  final user = _auth.currentUser;
                                  CollectionReference ref = FirebaseFirestore
                                      .instance
                                      .collection('users');

                                  String docId = ref.doc().id;
                                  setState(() {
                                    docId = _auth.currentUser!.uid.toString();
                                    user!.updateDisplayName(
                                        _fullnameTextControler.toString());
                                  });

                                  await ref.doc(docId).set({
                                    'fullName': _fullnameTextControler.text,
                                    'date of birth':
                                        _dateOfBirthTextController.text,
                                    'Location': _locationTextController.text,
                                  }, SetOptions(merge: true));
                                  print(_auth.currentUser!.uid);
                                  print(docId);
                                  Navigator.popAndPushNamed(
                                      context, HomeScreen.id);
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }
}
