import 'package:flutter/material.dart';

const cPagePadding = EdgeInsets.fromLTRB(17.0, 0, 17.0, 17.0);
const cPagePaddingWithTop = EdgeInsets.fromLTRB(17.0, 17.0, 17.0, 17.0);
const cRadius = 10.0;

const cBackgroundColor = Color(0xFF222831);
const cButtonColor = Color(0xFF108DA8);
const cButtonTextColor = Color.fromARGB(255, 255, 255, 255);

const cSecondryColor = Color(0xFF5C6572);

const cIconColor = Color(0xFFC2C2C2);

const cTextColor = Color(0xFFFFFFFF);
const cTextFieldColor = Color(0xFFF1F1F1);

const cSearchDelay = Duration(milliseconds: 1500);

const dividerTheme = DividerThemeData(color: cSecondryColor, thickness: 2);

const appBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  iconTheme: iconTheme,
);

const iconTheme = IconThemeData(
  color: Colors.white,
);

enum ServiceStatus {
  empty,
  loading,
  done,
  error,
}

enum Accommodation {
  hotel,
  room,
  apartment,
  house,
  villa;

  static List<String> getAsList() {
    return Accommodation.values.map((e) => e.name).toList();
  }
}

enum Recommendations {
  low,
  medium,
  high,
}

extension AccommodationExtension on Accommodation {}
