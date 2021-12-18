import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/settings/update_profile_screen.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          child: Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, UpdateProfileScreen.id);
                  },
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
      ),
    );
  }
}
