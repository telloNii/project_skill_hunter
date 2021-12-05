import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_skill_hunter/screen/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  static final String id = "sign in screen route";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
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
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Please enter your Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                obscureText: obscureText,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: "Please enter your Password",
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
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
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
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: () {},
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
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Image.asset(
                                          "images/apple logo.png",
                                          height: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: OutlinedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "Sign in with facebook",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: OutlinedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "Sign in with google",
                                            style:
                                                TextStyle(color: Colors.white),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
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
