import 'package:experiences/library/providers/item_experiences_provider.dart';
import 'package:experiences/library/services/firebase/firestore_firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin MixinItems<T extends StatefulWidget> on State<T> {
  bool get isHome;

  bool isLoadMore = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getExperiences();
  }

  void loadMore() async {
    if (!isLoadMore) return;

    isLoadMore = false;

    _getExperiences();
  }

  void _getExperiences() {
    FirestoreFirebase.getExperiences(context: context).then((value) {
      if (value.isNotEmpty) isLoadMore = true;

      Provider.of<MotelItemExperienceProvider>(context, listen: false)
          .addToHomePageItems(value);
    });
  }
}
