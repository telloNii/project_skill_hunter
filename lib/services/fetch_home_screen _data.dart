import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/widgets/home_screen_widget.dart';

final _firestore = FirebaseFirestore.instance;

class FetchDatabaseData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection('Menu').snapshots(),
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
              final userImage = menuItem.data()["Image"];
              final email = menuItem.data()['Email'];
              final fullName = menuItem.data()['Full name'];
              final location = menuItem.data()['Location'];

              final menuItemWidget = HomeScreenWidget(
                  image: userImage, fullName: fullName, email: email);
              menuItemWidgets.add(menuItemWidget);

              // print(menuItemPrice);
            }
          }
          return Container(
              height: MediaQuery.of(context).size.longestSide,
              child: ListView(reverse: false, children: menuItemWidgets));
        });
  }
}
