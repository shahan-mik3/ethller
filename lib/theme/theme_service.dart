import 'package:flutter/material.dart';

class ThemeService {
  static ThemeData darkTheme = ThemeData(
    backgroundColor: Color(0xFF16162F),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white, fontSize: 18),
      headline1: TextStyle(color: Colors.white, fontSize: 24),
    ),
    appBarTheme: AppBarTheme(
      color: Color(0xFF16162F),
      elevation: 0,
    ),
    scaffoldBackgroundColor: Color(0xFF16162F),
    canvasColor: Color(0xFF16162F),
  );
}
