import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListCard extends StatelessWidget {
  ListCard({
    required final String skillTitle,
  }) : _skillTitle = skillTitle;
  String? _skillTitle;
  bool visibility = true;
  bool isVisible() {
    if (_skillTitle == "") {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible(),
      child: Card(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _skillTitle!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
