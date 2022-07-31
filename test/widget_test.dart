import 'dart:convert';

import 'package:experiences/library/models/model_item_experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String response = await rootBundle.loadString('assets/jsons/countries.json');
  final data = await json.decode(response);
  List _items = data["items"];

  print(_items);
}
