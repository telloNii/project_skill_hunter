import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/profile_screen.dart';
import 'package:project_skill_hunter/screens/search_screen.dart';
import 'package:project_skill_hunter/services/fetch_home_screen%20_data.dart';

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
    List displayScreen = [FetchDatabaseData(), SearchScreen(), ProfileScreen()];
    List displayAppBar = [
      AppBar(
        elevation: 2,
        backgroundColor: Colors.brown,
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
      body: displayScreen[bottomNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: newIndex,
        currentIndex: bottomNavBarIndex,
        selectedItemColor: Colors.brown,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_sharp), label: ""),
        ],
      ),
    );
  }
}
