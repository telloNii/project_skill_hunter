import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/widgets/home_screen_widget.dart';

final _firestore = FirebaseFirestore.instance;

class FetchDatabaseData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection('users').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          List<Widget> menuItemWidgets = [];
          // displaying a circular progress indicator when fetch data or when no data is available
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue.shade900,
              ),
            );
          } else {
            final menuItems = snapshot.data!.docs.reversed;

            for (var menuItem in menuItems) {
              final userImage = menuItem.data()["image"];
              final email = menuItem.data()['email'];
              final fullName = menuItem.data()['fullName'];
              final userID = menuItem.data()['id'];
              final description = menuItem.data()['aboutMe'];

              final menuItemWidget = HomeScreenWidget(
                userID: userID,
                image: userImage,
                fullName: fullName,
                email: email,
                description: description!,
              );
              menuItemWidgets.add(menuItemWidget);

              // print(menuItemPrice);
            }
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.longestSide * 0.40,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    reverse: false,
                    children: menuItemWidgets)),
          );
        });
  }
}
