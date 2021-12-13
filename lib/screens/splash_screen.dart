import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/authentication/signin_screen.dart';

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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.shortestSide,
                height: 35,
                child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.id);
                  },
                  child: Text(
                    "Sign Up/Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
