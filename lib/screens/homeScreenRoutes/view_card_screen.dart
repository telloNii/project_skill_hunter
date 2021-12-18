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
        body: FetchViewUserData(
      image: image,
      name: name,
      description: description,
      userID: userID,
    ));
  }
}
