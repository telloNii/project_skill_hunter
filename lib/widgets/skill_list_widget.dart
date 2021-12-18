import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListCard extends StatelessWidget {
  ListCard({
    required final String skillTitle,
  }) : _skillTitle = skillTitle;
  String? _skillTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_skillTitle!),
    );
  }
}
