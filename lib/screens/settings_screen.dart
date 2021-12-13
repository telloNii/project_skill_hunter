import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static final String id = "settings screen route";
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
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text("Settings"),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.person_rounded),
                title: Text("Update profile"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Notifications"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.security_rounded),
                title: Text("Security"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
