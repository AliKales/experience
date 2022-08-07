import 'package:collection/collection.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:flutter/material.dart';

class MotelItemExperienceProvider with ChangeNotifier {
  List<ModelItemExperience> homePageItems = [];

  void addToHomePageItems(List<ModelItemExperience> items) {
    homePageItems += items;

    notifyListeners();
  }

  ModelItemExperience? getModelItemEXperience(String id) {
    return homePageItems.firstWhereOrNull((element) => element.id == id);
  }
}
