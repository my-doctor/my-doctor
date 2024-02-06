import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color mainColor = Color(0xff5599ff);
const Color mainColor2 = Color(0xff5e2ef4);
const Color mainColor3 = Color(0xffEFFFFD);
const Color mainColor4 = Color(0xff548CFF);
const Color yelloo = Color(0xffF0A500);
const Color white = Color(0xffffffff);
const Color black = Colors.black87;
const Color hentText = Colors.white54;
const Color homeBackGroundColor = Color(0xffFEF9EF);
const Color darkGrey = Color(0xff393E46);
const Color grey = Colors.grey;

class ThemesApp {
  static final light = ThemeData(useMaterial3: false,
    scaffoldBackgroundColor: homeBackGroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: homeBackGroundColor,
      titleTextStyle: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
          fontFamily: "Cairo"),
    ),
    canvasColor: Colors.grey[200],
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          fontFamily: "Cairo"),
      headline2: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
          fontSize: 20,
          fontFamily: "Cairo"),

      headline3: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 17,
          fontFamily: "Cairo"),
      headline4: TextStyle(
          color: darkGrey.withOpacity(.7),
          fontWeight: FontWeight.w500,
          fontSize: 14),
      // Add more text styles as needed
    ),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    cardColor: mainColor3,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: homeBackGroundColor,
      unselectedItemColor: darkGrey,
      selectedItemColor: mainColor2,
    ),
  );

  static final dark = ThemeData(useMaterial3: false,
    scaffoldBackgroundColor: Color(0xFF18191A),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF242526),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 20,
          fontFamily: "Cairo"),
    ),
    canvasColor: Color(0xFF242526),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          fontFamily: "Cairo"),
      headline2: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 20,
          fontFamily: "Cairo"),
      headline3: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
          fontSize: 17,
          fontFamily: "Cairo"),
      headline4: TextStyle(
          color: Colors.white38, fontWeight: FontWeight.w500, fontSize: 14),
      // Add more text styles as needed
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    cardColor: Color(0xFF242526),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF242526),
      unselectedItemColor:  Colors.grey,
      selectedItemColor: Colors.lightBlueAccent,
    ),
  );
}
