import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_skill_hunter/screens/authentication/forgot_password.dart';
import 'package:project_skill_hunter/screens/authentication/onboarding_screen_wizzard_skills.dart';
import 'package:project_skill_hunter/screens/homeScreenRoutes/home_screen.dart';
import 'package:project_skill_hunter/screens/authentication/onboarding_screen_wizard.dart';
import 'package:project_skill_hunter/screens/authentication/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  static final String id = "sign in screen route";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController? _emailTextController = TextEditingController();
  final TextEditingController? _passwordTextController = TextEditingController();

  bool obscureText = true;
  late String userEmail;
  late String userPassword;
  bool resetError = false;
  double _onErrorBoxResize() {
    if (resetError == false) {
      return 50;
    } else {
      return 70;
    }
  }

  String? errorText;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController!.dispose();
    _passwordTextController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
            Color(0xFFFFdab9),
            Color(0xFFb0e0e6),
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: _emailTextController,
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.lightBlue),
                                    hintText: "Please enter your Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: _onErrorBoxResize(),
                                child: TextFormField(
                                  controller: _passwordTextController,
                                  obscureText: obscureText,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    labelText: "Password",
                                    hintText: "Please enter your Password",
                                    errorText: errorText,
                                    labelStyle: TextStyle(color: Colors.lightBlue),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (obscureText == true) {
                                          setState(() {
                                            obscureText = false;
                                          });
                                        } else {
                                          setState(() {
                                            obscureText = true;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.visibility),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.black)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: OutlinedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.black),
                                    ),
                                    onPressed: () async {
                                      try {
                                        if (_emailTextController!.value.text.isNotEmpty &&
                                            _emailTextController!.text.contains("@") &&
                                            _passwordTextController!.text.isNotEmpty) {
                                          await _auth.signInWithEmailAndPassword(
                                              email: _emailTextController!.text,
                                              password: _passwordTextController!.text);
                                          var document = await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(_auth.currentUser!.uid.toString())
                                              .get();

                                          if (_auth.currentUser != null &&
                                              document.get("isFullyRegistered") == true &&
                                              document.get("isSkillRegistered") == true) {
                                            Navigator.pushNamed(context, HomeScreen.id);
                                          } else if (_auth.currentUser != null &&
                                              document.get("isFullyRegistered") == false &&
                                              document.get("isSkillRegistered") == false) {
                                            Navigator.pushNamed(context, OnBoardWizard.id);
                                          } else if (_auth.currentUser != null &&
                                              document.get("isFullyRegistered") == true &&
                                              document.get("isSkillRegistered") == false) {
                                            Navigator.pushNamed(context, SkillsOnBoardWizard.id);
                                          }
                                        }
                                      } catch (errorIdentifier) {
                                        setState(() {
                                          resetError = true;
                                          errorText = "incorrect email or password";
                                          _passwordTextController!.clear();
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                            Text("or via social networks"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: OutlinedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.black),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Image.asset(
                                            "images/apple logo.png",
                                            height: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(
                                            "Sign in with Apple",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(
                                height: 40.0,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: OutlinedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.black),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Sign in with facebook",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: OutlinedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.black),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Sign in with google",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Color(0x00000000),
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Color(0x00000000),
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: ForgotPassword(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
