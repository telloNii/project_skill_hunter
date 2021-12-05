import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screen/signin_screen.dart';
import 'package:project_skill_hunter/screen/splash_screen.dart';

void main() {
  runApp(SkillHunter());
}

class SkillHunter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        SignInScreen.id: (context) => SignInScreen(),
      },
      initialRoute: SplashScreen.id,
    );
  }
}
