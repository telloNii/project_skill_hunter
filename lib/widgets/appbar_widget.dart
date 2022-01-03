import 'package:flutter/material.dart';

import '../constants.dart';

AppBar appBar({required BuildContext context}) {
  return AppBar(
    toolbarHeight: 100,
    elevation: 2,
    backgroundColor: Colors.brown,
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "Skill Hunter",
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.shortestSide * 0.9,
          child: TextField(
            strutStyle: StrutStyle(height: 1.550),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            decoration: textFieldInputDecoration.copyWith(
              hintText: "Search Services",
              hintTextDirection: TextDirection.ltr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
