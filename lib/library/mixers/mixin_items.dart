import 'package:experiences/library/providers/item_experiences_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin MixinItems<T extends StatefulWidget> on State<T> {
  bool get isHome;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("object");
    // Provider.of<MotelItemExperienceProvider>(context, listen: false)
    //     .addToHomePageItems([]);
  }
}
