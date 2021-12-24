import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/home_screen.dart';

class SkillsOnBoardWizard extends StatefulWidget {
  static final String id = "skills onboarding wizard route";
  @override
  _SkillsOnBoardWizardState createState() => _SkillsOnBoardWizardState();
}

class _SkillsOnBoardWizardState extends State<SkillsOnBoardWizard> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController? _firstSkill = TextEditingController();
  TextEditingController? _secondSkill = TextEditingController();
  TextEditingController? _thirdSkill = TextEditingController();
  @override
  void dispose() {
    _firstSkill!.dispose();
    _secondSkill!.dispose();
    _thirdSkill!.dispose();
    super.dispose();
  }

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
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Text(
                          "Skills",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                        child: Text(
                          "What Skills do you have?",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: _firstSkill,
                            decoration: InputDecoration(
                              hintText: "Please enter your first Skill",
                              labelText: "First Skill* ",
                              labelStyle: TextStyle(color: Colors.lightBlue),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: _secondSkill,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Please enter your second Skill",
                              labelText: "Second Skill",
                              labelStyle: TextStyle(color: Colors.lightBlue),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black)),
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
                              controller: _thirdSkill,
                              decoration: InputDecoration(
                                hintText: "Please enter your third Skill",
                                labelText: "Third Skill",
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
                                if (_firstSkill != null) {
                                  String documentID = _auth.currentUser!.uid.toString();

                                  await _firestore.collection("users/$documentID/skills").doc("firstSkill").set(
                                    {
                                      'skill': _firstSkill!.text.trim(),
                                    },
                                  ).then((value) async {
                                    await _firestore.collection("users/$documentID/skills").doc("secondSkill").set(
                                      {
                                        'skill': _secondSkill!.text.trim(),
                                      },
                                    );
                                  }).then((value) async {
                                    await _firestore.collection("users/$documentID/skills/").doc("thirdSkill").set(
                                      {
                                        'skill': _thirdSkill!.text.trim(),
                                      },
                                    );
                                  });

                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(_auth.currentUser!.uid.toString())
                                      .set({
                                    'isSkillRegistered': true,
                                  }, SetOptions(merge: true));

                                  Navigator.popAndPushNamed(context, HomeScreen.id);
                                }
                              },
                              child: Text(
                                "Add Skills",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16.0),
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
                          style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w600),
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
