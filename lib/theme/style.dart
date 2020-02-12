import 'package:flutter/material.dart';

ThemeData appTheme() {
//  return ThemeData(
//    primaryColor: Colors.white,
//    accentColor: Colors.orange,
//    hintColor: Colors.white,
//    dividerColor: Colors.white,
//    buttonColor: Colors.white,
//    scaffoldBackgroundColor: Colors.black,
//    canvasColor: Colors.black,
//    primarySwatch: Colors.blue,
//  );

  return ThemeData.dark();
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
