import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_skill_hunter/screens/view_card_screen.dart';

// ignore: must_be_immutable
class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget({
    required final String image,
    required final String fullName,
    required final String email,
    required final String description,
    required final String userID,
  })  : _image = image,
        _fullName = fullName,
        _email = email,
        _description = description,
        _userID = userID;
  String? _image, _fullName, _email, _description, _userID;
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
            print(_userID);
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return ViewCardScreen(
                  userID: _userID!,
                  name: _fullName!,
                  description: _description!,
                  image: _image!,
                );
              },
            ));
          },
          child: Card(
            elevation: 5,
            shadowColor: Color(0x55ffffff),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(_image!),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fullName!,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(_email!),
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
