import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/auth_screen.dart';
import 'package:project_skill_hunter/screens/onboarding_screen_wizzard_skills.dart';
import 'package:project_skill_hunter/screens/home_screen.dart';
import 'package:project_skill_hunter/screens/onboarding_screen_wizard.dart';
import 'package:project_skill_hunter/screens/update_profile_screen.dart';
import 'package:project_skill_hunter/screens/settings_screen.dart';
import 'package:project_skill_hunter/screens/signin_screen.dart';
import 'package:project_skill_hunter/screens/signup_screen.dart';
import 'package:project_skill_hunter/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SkillHunter());
}

class SkillHunter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        OnBoardWizard.id: (context) => OnBoardWizard(),
        SettingsScreen.id: (context) => SettingsScreen(),
        UpdateProfileScreen.id: (context) => UpdateProfileScreen(),
        SkillsOnBoardWizard.id: (context) => SkillsOnBoardWizard(),
        AuthScreen.id: (context) => AuthScreen()
      },
      initialRoute: SplashScreen.id,
    );
  }
}
