import 'package:flutter/material.dart';
import 'package:project_skill_hunter/services/fetch_view_card_screen_data.dart';

class ViewCardScreen extends StatelessWidget {
  ViewCardScreen(
      {required this.image,
      required this.description,
      required this.name,
      required this.userID});
  static final String id = "view card screen route";
  late final String image, description, name, userID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.longestSide * 0.45,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: FetchViewUserData(
            image: image,
            name: name,
            description: description,
            userID: userID,
          ),
        ),
      ],
    ));
  }
}
