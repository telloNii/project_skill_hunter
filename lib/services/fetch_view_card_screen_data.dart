import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/widgets/skill_list_widget.dart';

final _firestore = FirebaseFirestore.instance;

class FetchViewUserData extends StatelessWidget {
  FetchViewUserData(
      {required this.image,
      required this.description,
      required this.name,
      required this.userID});
  late final String image, description, name, userID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore
            .collection('users/')
            .doc(userID)
            .collection("skills")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          List<Widget> cardItemWidgets = [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Skills",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ];
          // displaying a circular progress indicator when fetch data or when no data is available
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue.shade900,
              ),
            );
          } else {
            final cardItems = snapshot.data!.docs.reversed;

            for (var cartItemData in cardItems) {
              final skillTitle = cartItemData.data()["skill"];
              final cardItemWidget = ListCard(
                skillTitle: skillTitle,
              );
              cardItemWidgets.add(cardItemWidget);

              // print(menuItemPrice);
            }
          }
          return Container(
              // height: MediaQuery.of(context).size.longestSide,
              child: ListView(
                  padding: EdgeInsets.all(0),
                  reverse: false,
                  children: cardItemWidgets));
        });
  }
}
