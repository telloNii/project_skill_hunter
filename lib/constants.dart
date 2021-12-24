import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.white),
  hintText: "Please enter your ",
  fillColor: Colors.grey.withOpacity(0.4),
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black)),
);

TextStyle authPageHeaderTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white);

const TextStyle textFieldLabel = TextStyle(color: Color(0xFFA18975), fontSize: 16);
TextStyle unselectedAuthPageHeaderTextStyle =
    authPageHeaderTextStyle.copyWith(fontWeight: FontWeight.w300);
