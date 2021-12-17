import 'package:flutter/material.dart';

class ViewCardScreen extends StatelessWidget {
  static final String id = "view card screen route";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.longestSide * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://nationofbillions.com/wp-content/uploads/2016/11/6lack-3-2560x1440.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Todd Nelson",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in "),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Skills",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
