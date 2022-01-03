import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/profile_screen.dart';
import 'package:project_skill_hunter/screens/search_screen.dart';
import 'package:project_skill_hunter/services/fetch_home_screen%20_data.dart';
import 'package:project_skill_hunter/widgets/appbar_widget.dart';

import '../constants.dart';

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
    List displayScreen = [
      ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Popular skills",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          FetchDatabaseData(),
        ],
      ),
      SearchScreen(),
      ProfileScreen()
    ];
    List displayAppBar = [appBar(context: context), null, null];
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
