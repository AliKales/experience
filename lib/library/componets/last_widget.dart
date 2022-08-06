import 'package:flutter/material.dart';

class LastWidget extends StatelessWidget {
  const LastWidget({Key? key, required this.onShown, required this.child})
      : super(key: key);

  final VoidCallback onShown;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    print("obje");
    onShown();
    return child;
  }
}
