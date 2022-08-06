import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  var box = await Hive.openBox('faves');

  box.put("b", "b");
  box.put("c", "c");
  box.put("a", "a");

  print(box.values.toList());
}
