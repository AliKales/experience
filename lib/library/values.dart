import 'package:flutter/material.dart';

const cRadius = 10.0;

const cPrimaryColor = Color(0xFFe9e8f1);
const cSecondoryColor = Color.fromARGB(255, 133, 131, 155);

const cSearchDelay = Duration(milliseconds: 1500);

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
  high;

  static List<String> getAsList() {
    return Recommendations.values.map((e) => e.name).toList();
  }
}
