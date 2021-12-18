import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/profileScreenRoutes/settings_screen.dart';
import 'package:project_skill_hunter/screens/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var userName;

  void User() async {
    var document = await FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid.toString())
        .get();
    userName = await document.get("fullName");
    _firebaseAuth.currentUser!.updateDisplayName(userName);
  }

  @override
  void initState() {
    User();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8.0, top: 50.0),
          height: MediaQuery.of(context).size.height * 0.25,
          color: Colors.brown,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("images/background_image.jpg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_firebaseAuth.currentUser!.displayName}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "SourceSansPro"),
                    ),
                    Text(
                      _firebaseAuth.currentUser!.email.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          onTap: () async {
                            await _firebaseAuth.signOut();
                            Navigator.pushNamed(context, SplashScreen.id);
                          },
                          leading: Icon(
                            Icons.logout,
                          ),
                          title: Text("Sign Out"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, SettingsScreen.id);
                          },
                          leading: Icon(Icons.settings),
                          title: Text("Settings"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Text(
                    "General",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.language_sharp),
                          title: Text("Language"),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.info_outlined),
                          title: Text("About"),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.rule_rounded),
                          title: Text("Terms of Service"),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.privacy_tip),
                          title: Text("Privacy Policy"),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.support),
                          title: Text("Support"),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
