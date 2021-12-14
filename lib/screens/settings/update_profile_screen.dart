import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  static final String id = "profile update Screen route";
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _fullnameTextControler = TextEditingController();
  TextEditingController _dateOfBirthTextController = TextEditingController();
  TextEditingController _locationTextController = TextEditingController();
  // TextEditingController _emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullnameTextControler.dispose();
    _dateOfBirthTextController.dispose();
    _locationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Profile"),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _fullnameTextControler,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Please enter your Username",
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
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
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
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
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Please enter your Date of Birth",
                      labelText: "Date Of Birth",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
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
                      controller: _locationTextController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Please enter your Location",
                        labelText: "Location",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
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
                  height: 50,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: _auth.currentUser!.email.toString(),
                    // controller: _emailTextController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      // hintText: "Please enter your email address",
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
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
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () async {
                        try {
                          final user = _auth.currentUser;
                          CollectionReference ref =
                              FirebaseFirestore.instance.collection('users');

                          String docId = ref.doc().id;
                          setState(() {
                            docId = _auth.currentUser!.uid.toString();
                            user!.updateDisplayName(
                                _fullnameTextControler.toString());
                          });

                          await ref.doc(docId).set({
                            'fullName': _fullnameTextControler.text,
                            'date of birth': _dateOfBirthTextController.text,
                            'Location': _locationTextController.text,
                          }, SetOptions(merge: true));
                          print(_auth.currentUser!.uid);
                          print(docId);
                          Navigator.pop(context);
                        } catch (error) {
                          print(error);
                        }
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
