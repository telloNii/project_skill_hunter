import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                      "Todd Nelson",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "SourceSansPro"),
                    ),
                    Text("tello_nii@outlook.com"),
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
                          leading: Icon(
                            Icons.logout,
                          ),
                          title: Text("Sign Out"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: () {},
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
