import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/home_screen.dart';
import 'package:project_skill_hunter/screens/authentication/onboarding_screen_wizard.dart';
import 'package:project_skill_hunter/screens/settings/update_profile_screen.dart';
import 'package:project_skill_hunter/screens/settings_screen.dart';
import 'package:project_skill_hunter/screens/authentication/signin_screen.dart';
import 'package:project_skill_hunter/screens/authentication/signup_screen.dart';
import 'package:project_skill_hunter/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_skill_hunter/screens/view_card_screen.dart';

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
        SignInScreen.id: (context) => SignInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        OnBoardWizard.id: (context) => OnBoardWizard(),
        SettingsScreen.id: (context) => SettingsScreen(),
        UpdateProfileScreen.id: (context) => UpdateProfileScreen(),
        ViewCardScreen.id: (context) => ViewCardScreen(),
      },
      initialRoute: SplashScreen.id,
    );
  }
}
