import 'package:flutter/material.dart';

final appTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Color(0xAA121212),
    primarySwatch: Colors.blue,
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 16, color: Colors.white),
      bodyText2: TextStyle(fontSize: 14, color: Colors.white),
      caption: TextStyle(fontSize: 12, color: Colors.white),
    ));
