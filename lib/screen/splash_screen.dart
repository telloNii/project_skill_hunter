import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static final String id = "splash screen router";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.shortestSide,
        height: MediaQuery.of(context).size.longestSide,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background_image.jpg"),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: Text("Sign Up/Sign In"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
