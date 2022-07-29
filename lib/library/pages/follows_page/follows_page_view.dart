import 'package:experiences/library/componets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FollowsPageView extends StatelessWidget {
  const FollowsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(text: "Following", leadingIcon: Icons.favorite),
      
    );
  }
}
