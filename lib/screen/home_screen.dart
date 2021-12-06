import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screen/profile_screen.dart';
import 'package:project_skill_hunter/screen/search_screen.dart';
import 'package:project_skill_hunter/widgets/home_screen_widget.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "home screen route";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomNavBarIndex = 0;
  void newIndex(int index) {
    setState(() {
      bottomNavBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List displayScreeen = [
      Container(
        height: MediaQuery.of(context).size.longestSide,
        child: ListView(
          children: [
            HomeScreenWidget(
              image: 'images/background_image.jpg',
              fullName: 'Todd Nelson',
              email: 'tello_nii@outlook.com',
            ),
          ],
        ),
      ),
      SearchScreen(),
      ProfileScreen()
    ];
    List displayAppBar = [
      AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Skill Hunter",
          style: TextStyle(color: Colors.black),
        ),
      ),
      null,
      null
    ];
    return Scaffold(
      appBar: displayAppBar[bottomNavBarIndex],
      body: displayScreeen[bottomNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: newIndex,
        currentIndex: bottomNavBarIndex,
        selectedItemColor: Colors.brown,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search_sharp), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_sharp), label: ""),
        ],
      ),
    );
  }
}
