import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class IconButtonBack extends StatelessWidget {
  const IconButtonBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () => context.pop(),
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }
}