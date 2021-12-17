import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/view_card_screen.dart';

// ignore: must_be_immutable
class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget({
    required final String image,
    required final String fullName,
    required final String email,
  })  : _image = image,
        _fullName = fullName,
        _email = email;
  late final String _image, _fullName, _email;
  bool _isMe = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_email == _auth.currentUser!.email) {
      _isMe = true;
    }

    return Visibility(
      visible: _isMe ? false : true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 3.0,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ViewCardScreen.id);
          },
          child: Card(
            elevation: 5,
            shadowColor: Color(0x55ffffff),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(_image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fullName,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(_email),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
