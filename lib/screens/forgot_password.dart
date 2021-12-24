import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/constants.dart';

class ForgotPassword extends StatefulWidget {
  static final String id = "forgot password route";
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String userEmail;
  bool resetError = false;
  double _onErrorBoxResize() {
    if (resetError == false) {
      return 50;
    } else {
      return 70;
    }
  }

  TextEditingController? _emailTextEditingController = TextEditingController();
  String? errorText;
  @override
  void dispose() {
    _emailTextEditingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.longestSide * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Text("Forgot Password", style: authPageHeaderTextStyle.copyWith(color: Colors.black)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: _onErrorBoxResize(),
                      child: TextFormField(
                        controller: _emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFieldInputDecoration,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "A password reset link will be sent to your email address.",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12),
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
                              if (_emailTextEditingController!.text.contains("@")) {
                                await _auth.sendPasswordResetEmail(
                                  email: _emailTextEditingController!.text,
                                );
                                Navigator.pop(context);
                              }
                            } catch (error) {
                              print(error);
                              setState(() {
                                resetError = true;
                                errorText = "Email not registered ";
                              });
                            }
                          },
                          child: Text(
                            "Send",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
