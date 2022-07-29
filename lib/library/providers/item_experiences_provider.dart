import 'package:experiences/library/models/model_item_experience.dart';
import 'package:flutter/material.dart';

class MotelItemExperienceProvider with ChangeNotifier {
  List<ModelItemExperience> homePageItems = [];
  List<ModelItemExperience> followsPageItems = [];

  void addToHomePageItems(List<ModelItemExperience> items) {
    homePageItems += items;

    notifyListeners();
  }

  void addToFollowsPageItems(List<ModelItemExperience> items) {
    homePageItems += items;

    notifyListeners();
  }
}
